//
//  VoidDancerTroupe.swift
//  KillTeamApplication
//
//  Created by Apple on 26.04.2022.
//

import Foundation

protocol KillTeamAbility: Codable {}

struct VoidDancerTroupeAbilitie: Codable, KillTeamAbility {

    let name: String
    let description: String
    let text: [MainText]
    let allegory: [Allegory]

    
    struct MainText: Codable {
        let mainText: String
        let postText: String
        let subText: [String]
    }
    
    struct Allegory: Codable {
        let name: String
        let performance: String
        let accolade: String
    }
    
}

/*
enum KillTeamAbilitie: Codable {
    case voidDancerTroupe(CorsairVoidscarredAbilitie?)
    case hunterCadre(HunterCadreAbilitie?)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            if let voidDancerTroupeAbilitie = try? container.decode(CorsairVoidscarredAbilitie.self) {
                self = .voidDancerTroupe(voidDancerTroupeAbilitie)
            } else {
                self = .voidDancerTroupe(nil)
            }
            
            if let hunterCadreAbilitie = try? container.decode(HunterCadreAbilitie.self) {
                self = .hunterCadre(hunterCadreAbilitie)
            } else {
                self = .hunterCadre(nil)
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .voidDancerTroupe(let voidDancerTroupeAbilitie) : try container.encode(voidDancerTroupeAbilitie)
        case .hunterCadre(let hunterCadreAbilitie) : try container.encode(hunterCadreAbilitie)
        }
    }
}
*/
