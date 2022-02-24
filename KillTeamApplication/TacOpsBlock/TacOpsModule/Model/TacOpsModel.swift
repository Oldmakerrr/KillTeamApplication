//
//  TacOpsModel.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

class TacOpsModel {
    
    var gameData = GameData()
    
    let seekAndDestroy: [TacOps] = [headhunter, challenge, rout, execution, deadlyMarksman, robAndRansack]
    let security: [TacOps] = [seizeGround, holdTheLine, protectAssets, damageLimitation, plantBanner, centralControl]
    let infiltration: [TacOps] = []
    let recon: [TacOps] = []
    var customTacOps: [TacOps] = []
    var tacOpsKillTeam: [TacOps]?
    
    var firstTacOp: TacOps?
    var secondTacOp: TacOps?
    var thirdTacOp: TacOps?
}
