//
//  HunterCadreSubViewExtension.swift
//  KillTeamApplication
//
//  Created by Apple on 29.04.2022.
//

import UIKit

extension KillTeamAbilitieViewController {
    
    func setupHunterCadreDroneAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = HunterCadreAbilitieView()
        if let abilitie = abilitie as? HunterCadreAbilitie {
            view.setupDroneRule(abilitie: abilitie)
        }
        return view
    }
    
    func setupHunterCadreMarkerlightAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = HunterCadreAbilitieView()
        if let abilitie = abilitie as? HunterCadreAbilitie {
            view.setupUniqueAction(action: abilitie.uniqueAction)
        }
        return view
    }
    
    func setupHunterCadreArtificialIntelligenceAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = HunterCadreAbilitieView()
        if let abilitie = abilitie as? HunterCadreAbilitie {
            view.setupAbiliteRule(abilitie: abilitie.abilities[0])
        }
        return view
    }
    
    func setupHunterCadreSaviourProtocolsAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = HunterCadreAbilitieView()
        if let abilitie = abilitie as? HunterCadreAbilitie {
            view.setupAbiliteRule(abilitie: abilitie.abilities[1])
        }
        return view
    }
    
}
