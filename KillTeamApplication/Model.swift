//
//  Model.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

struct Faction: Decodable {
    let name: String
    let killTeam: [KillTeam]
}

struct KillTeam: Codable {
    let killTeamName: String
    let factionName: String
    var userCustomName: String?
    var id: String?
    let countOfFireTeam: Int
    let factionLogo: String
    let fireTeam: [FireTeam]
    var choosenFireTeam: [FireTeam] = []
    var counterFT: [String: Int]?
    var choosenUnit: Unit?
    let ploys: [Ploy]
    let abilitiesOfKillTeam: [Abilitie]?
    let equipment: [Equipment]
    var countEquipmentPoint: Int
    let tacOps: [TacOps]?
    var indexOfChoosenUnit: IndexPath?
 }

struct Abilitie: Codable{
    let name: String
    let description: String
    let subText: [String]?
    let cost: Int?
    let weapon: Weapon?
}

struct Ploy: Codable {
    let name: String
    let description: String
    let cost: Int
    let type: String
    let subText: [String]?
    let passiveAbilities : UnitAbilities?
    let abilities: UnitUniqueActions?
    let wargear: Weapon?
    let firstSubText: String?
    let secondSubText: String?
    let thirdSubText: String?
    let fourthSubText: String?
    let fifthSubText: String?
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
    let subText: [String]?
    let uniqueAction: UnitAbilities?
    let unitAction: UnitUniqueActions?
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
    let typeUnit: [String]
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
    var selectedCloseWeapon: Weapon?
    let additionalWeapon: [Weapon]?
    let availableWeapon: [Weapon]?
    var equipment: [Equipment] = []
    let abilities: [UnitAbilities]?
    let uniqueActions: [UnitUniqueActions]?
    let keyWords: [String]
}

protocol AbilitiesProtocol {
    var name: String { get }
    var description: String { get }
    var subText: [String]? { get }
}

struct UnitUniqueActions: Codable, AbilitiesProtocol {
    let name: String
    let cost: Int
    let description: String
    let subText: [String]?
    let wargear: Weapon?
    let postSubText: String?
}

struct UnitAbilities: Codable, AbilitiesProtocol {
    let name: String
    let description: String
    let subText: [String]?
}
protocol WeaponProtocol {
    var name: String { get }
    var profileName: String? { get }
    var type: String { get }
    var attacks: Int { get }
    var ballisticWeaponSkill: Int { get }
    var damage: Int { get }
    var critDamage: Int { get }
    var specialRule: [WeaponSpecialRule]? { get }
    var criticalHitspecialRule: [WeaponSpecialRule]? { get }
}

struct Weapon: Codable, WeaponProtocol {
    let name: String
    let profileName: String?
    let type: String
    let attacks: Int
    let ballisticWeaponSkill: Int
    let damage: Int
    let critDamage: Int
    let specialRule: [WeaponSpecialRule]?
    let criticalHitspecialRule: [WeaponSpecialRule]?
    var secondProfile: [SubProfileWeapon]?
}

struct SubProfileWeapon: Codable, WeaponProtocol {
    let name: String
    let profileName: String?
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

struct WeaponSpecialRule: Codable {
    let name: String
    let description: String
    let subText: [String]?
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
