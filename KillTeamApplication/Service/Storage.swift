//
//  Storage.swift
//  KillTeamApplication
//
//  Created by Apple on 10.05.2022.
//

import Foundation

protocol StorageProtocol {
    var parseJson: ParseJSON { get }
    
    func loadSavedKillTeam() -> [KillTeam]
    func loadKeys()
    func isKeysEmpty() -> Bool
    
    func loadLastUsedKillTeam(completion: @escaping(KillTeam?) -> Void)
    
    func appendNewKillTeam(killTeam: KillTeam)
    func removeKillTeam(indexPath: IndexPath, uid: String)
}

class Storage: StorageProtocol {
    
    
    private let databaseQueue = DispatchQueue.global(qos: .utility)
    
    private let store: Store
    
    let parseJson = ParseJSON()
    
    private var loadedKillTeam = [KillTeam]()
    
    private var keysForKillTeam: [String] = []

    init(store: Store) {
        self.store = store
    }
    
    func isKeysEmpty() -> Bool {
        return keysForKillTeam.isEmpty
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
        
//MARK: - RemoveAndAddKillTeam
            
    func removeKillTeam(indexPath: IndexPath, uid: String) {
        if let killTeam = store.killTeam {
            if loadedKillTeam[indexPath.row].uid == killTeam.uid {
                store.killTeam = nil
                UserDefaults.standard.removeObject(forKey: KeySaver.lastUsedKillTeamKey)
            }
        }
        UserDefaults.standard.removeObject(forKey: uid)
        loadedKillTeam.remove(at: indexPath.row)
        removeKey(indexPath: indexPath)
        KeySaver.saveKey(key: keysForKillTeam)
    }
    
    func appendNewKillTeam(killTeam: KillTeam) {
        guard let uid = killTeam.uid else { return }
        loadedKillTeam.insert(killTeam, at: 0)
        appendNewKey(key: uid)
        KeySaver.saveKey(key: keysForKillTeam)
    }
        
//MARK: - LoadKillTeam
    
    func loadLastUsedKillTeam(completion: @escaping(KillTeam?) -> Void) {
        databaseQueue.async {
            if var killTeam = KillTeamSaver.loadKillTeam(key: KeySaver.lastUsedKillTeamKey) {
                killTeam.updateCurrentWounds()
                DispatchQueue.main.async {
                    completion(killTeam)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func loadSavedKillTeam() -> [KillTeam] {
        loadKeys()
        var killTeams = [KillTeam]()
        for key in keysForKillTeam {
            if let killTeam = KillTeamSaver.loadKillTeam(key: key) {
                killTeams.append(killTeam)
            }
        }
        return killTeams
    }
        
}

