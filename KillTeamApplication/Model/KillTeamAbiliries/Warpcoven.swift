//
//  Warpcoven.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

struct WarpcovenAbilitie: Codable, KillTeamAbility {
    
    let name: String
    let description: [String]
    let mutation: [BoonsOfTzeentch]
    
    struct BoonsOfTzeentch: Codable, UnitAbilitieProtocol {
        let name: String
        let id: String
        let type: TypeOfBoonsOfTzeentch
        let description: String
        let subText: [String]?
    }
    
    enum TypeOfBoonsOfTzeentch: String, Codable {
        case mutation
        case fate
        case aetheric
    }
}
