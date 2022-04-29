//
//  WyrmbladeAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class WyrmbladeAbilitieView: KillTeamAbilitieView {
    
    func setupFirstRule(abilitie: WyrmbladeAbilitie) {
        if let firstRule = abilitie.rules.first {
            setupRule(rule: firstRule)
        }
    }
    
    func setupSecondRule(abilitie: WyrmbladeAbilitie) {
        setupRule(rule: abilitie.rules[1])
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
