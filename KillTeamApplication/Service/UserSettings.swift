//
//  UserSettings.swift
//  KillTeamApplication
//
//  Created by Apple on 01.06.2022.
//

import Foundation

protocol UserSettingsProtocol {
    var firstTimeLaunch: Bool { get }
}

class UserSettings: UserSettingsProtocol {
    
    var firstTimeLaunch: Bool
    
    init(firstTimeLaunch: Bool) {
        self.firstTimeLaunch = firstTimeLaunch
    }
    
 }
