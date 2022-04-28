//
//  UnitAbilitie.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

protocol UnitAbilitieProtocol {
    var name: String { get }
    var description: String { get }
    var subText: [String]? { get }
}

struct UnitUniqueAction: Codable {
    let name: String
    let cost: Int
    let description: String
    let subText: [String]?
    let wargear: Weapon?
    let postSubText: String?
}

struct UnitAbilitie: Codable, UnitAbilitieProtocol {
    let name: String
    let description: String
    let subText: [String]?
}
