//
//  VeteranGuardsman.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

struct VeteranGuardsmanAbilitie: Codable, KillTeamAbility {
    
    let name: String
    let description: String
    let ancillarySupport: [AncillarySupport]
    let tacticalAssets: [TacticalAssets]
    
    struct AncillarySupport: Codable {
        let name: String
        let description: String
        let listOfTacticalAssets: [String]?
        let postText: String?
    }
    
    struct TacticalAssets: Codable {
        let name: String
        let id: String
        let description: String
        let weapon: Weapon
    }
}
