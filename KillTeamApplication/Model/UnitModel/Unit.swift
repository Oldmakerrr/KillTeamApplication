//
//  Unit.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct Unit: Codable {
    let name: String
    var customName: String?
    let typeUnit: [UnitType]
    let description: String
    let portrait: String
    let movement: Int
    let actionPointLimit: Int
    let groupActivation: Int
    let defense: Int
    let save: Int
    let wounds: Int
    var currentWounds: Int?
    var selectedRangeWeapon: Weapon?
    var selectedCloseWeapon: Weapon?
    let additionalWeapon: [Weapon]?
    let availableWeapon: [Weapon]?
    var equipment: [Equipment] = []
    let abilities: [UnitAbilitie]?
    let uniqueActions: [UnitUniqueAction]?
    let keyWords: [String]
    
    mutating func updateCurrentWounds() {
        currentWounds = wounds
    }
}

enum UnitType: String, Codable {
    case combat
    case staunch
    case marksman
    case scout
}
