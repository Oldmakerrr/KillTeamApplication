//
//  Equipment.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct Equipment: Codable {
    let name: String
    let description: String
    let cost: Int
    let maxCounPerKillTeam: Int?
    let body: String?
    let subText: [String]?
    let uniqueAction: UnitAbilitie?
    let unitAction: UnitUniqueAction?
    let wargear: Weapon?
}


extension Equipment: Equatable {
    static func == (lhs: Equipment, rhs: Equipment) -> Bool {
        lhs.name == rhs.name
    }
}
