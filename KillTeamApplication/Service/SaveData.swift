//
//  SaveData.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

import Foundation

final class KeySaver {
    
    static func saveKey(key: [String]) {
        UserDefaults.standard.set(key, forKey: "KeyForKillTeam")
    }
    
    static func getKey() -> [String]? {
        return UserDefaults.standard.array(forKey: "KeyForKillTeam") as? [String]
    }
}
