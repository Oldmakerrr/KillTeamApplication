//
//  Equipment.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct Equipment: Codable, Wargear {
    let name: String
    let id: String
    let description: String
    let cost: Int
    let maxCounPerKillTeam: Int?
    let additionalText: String?
    let subTexts: [String]?
    let ability: UnitAbilitie?
    let uniqueAction: UnitUniqueAction?
    let weapon: Weapon?
}


extension Equipment: Equatable {
    static func == (lhs: Equipment, rhs: Equipment) -> Bool {
        lhs.id == rhs.id
    }
}
