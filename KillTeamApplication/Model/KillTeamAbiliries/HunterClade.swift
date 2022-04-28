//
//  HunterClade.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

struct HunterCladeAbilitie: Codable, KillTeamAbilitie {
    
    let name: String
    let description: [String]
    let imperatives: [Imperative]
    
    struct Imperative: Codable {
        let name: String
        let optimisation: String
        let deprecation: String
    }
}

