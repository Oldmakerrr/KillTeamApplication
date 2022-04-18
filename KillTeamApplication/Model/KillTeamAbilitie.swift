//
//  KillTeamAbilitie.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct KillTeamAbilitie: Codable{
    let name: String
    let description: String
    let subText: [String]?
    let cost: Int?
    let weapon: Weapon?
}
