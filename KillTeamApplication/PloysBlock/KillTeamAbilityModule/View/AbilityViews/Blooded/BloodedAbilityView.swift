//
//  BloodedAbilityView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.07.2022.
//

import Foundation

class BloodedAbilityView: KillTeamAbilitieView {
    
    func setupAbility(ability: BloodedAbility) {
        setupHeader(title: ability.name)
        setupDescription(text: ability.description)
        setupTextView(text: ability.title)
        addSubTextPointView(subText: ability.subTexts)
        ability.rules.forEach{ self.setupTextView(text: $0) }
    }
}
