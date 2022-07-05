//
//  WyrmbladeAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class WyrmbladeAbilitieView: KillTeamAbilitieView {
    
    func setupFirstRule(abilitie: WyrmbladeAbility) {
        if let firstRule = abilitie.rules.first {
            setupRule(rule: firstRule)
        }
    }
    
    func setupSecondRule(abilitie: WyrmbladeAbility) {
        setupRule(rule: abilitie.rules[1])
    }
    
    private func setupRule(rule: WyrmbladeAbility.Rule) {
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
