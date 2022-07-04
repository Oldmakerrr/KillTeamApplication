//
//  WyrmbladeSubViewExtension.swift
//  KillTeamApplication
//
//  Created by Apple on 29.04.2022.
//

import UIKit

extension KillTeamAbilitieViewController {
    
    func setupWyrmbladeFirstAbilitie(abilitie: KillTeamAbility) -> UIStackView {
        let view = WyrmbladeAbilitieView()
        if let abilitie = abilitie as? WyrmbladeAbility {
            view.setupFirstRule(abilitie: abilitie)
        }
        return view
    }
    
    func setupWyrmbladeSecondAbilitie(abilitie: KillTeamAbility) -> UIStackView {
        let view = WyrmbladeAbilitieView()
        if let abilitie = abilitie as? WyrmbladeAbility {
            view.setupSecondRule(abilitie: abilitie)
        }
        return view
    }
}
