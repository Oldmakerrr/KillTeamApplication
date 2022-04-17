//
//  TacOpsModel.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

class TacOpsModel {
    
    var gameData = GameData()
    
    var seekAndDestroy: [TacOps] = []
    var security: [TacOps] = []
    var infiltration: [TacOps] = []
    var recon: [TacOps] = []
    var customTacOps: [TacOps] = []
    var factionTacOps: [TacOps]?
    
   // var firstTacOp: TacOps?
   // var secondTacOp: TacOps?
   // var thirdTacOp: TacOps?
}
