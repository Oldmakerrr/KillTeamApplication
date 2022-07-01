//
//  Weapon.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

protocol Wargear {
    var name: String { get }
}

protocol WeaponProtocol {
    var name: String { get }
    var profileName: String? { get }
    var type: WeaponType { get }
    var attacks: Int { get }
    var ballisticWeaponSkill: Int { get }
    var damage: Int { get }
    var criticalDamage: Int { get }
    var specialRules: [WeaponSpecialRule]? { get }
    var criticalHitSpecialRules: [WeaponSpecialRule]? { get }
}

struct Weapon: Codable, WeaponProtocol, Wargear {
    let name: String
    let id: String
    let profileName: String?
    let type: WeaponType
    let attacks: Int
    let ballisticWeaponSkill: Int
    let damage: Int
    let criticalDamage: Int
    let specialRules: [WeaponSpecialRule]?
    let criticalHitSpecialRules: [WeaponSpecialRule]?
    let subProfiles: [SubProfileWeapon]?
}

struct SubProfileWeapon: Codable, WeaponProtocol {
    let name: String
    let profileName: String?
    let type: WeaponType
    let attacks: Int
    let ballisticWeaponSkill: Int
    let damage: Int
    let criticalDamage: Int
    let specialRules: [WeaponSpecialRule]?
    let criticalHitSpecialRules: [WeaponSpecialRule]?
}

enum WeaponType: String, Codable {
    case range
    case close
}

extension Weapon: Equatable {
    static func == (lhs: Weapon, rhs: Weapon) -> Bool {
        lhs.id == rhs.id 
    }
}

//MARK: - WeaponSpecialRule

struct WeaponSpecialRule: Codable {
    let name: String
    let description: String
    let subText: [String]?
}
