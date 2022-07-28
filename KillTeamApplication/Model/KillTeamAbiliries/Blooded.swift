//
//  Blooded.swift
//  KillTeamApplication
//
//  Created by Apple on 28.07.2022.
//

import Foundation

struct BloodedAbility: Codable, KillTeamAbility {
    let name: String
    let description: String
    let title: String
    let subTexts: [String]
    let rules: [String]
}
