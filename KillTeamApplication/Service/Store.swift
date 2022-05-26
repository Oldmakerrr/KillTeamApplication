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
    
    var allFaction: [Faction] { get }
    
}

protocol StoreDelegate: AnyObject {
    func didUpdate(_ store: Store, killTeam: KillTeam?)
}

final class Store: StoreProtocol {
    
    var multicastDelegate = StoreMulticastDelegate<StoreDelegate>()
    
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
        if let key = killTeam.id {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: key)
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: KeySaver.lastUsedKillTeamKey)
    }
    
    //MARK: - JSON
        
    var allFaction: [Faction] = []
        
    func killTeamFromJson() {
        let path = Bundle.main.path(forResource: "AllFaction", ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        allFaction = try! JSONDecoder().decode([Faction].self, from: jsonData! as Data)
    }

    
}
