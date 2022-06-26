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
    let secondCondition: String?
    let subConditionTitle: String?
    let subCondition: [String]?
    let victoryPoint: [Int]
    var isCompleteConditions = [Bool]()
    let abilitie: UnitAbilitie?
    let uniquiAction: UnitUniqueAction?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
        case description = "description"
        case subDescription = "subDescription"
        case subText = "subText"
        case firstCondition = "firstCondition"
        case secondCondition = "secondCondition"
        case subConditionTitle = "subConditionTitle"
        case subCondition = "subCondition"
        case victoryPoint = "victoryPoint"
        case isCompleteConditions = "isCompleteConditions"
        case abilitie = "abilitie"
        case uniquiAction = "uniquiAction"
    }
    
    init(from decoder: Decoder) throws {
        let name = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try name.decode(String.self, forKey: .name)
        let type = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try type.decode(TypeOfTacOp.self, forKey: .type)
        let description = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try description.decode(String.self, forKey: .description)
        let subDescription = try decoder.container(keyedBy: CodingKeys.self)
        self.subDescription = try? subDescription.decode(String?.self, forKey: .subDescription)
        let subText = try decoder.container(keyedBy: CodingKeys.self)
        self.subText = try? subText.decode(String?.self, forKey: .subText)
        let firstCondition = try decoder.container(keyedBy: CodingKeys.self)
        self.firstCondition = try firstCondition.decode(String.self, forKey: .firstCondition)
        let secondCondition = try decoder.container(keyedBy: CodingKeys.self)
        self.secondCondition = try? secondCondition.decode(String?.self, forKey: .secondCondition)
        let subConditionTitle = try decoder.container(keyedBy: CodingKeys.self)
        self.subConditionTitle = try? subConditionTitle.decode(String?.self, forKey: .subConditionTitle)
        let subCondition = try decoder.container(keyedBy: CodingKeys.self)
        self.subCondition = try? subCondition.decode([String]?.self, forKey: .subCondition)
        let victoryPoint = try decoder.container(keyedBy: CodingKeys.self)
        self.victoryPoint = try victoryPoint.decode([Int].self, forKey: .victoryPoint)
        self.isCompleteConditions = []
        let abilitie = try decoder.container(keyedBy: CodingKeys.self)
        self.abilitie = try? abilitie.decode(UnitAbilitie?.self, forKey: .abilitie)
        let uniquiAction = try decoder.container(keyedBy: CodingKeys.self)
        self.uniquiAction = try? uniquiAction.decode(UnitUniqueAction?.self, forKey: .uniquiAction)
    }
    
    func encode(to encoder: Encoder) throws {
        var name = encoder.container(keyedBy: CodingKeys.self)
        try name.encode(self.name, forKey: .name)
        var type = encoder.container(keyedBy: CodingKeys.self)
        try type.encode(self.type, forKey: .type)
        var description = encoder.container(keyedBy: CodingKeys.self)
        try description.encode(self.description, forKey: .description)
        var subDescription = encoder.container(keyedBy: CodingKeys.self)
        try? subDescription.encode(self.subDescription, forKey: .subDescription)
        var subText = encoder.container(keyedBy: CodingKeys.self)
        try? subText.encode(self.subText, forKey: .subText)
        var firstCondition = encoder.container(keyedBy: CodingKeys.self)
        try firstCondition.encode(self.firstCondition, forKey: .firstCondition)
        var secondCondition = encoder.container(keyedBy: CodingKeys.self)
        try? secondCondition.encode(self.secondCondition, forKey: .secondCondition)
        var subConditionTitle = encoder.container(keyedBy: CodingKeys.self)
        try? subConditionTitle.encode(self.subConditionTitle, forKey: .subConditionTitle)
        var subCondition = encoder.container(keyedBy: CodingKeys.self)
        try? subCondition.encode(self.subCondition, forKey: .subCondition)
        var victoryPoint = encoder.container(keyedBy: CodingKeys.self)
        try victoryPoint.encode(self.victoryPoint, forKey: .victoryPoint)
        var isCompleteConditions = encoder.container(keyedBy: CodingKeys.self)
        try isCompleteConditions.encode(self.isCompleteConditions, forKey: .isCompleteConditions)
        var abilitie = encoder.container(keyedBy: CodingKeys.self)
        try? abilitie.encode(self.abilitie, forKey: .abilitie)
        var uniquiAction = encoder.container(keyedBy: CodingKeys.self)
        try? uniquiAction.encode(self.uniquiAction, forKey: .uniquiAction)
    }
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
