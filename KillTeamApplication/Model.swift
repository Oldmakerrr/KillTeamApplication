//
//  Model.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

struct Faction {
    let name: String
    let subFactionName: String
    let killTeam: [KillTeam]
    var userKillTeam: [KillTeam] = []
}

struct KillTeam: Codable {
    let factionName: String
    var id: String?
    var userCustomName: String?
    let killTeamName: String
    let countOfFireTeam: Int
    let factionLogo: String
    var fireTeam: [FireTeam]
    var choosenFireTeam: [FireTeam] = []
    var counterFT: [String: Int] = [:]
    var choosenUnit: Unit?
    let ploys: [Ploy]
    let abilitiesOfKillTeam: [Abilitie]?
    let equipment: [Equipment]
    var countEquipmentPoint = 10
    let tacOps: [TacOps]?
    var indexOfChoosenUnit: IndexPath?
 }

struct Abilitie: Codable{
    let name: String
    let description: String
    let cost: Int?
    let weapon: Weapon?
}

struct Ploy: Codable {
    let name: String
    let description: String
    let cost: Int
    let type: TypeOfPloys
}

enum TypeOfPloys: String, Codable {
    
    case strategic
    case tactical
}

struct FireTeam: Codable {
    let name: String
    let archetype: [String]
    let availableDataslates: [Unit]
    var currentDataslates: [Unit] = []
}

extension FireTeam: Equatable {
    static func == (lhs: FireTeam, rhs: FireTeam) -> Bool {
        lhs.name == rhs.name
    }
}

struct Equipment: Codable {
    let name: String
    let description: String
    let cost: Int
    let maxCounPerKillTeam: Int?
    let body: String?
    let uniqueAction: Abilitie?
    let wargear: Weapon?
}


extension Equipment: Equatable {
    static func == (lhs: Equipment, rhs: Equipment) -> Bool {
        lhs.name == rhs.name
    }
    
    
}

struct Unit: Codable {
    let name: String
    var customName: String?
    let typeUnit: TypeOfUnit
    let description: String
    let portrait: String
    let movement: Int
    let actionPointLimit: Int
    let groupActivation: Int
    let defense: Int
    let save: Int
    let wounds: Int
    //var currentWounds: Int
    var selectedRangeWeapon: Weapon?
    var selectedCloseWeapon: Weapon
    let availableWeapon: [Weapon]?
    var equipment: [Equipment] = []
    let abilities: [UnitAbilities]?
    let uniqueActions: [UnitUniqueActions]?
    let keyWords: [String]
}

struct UnitUniqueActions: Codable {
    let name: String
    let cost: Int
    let description: String
}

struct UnitAbilities: Codable {
    let name: String
    let description: String
}

enum TypeOfUnit: String, Codable {
    case combat
    case staunch
    case marksman
    case scout
}

struct Weapon: Codable {
    let name: String
    let type: String
    let attacks: Int
    let ballisticWeaponSkill: Int
    let damage: Int
    let critDamage: Int
    let specialRule: [WeaponSpecialRule]?
    let criticalHitspecialRule: [WeaponSpecialRule]?
    }

extension Weapon: Equatable {
    static func == (lhs: Weapon, rhs: Weapon) -> Bool {
        lhs.name == rhs.name
    }
    
    
}

struct TwoProfileWeapon {
    let secondProfile: Weapon
    let name: String
    let type: String
    let attacks: Int
    let ballisticWeaponSkill: Int
    let damage: Int
    let critDamage: Int
    let specialRule: [WeaponSpecialRule]?
    let criticalHitspecialRule: [WeaponSpecialRule]?
    }

enum TypeOfWeapon: String, Codable {
    case range
    case close
}

struct WeaponSpecialRule: Codable {
    let name: String
    let description: String
}

struct TacOps: Codable {
    let name: String
    let type: TypeOfTacOps
    let description: String
    let firstCondition: String
    let victoryPointForfirstCondition: Int
    let secondCondition: String?
    let victoryPointSecondCondition: Int?
    let subText: String?
    let uniquiAction: UnitUniqueActions?
    var progreesTacOp = 0
}

extension TacOps: Equatable {
    static func == (lhs: TacOps, rhs: TacOps) -> Bool {
        lhs.name == rhs.name
    }
}

enum TypeOfTacOps: String, Codable {
    case seekandDestroy
    case security
    case infiltration
    case recon
    case special
}
