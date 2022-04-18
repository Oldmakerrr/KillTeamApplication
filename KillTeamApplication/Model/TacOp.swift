//
//  TacOp.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct TacOp: Codable {
    let name: String
    let type: TypeOfTacOp
    let description: String
    let subDescription: String?
    let subText: String?
    let firstCondition: String
    let victoryPointForfirstCondition: Int
    let secondCondition: String?
    let subCondition: [String]?
    let victoryPointSecondCondition: Int?
    let abilitie: UnitAbilitie?
    let uniquiAction: UnitUniqueAction?
    var progreesTacOp: Int?
}

extension TacOp: Equatable {
    static func == (lhs: TacOp, rhs: TacOp) -> Bool {
        lhs.name == rhs.name
    }
}

enum TypeOfTacOp: String, Codable {
    case seekAndDestroy
    case security
    case infiltration
    case recon
    case factionTacOp
}
