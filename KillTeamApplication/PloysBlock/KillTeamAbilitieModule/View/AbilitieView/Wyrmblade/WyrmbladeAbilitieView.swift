//
//  WyrmbladeAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class WyrmbladeAbilitieView: KillTeamAbilitieView {
    
    func setupAbilitie(abilitie: WyrmbladeAbilitie) {
        abilitie.rules.forEach { rule in
            setupRule(rule: rule)
        }
    }
    
    private func setupRule(rule: WyrmbladeAbilitie.Rule) {
        setupHeader(title: rule.name)
        setupDescription(text: rule.description)
        rule.rules.forEach { rule in
            setupTextView(text: rule)
        }
        if let subText = rule.subText {
            addSubTextPointView(subText: subText)
        }
    }
}
