//
//  Store.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

final class StoreMulticastDelegate<T> {
    
    private var delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    func addDelegate(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    func removeDelegate(_ delegateToRemove: T) {
        for delegate in delegates.allObjects.reversed() {
            if delegate === delegateToRemove as AnyObject {
                delegates.remove(delegate)
            }
        }
    }
    
    func invoke(_ invocation: (T)->()) {
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T)
        }
    }
    
}

protocol StoreProtocol {
    var multicastDelegate: StoreMulticastDelegate<StoreDelegate> { get }
    var allFaction: [Faction] { get }
    func setFaction(_ faction: [Faction])
    func getKillTeam() -> KillTeam?
    func updateCurrentKillTeam(killTeam: KillTeam)
    
    var indexOfChoosenUnit: IndexPath? { get }
    var indexObservedUnit: IndexPath? { get }
    var lastChoosenPsychicDisciplines: String? { get }
    
    func updateLastChoosenPsychicDisciplines(psychicDisciplines: String)
    func updateIndexObservedUnit(indexPath: IndexPath)
    func updateIndexChoosenUnit(indexPath: IndexPath)
    
    func clearIndexObservedUnit()
    func clearIndexChoosenUnit()
}

protocol StoreDelegate: AnyObject {
    func didUpdate(_ store: Store, killTeam: KillTeam?)
}

final class Store: StoreProtocol {
    
    var multicastDelegate = StoreMulticastDelegate<StoreDelegate>()
    
    var allFaction: [Faction] = []
    
    var killTeam: KillTeam? {
        didSet {
            if let killTeam = killTeam {
                saveMyKillTeam(killTeam: killTeam)
            }
            multicastDelegate.invoke { presenter in
                presenter.didUpdate(self, killTeam: killTeam)
            }
        }
    }
    
    func setFaction(_ faction: [Faction]) {
        allFaction = faction
    }
    
    func getKillTeam() -> KillTeam? {
        return killTeam
    }
    
    func updateCurrentKillTeam(killTeam: KillTeam) {
        self.killTeam = killTeam
    }
    
    
    var lastChoosenPsychicDisciplines: String?
    
    func updateLastChoosenPsychicDisciplines(psychicDisciplines: String) {
        lastChoosenPsychicDisciplines = psychicDisciplines
    }
    
    var indexOfChoosenUnit: IndexPath?
    
    func updateIndexChoosenUnit(indexPath: IndexPath) {
        indexOfChoosenUnit = indexPath
    }
    
    var indexObservedUnit: IndexPath?

    func updateIndexObservedUnit(indexPath: IndexPath) {
        indexObservedUnit = indexPath
    }
    
    func clearIndexObservedUnit() {
        indexObservedUnit = nil
    }
    
    func clearIndexChoosenUnit() {
        indexOfChoosenUnit = nil
    }
    
    private func saveMyKillTeam(killTeam: KillTeam) {
        guard let uid = killTeam.uid else { return }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: uid)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: KeySaver.lastUsedKillTeamKey)
    }
            
}
