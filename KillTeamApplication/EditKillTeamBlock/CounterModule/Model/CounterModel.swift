//
//  CounterModel.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

struct CounterModel {
    var countCommandPoint = 0
    var countVictoryPoint = 0
    var countTurningPoint = 0
    var currentStrategicPloy: Ploy?
    var killTeam: KillTeam?
    var gameData = GameData()
}
