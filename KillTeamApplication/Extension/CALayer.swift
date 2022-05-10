//
//  CALayer.swift
//  KillTeamApplication
//
//  Created by Apple on 08.05.2022.
//

import UIKit

extension CALayer {
    
    func applyBorder(widht: CGFloat = Constant.Size.borderWidht,
                     color: CGColor = ColorScheme.shared.theme.cellBorder.cgColor) {
        
        borderWidth = widht
        borderColor = color
    }
    
    func applyCornerRadius(radius: CGFloat = Constant.Size.cornerRadius) {
        masksToBounds = false
        cornerRadius = radius
    }
    
    func applyCornerRadiusRound(view: UIView) {
        layoutIfNeeded()
        let widthView = view.frame.size.width
        masksToBounds = false
        cornerRadius = widthView/2
    }
    
    func applySketchShadow(
        color: UIColor = ColorScheme.shared.theme.shadow,
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = 1,
        blur: CGFloat = 4
    )
    {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}
