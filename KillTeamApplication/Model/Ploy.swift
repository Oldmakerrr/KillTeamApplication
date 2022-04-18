//
//  Ploy.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct Ploy: Codable {
    let name: String
    let description: String
    let cost: Int
    let type: PloyType
    let subText: [String]?
    let passiveAbilities : UnitAbilitie?
    let abilities: UnitUniqueAction?
    let wargear: Weapon?
}

enum PloyType: String, Codable {
    case strategic
    case tactical
}

extension Ploy: Equatable {
    static func == (lhs: Ploy, rhs: Ploy) -> Bool {
        lhs.name == rhs.name
    }
}
