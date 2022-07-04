//
//  UserSettings.swift
//  KillTeamApplication
//
//  Created by Apple on 01.06.2022.
//

import Foundation

protocol UserSettingsProtocol {
    var isFirstTimeLaunch: Bool? { get }
}

class UserSettings: UserSettingsProtocol {
    
    var isFirstTimeLaunch: Bool?
    
    init(firstTimeLaunch: Bool? = nil) {
        self.isFirstTimeLaunch = firstTimeLaunch
    }
    
 }
