//
//  UINavigationBar.swift
//  KillTeamApplication
//
//  Created by Apple on 05.06.2022.
//

import UIKit

extension UINavigationBar {
    
    func clearNavigationBar(exept nonRemoveViews:[UIView]? = nil) {
        guard let nonRemoveViews = nonRemoveViews else {
            subviews.forEach { view in
                view.removeFromSuperview()
            }
            return
        }
        subviews.forEach { view in
            if !nonRemoveViews.contains(where: { nonRemoveView in
                nonRemoveView == view
            }) {
                view.removeFromSuperview()
            }
        }
    }
}
