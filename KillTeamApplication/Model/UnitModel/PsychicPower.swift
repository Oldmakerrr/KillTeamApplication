//
//  PsychicPower.swift
//  KillTeamApplication
//
//  Created by Apple on 25.04.2022.
//

import Foundation

struct PsychicPower: Codable {
    let name: String
    let id: String
    let type: String?
    let description: String
    let subText: [String]?
    let weapon: Weapon?
}
