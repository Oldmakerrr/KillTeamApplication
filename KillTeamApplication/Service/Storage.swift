//
//  Storage.swift
//  KillTeamApplication
//
//  Created by Apple on 10.05.2022.
//

import Foundation

protocol StorageProtocol {
    
    var loadedKillTeam: [KillTeam] { get }
    func loadSavedKillTeam()
    func loadKeys()
    func loadLastUsedKillTeam()
    func isLoadedKillTeamEmpty() -> Bool
    func appendNewKillTeam(killTeam: KillTeam)
    func removeKillTeam(indexPath: IndexPath)
    
}

class Storage: StorageProtocol {
    
    private let store: Store
    var loadedKillTeam: [KillTeam] = []
    private var keysForKillTeam: [String] = []

    init(store: Store) {
        self.store = store
    }
    
    func isLoadedKillTeamEmpty() -> Bool {
        return loadedKillTeam.isEmpty
    }
    
//MARK - RemoveAndAddKey
        
    private func removeKey(indexPath: IndexPath) {
        keysForKillTeam.remove(at: indexPath.row)
    }
    
    private func appendNewKey(key: String) {
        keysForKillTeam.insert(key, at: 0)
    }
    
    func loadKeys() {
        if let keys = KeySaver.getKey() {
            keysForKillTeam = keys
        }
    }
        
//MARK - RemoveAndAddKillTeam
            
    func removeKillTeam(indexPath: IndexPath) {
        if let killTeam = store.killTeam {
            if loadedKillTeam[indexPath.row].id == killTeam.id {
                store.killTeam = nil
                UserDefaults.standard.removeObject(forKey: KeySaver.lastUsedKillTeamKey)
            }
        }
        loadedKillTeam.remove(at: indexPath.row)
        removeKey(indexPath: indexPath)
        KeySaver.saveKey(key: keysForKillTeam)
    }
    
    func appendNewKillTeam(killTeam: KillTeam) {
        guard let key = killTeam.id else { return }
        loadedKillTeam.insert(killTeam, at: 0)
        appendNewKey(key: key)
        KeySaver.saveKey(key: keysForKillTeam)
    }
        
//MARK: - LoadKillTeam
    
    func loadLastUsedKillTeam() {
        if var killTeam = loadKillTeam(key: KeySaver.lastUsedKillTeamKey) {
            killTeam.updateCurrentWounds()
            store.killTeam = killTeam
        }
    }
    
    func loadSavedKillTeam() {
        if let keys = KeySaver.getKey() {
            keysForKillTeam = keys
        }
        for key in keysForKillTeam {
            if let killTeam = loadKillTeam(key: key) {
                loadedKillTeam.append(killTeam)
            }
        }
    }
        
    private func loadKillTeam(key: String) -> KillTeam? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            return try? PropertyListDecoder().decode(KillTeam.self, from: data)
        } else { return nil }
    }
        
}
