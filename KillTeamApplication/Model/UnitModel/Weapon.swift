//
//  Weapon.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

protocol WeaponProtocol {
    var name: String { get }
    var profileName: String? { get }
    var type: WeaponType { get }
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
    let type: WeaponType
    let attacks: Int
    let ballisticWeaponSkill: Int
    let damage: Int
    let critDamage: Int
    let specialRule: [WeaponSpecialRule]?
    let criticalHitspecialRule: [WeaponSpecialRule]?
    let secondProfile: [SubProfileWeapon]?
}

struct SubProfileWeapon: Codable, WeaponProtocol {
    let name: String
    let profileName: String?
    let type: WeaponType
    let attacks: Int
    let ballisticWeaponSkill: Int
    let damage: Int
    let critDamage: Int
    let specialRule: [WeaponSpecialRule]?
    let criticalHitspecialRule: [WeaponSpecialRule]?
}

enum WeaponType: String, Codable {
    case range
    case close
}

extension Weapon: Equatable {
    static func == (lhs: Weapon, rhs: Weapon) -> Bool {
        lhs.name == rhs.name
    }
}

//MARK: - WeaponSpecialRule

struct WeaponSpecialRule: Codable {
    let name: String
    let description: String
    let subText: [String]?
}
