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
                blurEffectView.topAnchor.constraint(equalTo: topAnchor),
                blurEffectView.widthAnchor.constraint(equalTo: widthAnchor),
                blurEffectView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        } else {
            backgroundColor = ColorScheme.shared.theme.viewBackground
        }
    }
}
