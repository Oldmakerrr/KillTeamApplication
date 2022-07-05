//
//  Wyrmblade.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

struct WyrmbladeAbility: Codable, KillTeamAbility {
    
    let rules: [Rule]
    
    struct Rule: Codable {
        let name: String
        let description: String
        let rules: [String]
        let subText: [String]?
    }
}
