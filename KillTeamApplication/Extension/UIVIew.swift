//
//  UIVIew.swift
//  KillTeamApplication
//
//  Created by Apple on 10.05.2022.
//

import UIKit

extension UIView {
    
    func setupBlurView(style: UIBlurEffect.Style) {
        if !UIAccessibility.isReduceTransparencyEnabled {
            backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(blurEffectView)
            NSLayoutConstraint.activate([
                blurEffectView.centerXAnchor.constraint(equalTo: centerXAnchor),
                blurEffectView.centerYAnchor.constraint(equalTo: centerYAnchor),
                blurEffectView.widthAnchor.constraint(equalTo: widthAnchor),
                blurEffectView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        } else {
            backgroundColor = ColorScheme.shared.theme.viewBackground
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddinRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -paddinRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func animateSelect() {
        alpha = 0.8
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (finished) in
            self.animateDeselect()
        }
    }
        
    func animateDeselect() {
        alpha = 1.0
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
    
    func animateSelectView(scale: CGFloat = 0.97, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseInOut) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        } completion: { _ in
            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: {
                self.transform = .identity
            }, completion: completion)
        }
    }
}
