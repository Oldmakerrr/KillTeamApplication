//
//  TacOpsModel.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

class TacOpsModel {
    
    var gameData = GameData()
    
    var killTeam: KillTeam?
    
    var seekAndDestroyDeck: [TacOp] = []
    var securityDeck: [TacOp] = []
    var infiltrationDeck: [TacOp] = []
    var reconDeck: [TacOp] = []
    var currentDeck: [TacOp] = []
    var factionDeck: [TacOp]?
    var currentTypeDeck: TypeOfTacOp = .seekAndDestroy
    
}
