//
//  Legionary.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

struct LegionaryAbilitie: Codable, KillTeamAbility {
    
    let chaosBlessing: UnitAbilitie
    let favouredOfTheDarkGods: UnitAbilitie
    let chaosBlessings: [UnitAbilitie]
    
}
