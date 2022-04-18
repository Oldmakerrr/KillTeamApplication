//
//  CustomAlert.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

class CustomScrollAlert {
    
    let backgroundAlphaTo: CGFloat = 0.6
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let screenCenter = CGPoint(x: UIScreen.main.bounds.width/2,
                               y: UIScreen.main.bounds.height/2)
    
    var targetViewController: UIViewController?
    
    private let backgrowndView: UIView = {
        let backgrounView = UIView()
        backgrounView.backgroundColor = .black
        backgrounView.alpha = 0
        return backgrounView
    }()
    
    private var scrollView = UIScrollView()

    init() {
        addGesture()
    }
    
    func showAlert(alertView: UIView, targetViewController: UIViewController) {
        self.targetViewController = targetViewController
        guard let targetView = targetViewController.view else { return }
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        backgrowndView.frame = targetView.bounds
        targetView.addSubview(backgrowndView)
        
        setupAlertViewToScrollView(alertView)
        
        setupScrollViewToTargetView(targetView: targetView)
        
        UIView.animate(withDuration: 0.25, animations: { [self] in
            backgrowndView.alpha = backgroundAlphaTo
        }) { done in
            if done {
                UIView.animate(withDuration: 0.25) { [self] in
                    setupAlertViewToCenterScreen(alertView)
                }
            }
        }
    }
    
    func dismissAlert() {
        UIView.animate(withDuration: 0.25, animations: { [self] in
            hideAlertView()
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: { [self] in
                    backgrowndView.alpha = 0
                }, completion: { [self] done in
                    if done {
                        backgrowndView.removeFromSuperview()
                        scrollView.removeFromSuperview()
                    }
                })
            }
        })
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        tapGesture.numberOfTouchesRequired = 1
        backgrowndView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func gestureAction() {
        self.dismissAlert()
        if let tableViewController = targetViewController as? UITableViewController {
            tableViewController.tableView.isScrollEnabled = true
        }
    }
    
    private func setupAlertViewToScrollView(_ alertView: UIView) {
        scrollView.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor),
            alertView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor),
            alertView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            alertView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupScrollViewToTargetView(targetView: UIView) {
        targetView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            scrollView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
            scrollView.heightAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.height - 200),
            scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: targetView.topAnchor, constant: -UIScreen.main.bounds.height)
        ])
    }
    
    private func setupAlertViewToCenterScreen(_ alertView: UIView) {
        let alertViewHeight = alertView.frame.height
        let scrollViewHeight = scrollView.frame.height
        guard let tableViewController = targetViewController as? UITableViewController else {
            var screenCenter = screenCenter
            if alertViewHeight < scrollViewHeight {
                let result = scrollViewHeight/2 - alertViewHeight/2
                screenCenter.y += result
            }
            scrollView.center = screenCenter
            scrollView.translatesAutoresizingMaskIntoConstraints = true
            return
        }
        var contentOffset = tableViewController.tableView.contentOffset
        contentOffset.x += UIScreen.main.bounds.width/2
        if alertViewHeight > scrollViewHeight {
            contentOffset.y += screenHeight/2
        } else {
            let result = scrollViewHeight/2 - alertViewHeight/2
            contentOffset.y += screenHeight/2 + result
        }
        scrollView.center = contentOffset
        scrollView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    private func hideAlertView() {
        guard let tableViewController = targetViewController as? UITableViewController else {
            scrollView.center = CGPoint(x: screenWidth/2,
                                        y: screenHeight + (screenHeight/2))
            scrollView.translatesAutoresizingMaskIntoConstraints = true
            return
        }
        var contentOffset = tableViewController.tableView.contentOffset
        contentOffset.x += screenWidth/2
        contentOffset.y += screenHeight + (screenHeight/2)
        scrollView.center = contentOffset
        scrollView.translatesAutoresizingMaskIntoConstraints = true
    }
        
}

extension CustomScrollAlert: EditUnitProtocol {
    func didComplete(_ EditUnitViewController: EditUnitViewController) {
        dismissAlert()
    }
}
