//
//  Novitiate.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

struct NovitiateAbility: Codable, KillTeamAbility {
    
    let name: String
    let description: String
    let subText: [String]
    let postText: [String]
    let actsOfFaith: [ActOfFaith]
    
    
    struct ActOfFaith: Codable, UnitAbilitieProtocol {
        let name: String
        let id: String
        let description: String
        let cost: Int
        let subText: [String]?
    }
}
