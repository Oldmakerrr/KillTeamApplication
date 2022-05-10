//
//  EditUnitModel.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

struct ChoosenUnit {
    var wargear = [[Wargear]]()
    var currentUnit: Unit?
    var indexPathUnit: IndexPath?
    var killTeam: KillTeam?
    var headerForRow = [String]()
}
