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
    var multicastDelegate: StoreMulticastDelegate<StoreDelegate> {get set}
    func addKillTeam(killTeam: KillTeam)
    func addUnit(unit: Unit, indexPath: IndexPath)
    func addFireTeam(fireTeam: FireTeam)
    func removeTeam(fireTeam: FireTeam)
    func addIndexOfChoosenUnit(index: IndexPath)
    func addCounterFireTeam(counter: [String: Int])
    func updateWargear(indexPath: IndexPath, unit: Unit)
    func updateChoosenUnit(unit: Unit)

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
    
    func addKillTeam(killTeam: KillTeam) {
        self.killTeam = killTeam
    }
    
    func addUnit(unit: Unit, indexPath: IndexPath) {
        self.killTeam?.fireTeam[indexPath.section].currentDataslates.append(unit)
    }
    
    func addFireTeam(fireTeam: FireTeam) {
        self.killTeam?.choosenFireTeam.append(fireTeam)
        if killTeam!.counterFT.contains(where: { (key, _) in
            key == fireTeam.name
        }) {
            killTeam?.counterFT[fireTeam.name]! += 1
        } else{
        self.killTeam?.counterFT[fireTeam.name] = 1
        }
    }
    
    func addCounterFireTeam(counter: [String: Int]) {
        self.killTeam?.counterFT = counter
    }
    
    func addIndexOfChoosenUnit(index: IndexPath) {
        self.killTeam?.indexOfChoosenUnit = index
    }
    
    
    
    func removeTeam(fireTeam: FireTeam) {
        var index = 0
        if killTeam!.choosenFireTeam.contains(fireTeam) {
            for i in killTeam!.choosenFireTeam {
                if i == fireTeam {
                    killTeam!.choosenFireTeam.remove(at: index)
                    self.killTeam?.counterFT[fireTeam.name]! -= 1
                    break
                }
                index += 1
            }
            
        }
    }
    
    func updateWargear(indexPath: IndexPath, unit: Unit) {
        killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] = unit
    }

    
    func updateChoosenUnit(unit: Unit) {
        killTeam?.choosenUnit = unit
    }

    private var arrayKey: [String] = []
    
    private func saveMyKillTeam(killTeam: KillTeam) {
        if let key = killTeam.id {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(killTeam), forKey: key)
            if !arrayKey.contains(key) {
                arrayKey.append(key)
            }
            KeySaver.saveKey(key: arrayKey)
        }
    }
    
   // private func generateKey(name: String) -> String {
   //     var key = ""
   //     let random2 = Int.random(in: 0...100000)
   //     key += String(random2)
   //     key += name
   //     let random = Int.random(in: 0...100000)
   //     key += String(random)
   //     return key
   // }
}
