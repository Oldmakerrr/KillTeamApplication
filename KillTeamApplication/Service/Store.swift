//
//  Store.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

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
    var loadedKillTeam: [KillTeam] { get }
    var lastUsedKillTeam: KillTeam? { get }
    var allFaction: [Faction] { get }
    var keysForKillTeam: [String] { get }
    
    func updateCurrentKillTeam(killTeam: KillTeam)
    func addFireTeam(fireTeam: FireTeam)
    func removeFireTeam(fireTeam: FireTeam)
    func addIndexOfChoosenUnit(index: IndexPath)
    func addCounterFireTeam(counter: [String: Int])
    func updateUnitWargearInChoosenFireTeam(indexPath: IndexPath, unit: Unit)
    func updateChoosenUnit(unit: Unit)
    
    func loadSavedKillTeam()
    func removeKillTeam(indexPath: IndexPath)
    func appendNewKillTeam(killTeam: KillTeam)
    
    func removeKey(indexPath: IndexPath)
    func appendNewKey(key: String)
}

protocol StoreDelegate: AnyObject {
    func didUpdate(_ store: Store, killTeam: KillTeam?)
}

final class Store: StoreProtocol {
    
    private var killTeam: KillTeam? {
        didSet {
            if let killTeam = killTeam {
                saveMyKillTeam(killTeam: killTeam)
            }
            multicastDelegate.invoke { presenter in
                presenter.didUpdate(self, killTeam: killTeam)
            }
        }
    }

    var multicastDelegate = StoreMulticastDelegate<StoreDelegate>()
    
//MARK - RemoveAndAddKey
    
    func removeKey(indexPath: IndexPath) {
        keysForKillTeam.remove(at: indexPath.row)
    }
    
    func appendNewKey(key: String) {
        keysForKillTeam.append(key)
    }
    
//MARK - RemoveAndAddKey
        
    func removeKillTeam(indexPath: IndexPath) {
        if let killTeam = killTeam {
            if loadedKillTeam[indexPath.row].id == killTeam.id {
                self.killTeam = nil
                UserDefaults.standard.removeObject(forKey: lastUsedKillTeamKey)
            }
        }
        loadedKillTeam.remove(at: indexPath.row)
    }
    
    func appendNewKillTeam(killTeam: KillTeam) {
        loadedKillTeam.append(killTeam)
    }
    
    
//MARK: - JSON
    
    var allFaction: [Faction] = []
    
    func killTeamFromJson() -> [Faction] {
        let path = Bundle.main.path(forResource: "AllFactionV1 ", ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        return try! JSONDecoder().decode([Faction].self, from: jsonData! as Data)
    }

//MARK: - SaveKillTeam
    
    private func saveMyKillTeam(killTeam: KillTeam) {
        if let key = killTeam.id {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: key)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: lastUsedKillTeamKey)
        }
    }
    
//MARK: - LoadKillTeam
    
    var loadedKillTeam: [KillTeam] = []
    
    var lastUsedKillTeam: KillTeam?
    let lastUsedKillTeamKey = "lastUsedKillTeamKey"
    
    var keysForKillTeam: [String] = []
    
    func loadLastUsedKillTeam() {
        if var killTeam = loadMyKillTeam(key: lastUsedKillTeamKey) {
            killTeam.updateCurrentWounds()
            self.killTeam = killTeam
        }
    }
    
    func loadSavedKillTeam() {
        loadedKillTeam = []
        if let keys = KeySaver.getKey() {
            keysForKillTeam = keys
        }
        for key in keysForKillTeam {
            if let killTeam = loadMyKillTeam(key: key) {
                loadedKillTeam.append(killTeam)
            }
        }
    }
    
    private func loadMyKillTeam(key: String) -> KillTeam? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            return try? PropertyListDecoder().decode(KillTeam.self, from: data)
        } else { return nil }
    }
    
//MARK: - UpdateKillTeamMethod
    
    func updateCurrentKillTeam(killTeam: KillTeam) {
        self.killTeam = killTeam
    }
    
    func addFireTeam(fireTeam: FireTeam) {
        guard var killTeam = killTeam, let counter = killTeam.counterFireTeam else { return }
        killTeam.choosenFireTeam.append(fireTeam)
        if counter.contains(where: { (key, value) in
            key == fireTeam.name
        }) {
            killTeam.counterFireTeam?[fireTeam.name]! += 1
        } else{
            killTeam.counterFireTeam?[fireTeam.name] = 1
        }
        self.killTeam = killTeam
    }
    
    func addCounterFireTeam(counter: [String: Int]) {
        self.killTeam?.counterFireTeam = counter
    }
    
    func addIndexOfChoosenUnit(index: IndexPath) {
        self.killTeam?.indexOfChoosenUnit = index
    }
    
    func removeFireTeam(fireTeam: FireTeam) {
        guard let killTeam = killTeam else { return }
        if killTeam.choosenFireTeam.contains(fireTeam) {
            self.killTeam = removeFireTeamAddEquipmentPoint(killTeam: killTeam, fireTeam: fireTeam)
        }
    }
    
    func updateUnitWargearInChoosenFireTeam(indexPath: IndexPath, unit: Unit) {
        killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] = unit
    }

    
    func updateChoosenUnit(unit: Unit) {
        killTeam?.choosenUnit = unit
    }
    
    private func removeFireTeamAddEquipmentPoint(killTeam: KillTeam, fireTeam: FireTeam) -> KillTeam {
        var killTeam = killTeam
        for (index, team) in killTeam.choosenFireTeam.enumerated(){
            if team == fireTeam {
                killTeam.choosenFireTeam[index].currentDataslates.forEach { unit in
                    unit.equipment.forEach { equipment in
                        killTeam.countEquipmentPoint += equipment.cost
                    }
                }
                killTeam.choosenFireTeam.remove(at: index)
                killTeam.counterFireTeam?[fireTeam.name]! -= 1
                break
            }
        }
        return killTeam
    }
    
    
    
  
}
