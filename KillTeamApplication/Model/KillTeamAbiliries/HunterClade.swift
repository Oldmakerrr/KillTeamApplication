//
//  HunterClade.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

struct HunterCladeAbility: Codable, KillTeamAbility {
    
    let name: String
    let description: [String]
    let imperatives: [Imperative]
    
    struct Imperative: Codable {
        let name: String
        let id: String
        let optimisation: String
        let deprecation: String
    }
}

