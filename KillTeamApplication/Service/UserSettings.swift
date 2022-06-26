//
//  UserSettings.swift
//  KillTeamApplication
//
//  Created by Apple on 01.06.2022.
//

import Foundation

protocol UserSettingsProtocol {
    var isFirstTimeLaunch: Bool { get }
    var isInstructionShowed: [String] { get set }
}

class UserSettings: UserSettingsProtocol {
    
    var isFirstTimeLaunch: Bool
    var isInstructionShowed = [String]()
    
    init(firstTimeLaunch: Bool) {
        self.isFirstTimeLaunch = firstTimeLaunch
    }
    
 }
