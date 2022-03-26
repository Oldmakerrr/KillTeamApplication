//
//  EditUnitModel.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

struct ChoosenUnit {
    var closeWeapon = [Weapon]()
    var rangeWeapon = [Weapon]()
    var currentUnit: Unit?
    var indexPathUnit: IndexPath?
    var killTeam: KillTeam?
    
    var numberOfRow = [Int]()
    var headerForRow = [String]()
}
