//
//  HunterCadre.swift
//  KillTeamApplication
//
//  Created by Apple on 26.04.2022.
//

import Foundation

struct HunterCadreAbility: Codable, KillTeamAbility {
    
    let title: String
    let rule: DronesRule
    let uniqueAction: UniqueAction
    let abilities: [Abilitie]
    
    struct DronesRule: Codable {
        let text: String
        let dronesList: [String]
        let postText: String
    }
    
    struct UniqueAction: Codable {
        let name: String
        let cost: Int
        let description: [String]
    }
    
    struct Abilitie: Codable {
        let name: String
        let subText: [String]?
        let text: [String]?
    }
}
