//
//  WeaponRuleAlertController.swift
//  KillTeamApplication
//
//  Created by Apple on 26.03.2022.
//

import Foundation
import UIKit

class WeaponRuleAlertController: UIAlertController {
    
    let weaponRuleView = WeaponRuleView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    func setupText(rule: WeaponSpecialRule) {
        weaponRuleView.setupText(title: rule.name, message: rule.description, subText: rule.subText)
        self.view.addSubview(weaponRuleView)
        NSLayoutConstraint.activate([
            weaponRuleView.topAnchor.constraint(equalTo: self.view.topAnchor),
            weaponRuleView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            weaponRuleView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

