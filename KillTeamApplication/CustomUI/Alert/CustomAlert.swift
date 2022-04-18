//
//  CustomAlert.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

class CustomAlert {
    
    struct Constant {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgrowndView: UIView = {
        let backgrounView = UIView()
        backgrounView.backgroundColor = .black
        backgrounView.alpha = 0
        return backgrounView
    }()
    
    private var viewController: UIViewController?
    private var targetView: UIView?
    private var alertView: UIView?
    
    
    
    init() {
        addGesture()
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.state = .began
        backgrowndView.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(gestureAction))
        swipeGesture.maximumNumberOfTouches = 1
        backgrowndView.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func gestureAction() {
        self.dismissAlert()
    }
    
    func initAlert(alertView: UIView, targetView: UIViewController) {
        self.targetView = targetView.view
        self.alertView = alertView
        self.viewController = targetView
    }
        
    func showAlert(alertView: UIView, targetView: UIViewController) {
        initAlert(alertView: alertView, targetView: targetView)
        guard let viewController = viewController,
              let targetView = self.targetView,
              let alertView = self.alertView else { return }
        backgrowndView.frame = targetView.bounds
        targetView.addSubview(backgrowndView)
        targetView.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.widthAnchor.constraint(equalTo: targetView.widthAnchor, constant: -30),
            alertView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
            alertView.bottomAnchor.constraint(greaterThanOrEqualTo: targetView.topAnchor, constant: -UIScreen.main.bounds.height)
        ])
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgrowndView.alpha = Constant.backgroundAlphaTo
            
        }) { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    guard let tableViewController = viewController as? UITableViewController else {
                        alertView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                        alertView.translatesAutoresizingMaskIntoConstraints = true
                        return
                    }
                    var center = tableViewController.tableView.contentOffset
                    center.x += UIScreen.main.bounds.width/2
                    center.y += UIScreen.main.bounds.height/2
                    alertView.center = center
                    alertView.translatesAutoresizingMaskIntoConstraints = true
                }
            }
        }
    }
    
    func dismissAlert() {
        guard let targetView = self.targetView,
              let alertView = self.alertView else { return }
        UIView.animate(withDuration: 0.25, animations: {
            alertView.translatesAutoresizingMaskIntoConstraints = true
            alertView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: targetView.frame.height*1.5)
                        
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgrowndView.alpha = 0
                }, completion: { done in
                    if done {
                        self.backgrowndView.removeFromSuperview()
                        alertView.removeFromSuperview()
                    }
                })
            }
        })
    }
}

extension CustomAlert: EditUnitProtocol {
    func didComplete(_ EditUnitViewController: EditUnitViewController) {
        dismissAlert()
    }
}

//MARK: - Custom Alert with scroll


class CustomScrollAlert {
    
    struct Constant {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgrowndView: UIView = {
        let backgrounView = UIView()
        backgrounView.backgroundColor = .black
        backgrounView.alpha = 0
        return backgrounView
    }()
    
    private var scrollView = UIScrollView()
    
    private var viewController: UIViewController?
    private var targetView: UIView?
    private var alertView: UIView?
    
    
    
    init() {
        addGesture()
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.state = .began
        backgrowndView.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(gestureAction))
        swipeGesture.maximumNumberOfTouches = 1
        backgrowndView.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func gestureAction() {
        self.dismissAlert()
    }
    
    func initAlert(alertView: UIView, targetView: UIViewController) {
        self.targetView = targetView.view
        self.alertView = alertView
        self.viewController = targetView
    }
        
    func showAlert(alertView: UIView, targetView: UIViewController) {
        scrollView.removeFromSuperview()
        scrollView = UIScrollView()
        initAlert(alertView: alertView, targetView: targetView)
        guard let viewController = viewController,
              let targetView = self.targetView,
              let alertView = self.alertView else { return }
        
        
        backgrowndView.frame = targetView.bounds
        targetView.addSubview(backgrowndView)
        
        
        scrollView.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor),
          //  alertView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor),
            alertView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            alertView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            alertView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        targetView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            scrollView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
            scrollView.heightAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.height - 200),
            scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: targetView.topAnchor, constant: -UIScreen.main.bounds.height)
        ])
        
        
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgrowndView.alpha = Constant.backgroundAlphaTo
            
        }) { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    guard let tableViewController = viewController as? UITableViewController else {
                        self.scrollView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                        self.scrollView.translatesAutoresizingMaskIntoConstraints = true
                        return
                    }
                    var center = tableViewController.tableView.contentOffset
                    center.x += UIScreen.main.bounds.width/2
                    center.y += UIScreen.main.bounds.height/2
                    self.scrollView.center = center
                    self.scrollView.translatesAutoresizingMaskIntoConstraints = true
                }
            }
        }
    }
    
    func dismissAlert() {
        guard let targetView = self.targetView,
              let alertView = self.alertView else { return }
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollView.translatesAutoresizingMaskIntoConstraints = true
            self.scrollView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: targetView.frame.height*1.5)
                        
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgrowndView.alpha = 0
                }, completion: { done in
                    if done {
                        self.backgrowndView.removeFromSuperview()
                        self.scrollView.removeFromSuperview()
                    }
                })
            }
        })
    }
}

extension CustomScrollAlert: EditUnitProtocol {
    func didComplete(_ EditUnitViewController: EditUnitViewController) {
        dismissAlert()
    }
}
