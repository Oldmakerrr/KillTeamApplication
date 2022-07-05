//
//  SaveData.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

import Foundation

final class KeySaver {
    
    static let lastUsedKillTeamKey = "lastUsedKillTeamKey"
    
    static func saveKey(key: [String]) {
        UserDefaults.standard.set(key, forKey: "KeyForKillTeam")
    }
    
    static func getKey() -> [String]? {
        return UserDefaults.standard.array(forKey: "KeyForKillTeam") as? [String]
    }
}

final class KillTeamSaver {
    
    static func saveKillTeam(killTeam: KillTeam) {
        guard let uid = killTeam.uid else { return }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: uid)
    }
    
    static func saveLastUsedKillTeam(killTeam: KillTeam) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: KeySaver.lastUsedKillTeamKey)
    }
    
    static func loadKillTeam(key: String) -> KillTeam? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            return try? PropertyListDecoder().decode(KillTeam.self, from: data)
        } else { return nil }
    }
    
}
