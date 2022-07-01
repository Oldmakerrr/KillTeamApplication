//
//  TacOp.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct TacOp: Codable {
    
    let name: String
    let id: String
    let type: TypeOfTacOp
    let description: String
    let subDescription: String?
    let subText: String?
    let firstCondition: String
    let secondCondition: String?
    let subConditionTitle: String?
    let subConditions: [String]?
    let victoryPoint: [Int]
    var isCompletedConditions: [Bool]
    let ability: UnitAbilitie?
    let uniqueAction: UnitUniqueAction?
    
}

extension TacOp: Equatable {
    static func == (lhs: TacOp, rhs: TacOp) -> Bool {
        lhs.id == rhs.id
    }
}

enum TypeOfTacOp: String, Codable {
    case seekAndDestroy
    case security
    case infiltration
    case recon
    case factionTacOp
}
