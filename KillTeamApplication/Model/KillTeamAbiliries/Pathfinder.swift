//
//  Pathfinder.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

struct PathfinderAbilitie: Codable, KillTeamAbility {
    
    let artificialIntelligence: Abilitie
    let markerlight: MarkerlightRule
    let saviourProtocols: Abilitie
    let pulseWaepon: Abilitie
    let artOfwar: ArtOfWarRule
    
    struct MarkerlightRule: Codable {
        let name: String
        let description: String
        let uniqueAction: UnitUniqueAction
        let rules: [String]
        let markerlightBenefit: [String]
    }
    
    struct ArtOfWarRule: Codable {
        let name: String
        let description: String
        let rule: String
        let artsOfWar: [Abilitie]
    }
    
    struct Abilitie: Codable {
        let name: String
        let rules: [String]
    }
    
}
