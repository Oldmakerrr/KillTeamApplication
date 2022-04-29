//
//  WyrmbladeSubViewExtension.swift
//  KillTeamApplication
//
//  Created by Apple on 29.04.2022.
//

import UIKit

extension KillTeamAbilitieViewController {
    
    func setupWyrmbladeFirstAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = WyrmbladeAbilitieView()
        if let abilitie = abilitie as? WyrmbladeAbilitie {
            view.setupFirstRule(abilitie: abilitie)
        }
        return view
    }
    
    func setupWyrmbladeSecondAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = WyrmbladeAbilitieView()
        if let abilitie = abilitie as? WyrmbladeAbilitie {
            view.setupSecondRule(abilitie: abilitie)
        }
        return view
    }
}
