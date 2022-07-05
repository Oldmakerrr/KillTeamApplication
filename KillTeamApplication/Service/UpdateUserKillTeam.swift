//
//  updateUserKillTeam.swift
//  KillTeamApplication
//
//  Created by Apple on 07.06.2022.
//

import Foundation

class UpdateUserKillTeam {
    
    private let newKillTeams: [KillTeam]
    
    private let storage: StorageProtocol
    
    init(newBase: [Faction], storage: StorageProtocol) {
        var killTeams = [KillTeam]()
        newBase.forEach { faction in
            faction.killTeam.forEach { killTeam in
                killTeams.append(killTeam)
            }
        }
        self.storage = storage
        self.newKillTeams = killTeams
    }
    
    func updateBase() {
        self.updateLastUsedKillTeam()
        let updatedKillTeam = self.updateUserKillTeams(newKillTeams: self.newKillTeams,
                                                       userKillTeams: storage.loadSavedKillTeam())
        self.resaveNewKillTeams(killTeams: updatedKillTeam)
    }
    
    private func updateLastUsedKillTeam() {
        guard let lastUsedKillTeam = KillTeamSaver.loadKillTeam(key: KeySaver.lastUsedKillTeamKey) else { return }
        for newKillTeam in newKillTeams {
            if newKillTeam == lastUsedKillTeam {
                if let updatedLastUsedKillTeam = updateKillTeam(newKillTeam: newKillTeam, oldKillTeam: lastUsedKillTeam) {
                    KillTeamSaver.saveLastUsedKillTeam(killTeam: updatedLastUsedKillTeam)
                    break
                }
            }
        }
        
    }
    
    private func resaveNewKillTeams(killTeams: [KillTeam]) {
        killTeams.forEach { killTeam in
            KillTeamSaver.saveKillTeam(killTeam: killTeam)
        }
    }
    
    
    private func updateUserKillTeams(newKillTeams: [KillTeam], userKillTeams: [KillTeam]) -> [KillTeam] {
        var newUserKillTeams = [KillTeam]()
        
        for (index, oldKillTeam) in userKillTeams.enumerated() {
            for newKillTeam in newKillTeams {
                if oldKillTeam == newKillTeam {
                    if let updatedKillTeam = updateKillTeam(newKillTeam: newKillTeam,
                                                            oldKillTeam: oldKillTeam) {
                        newUserKillTeams.insert(updatedKillTeam, at: index)
                        break
                        
                    }
                }
            }
        }
        
        return newUserKillTeams
    }
    
    private func updateKillTeam(newKillTeam: KillTeam, oldKillTeam: KillTeam) -> KillTeam? {
        guard let uid = oldKillTeam.uid else { return nil }
        var newKillTeam = newKillTeam
        var numberEquipmentPoint = 0
        newKillTeam.uid = uid
        
        if let customName = oldKillTeam.userCustomName {
            newKillTeam.userCustomName = customName
        }
        
        if !oldKillTeam.chosenFireTeams.isEmpty {
            for (index, oldFireTeam) in oldKillTeam.chosenFireTeams.enumerated() {
                for newFireTeam in newKillTeam.fireTeams {
                    if oldFireTeam == newFireTeam {
                        let updatedFireTeam = updateFireTeam(newFireTeam: newFireTeam,
                                                             oldFireTeam: oldFireTeam,
                                                             equipments: newKillTeam.equipments)
                        newKillTeam.chosenFireTeams.insert(updatedFireTeam.0, at: index)
                        numberEquipmentPoint += updatedFireTeam.1
                        break
                    }
                }
            }
        }
        
        newKillTeam.countEquipmentPoint -= numberEquipmentPoint
        return newKillTeam
    }
    
    private func updateFireTeam(newFireTeam: FireTeam, oldFireTeam: FireTeam, equipments: [Equipment]) -> (FireTeam, Int) {
        var newFireTeam = newFireTeam
        var numberEquipmentPoint = 0
        newFireTeam.currentDataslates = []
        for (index, oldUnit) in oldFireTeam.currentDataslates.enumerated() {
            for newUnit in newFireTeam.availableDataslates {
                if newUnit == oldUnit {
                    let updatedNewUnit = updateUnit(newUnit: newUnit, oldUnit: oldUnit, equipments: equipments)
                    newFireTeam.currentDataslates.insert(updatedNewUnit.0, at: index)
                    numberEquipmentPoint += updatedNewUnit.1
                    break
                    
                }
            }
        }
        return (newFireTeam, numberEquipmentPoint)
    }
    
    private func updateUnit(newUnit: Unit, oldUnit: Unit, equipments: [Equipment]) -> (Unit, Int) {
        var newUnit = newUnit
        var numberEquipmentPoint = 0
        
        if let customName = oldUnit.customName {
            newUnit.customName = customName
        }
        
        if let oldMeleeWeapon = oldUnit.selectedMeleeWeapon {
            for newWeapon in newUnit.availableWeapons {
                if newWeapon == oldMeleeWeapon {
                    newUnit.selectedMeleeWeapon = newWeapon
                    break
                }
            }
        }
        
        if let oldRangeWeapon = oldUnit.selectedRangeWeapon {
            for newWeapon in newUnit.availableWeapons {
                if newWeapon == oldRangeWeapon {
                    newUnit.selectedRangeWeapon = newWeapon
                    break
                }
            }
        }
        
        if !oldUnit.equipments.isEmpty {
            for oldEquipment in oldUnit.equipments {
                for newEquipment in equipments {
                    if newEquipment == oldEquipment {
                        newUnit.equipments.append(newEquipment)
                        numberEquipmentPoint += newEquipment.cost
                        break
                    }
                }
            }
        }
        
        if let additionalAbility = oldUnit.additionalAbility {
            newUnit.additionalAbility = additionalAbility
        }
        
        return (newUnit, numberEquipmentPoint)
    }
    
}
