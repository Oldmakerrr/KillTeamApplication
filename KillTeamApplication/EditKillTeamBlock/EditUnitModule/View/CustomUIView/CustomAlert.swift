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
    
    private var targetView: UIView
    var alertView: UIView
    
    init(alertView: UIView, targetView: UIView) {
        self.targetView = targetView
        self.alertView = alertView
    }
    
 //   lazy var up = CGPoint(x: targetView.bounds.size.width/2, y: targetView.bounds.size.height-1000)
    lazy var down = CGPoint(x: targetView.bounds.size.width/2, y: targetView.bounds.size.height+alertView.bounds.size.height)
        
    func showAlert() {
        backgrowndView.frame = targetView.bounds
        targetView.addSubview(backgrowndView)
        targetView.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -100).isActive = true
        alertView.widthAnchor.constraint(equalTo: targetView.widthAnchor, constant: -50).isActive = true
        alertView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor).isActive = true
        UIView.animate(withDuration: 0.25, animations: {
            self.backgrowndView.alpha = Constant.backgroundAlphaTo
        }) { done in
            if done {
                UIView.animate(withDuration: 0.25) { [self] in
                    alertView.center = targetView.center
                    alertView.translatesAutoresizingMaskIntoConstraints = true
                }
            }
        }
    }
    
    func dismissAlert() {
        UIView.animate(withDuration: 0.25,
                       animations: { [self] in
                        alertView.translatesAutoresizingMaskIntoConstraints = true
                        alertView.center = down
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgrowndView.alpha = 0
                }, completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgrowndView.removeFromSuperview()
                    }
                })
            }
        })
    }
}
