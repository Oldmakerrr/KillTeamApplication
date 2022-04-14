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
