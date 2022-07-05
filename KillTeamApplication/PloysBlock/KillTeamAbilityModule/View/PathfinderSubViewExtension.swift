//
//  PathfinderSubViewExtension.swift
//  KillTeamApplication
//
//  Created by Apple on 29.04.2022.
//

import UIKit

extension KillTeamAbilitieViewController {
    
    func setupPathfinderMarkerlightAbilitie(abilitie: KillTeamAbility) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbility {
            view.setupMarkerlightRule(markerRule: abilitie.markerlight, delegate: self)
        }
        return view
    }
    
    func setupPathfinderArtOfWarAbilitie(abilitie: KillTeamAbility) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbility {
            view.setupArtOfWarRule(artOfWarRule: abilitie.artOfwar)

        }
        return view
    }
    
    func setupPathfinderArtificialIntelligenceAbilitie(abilitie: KillTeamAbility) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbility {
            view.setupAbilitieText(abilitie: abilitie.artificialIntelligence)
        }
        return view
    }
    
    func setupPathfinderPulseWeaponAbilitie(abilitie: KillTeamAbility) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbility {
            view.setupAbilitieText(abilitie: abilitie.pulseWaepon)
        }
        return view
    }
    
    func setupPathfinderSaviourProtocolsAbilitie(abilitie: KillTeamAbility) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbility {
            view.setupAbilitieText(abilitie: abilitie.saviourProtocols)
        }
        return view
    }
    
}
