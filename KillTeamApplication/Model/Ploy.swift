//
//  Ploy.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct Ploy: Codable {
    let name: String
    let id: String
    let description: String
    let cost: Int
    let type: PloyType
    let subTexts: [String]?
    let postSubText: String?
    let ability : UnitAbilitie?
    let uniqueAction: UnitUniqueAction?
    let weapon: Weapon?
}

enum PloyType: String, Codable {
    case strategic
    case tactical
}

extension Ploy: Equatable {
    static func == (lhs: Ploy, rhs: Ploy) -> Bool {
        lhs.id == rhs.id
    }
}
