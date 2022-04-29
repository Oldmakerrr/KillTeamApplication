//
//  PathfinderSubViewExtension.swift
//  KillTeamApplication
//
//  Created by Apple on 29.04.2022.
//

import UIKit

extension KillTeamAbilitieViewController {
    
    func setupPathfinderMarkerlightAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbilitie {
            view.setupMarkerlightRule(markerRule: abilitie.markerlight, delegate: self)
        }
        return view
    }
    
    func setupPathfinderArtOfWarAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbilitie {
            view.setupArtOfWarRule(artOfWarRule: abilitie.artOfwar)

        }
        return view
    }
    
    func setupPathfinderArtificialIntelligenceAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbilitie {
            view.setupAbilitieText(abilitie: abilitie.artificialIntelligence)
        }
        return view
    }
    
    func setupPathfinderPulseWeaponAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbilitie {
            view.setupAbilitieText(abilitie: abilitie.pulseWaepon)
        }
        return view
    }
    
    func setupPathfinderSaviourProtocolsAbilitie(abilitie: KillTeamAbilitie) -> UIStackView {
        let view = PathfinderAbilitieView()
        if let abilitie = abilitie as? PathfinderAbilitie {
            view.setupAbilitieText(abilitie: abilitie.saviourProtocols)
        }
        return view
    }
    
}
