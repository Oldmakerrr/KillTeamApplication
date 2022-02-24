//
//  EditKillTeamModel.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
 

struct ChosenKillTeam {
    var killTeam: KillTeam?
    var choosenUnits: [Unit] = []
}

enum GoFromEditKillTeam {
    case editUnit
    case addFireTeam
}
