//
//  updateUserKillTeam.swift
//  KillTeamApplication
//
//  Created by Apple on 07.06.2022.
//

import Foundation

class UpdateUserKillTeam {
    
    
    func updateUserKillTeam(usersKillTeam: [KillTeam], newKillTeam: [Faction]) {
        usersKillTeam.forEach { userKillTeam in
            newKillTeam.forEach { faction in
                faction.killTeam.forEach { newKillTeam in
                    if userKillTeam.killTeamName == newKillTeam.killTeamName {
                        //замена старого юзер дефолт на нового
                    }
                }
            }
        }
    }
    
    func updateKillTeam(updatedKillTeam: KillTeam, killTeam: KillTeam) -> KillTeam {
        var updatedKillTeam = updatedKillTeam
        if let userName = killTeam.userCustomName {
            updatedKillTeam.userCustomName = userName
        }
        if killTeam.choosenFireTeam.isEmpty {
            return updatedKillTeam
        } else {
            updatedKillTeam = updateFireTeam(newKillTeam: updatedKillTeam, oldKillTeam: killTeam)
            updatedKillTeam = updateUnitInFireTeam(newKillTeam: updatedKillTeam, oldKillTeam: killTeam)
            return updatedKillTeam
        }
    }
    
    func updateUnitInFireTeam(newKillTeam: KillTeam, oldKillTeam: KillTeam) -> KillTeam {
        var newKillTeam = newKillTeam
        for (indexF, oldFireTeam) in oldKillTeam.choosenFireTeam.enumerated() {
            for (IndexU, oldUnit) in oldFireTeam.currentDataslates.enumerated() {
                newKillTeam.fireTeam.forEach { ft in
                    ft.availableDataslates.forEach { newUnit in
                        if newUnit.name == oldUnit.name {
                            newKillTeam.choosenFireTeam[indexF].currentDataslates.insert(updateUnit(newUnit: newUnit, oldUnit: oldUnit, newKillTeam: newKillTeam), at: IndexU)
                        }
                    }
                }
            }
        }
        return newKillTeam
    }
    
    func updateFireTeam(newKillTeam: KillTeam, oldKillTeam: KillTeam) -> KillTeam {
        var newKillTeam = newKillTeam
        for (index, oldFireTeam) in oldKillTeam.choosenFireTeam.enumerated() {
            newKillTeam.fireTeam.forEach { newFireTeam in
                if newFireTeam.name == oldFireTeam.name {
                    newKillTeam.choosenFireTeam.insert(newFireTeam, at: index)
                }
            }
        }
        return newKillTeam
    }
    
    func updateUnit(newUnit: Unit, oldUnit: Unit, newKillTeam: KillTeam) -> Unit {
        var newUnit = newUnit
        if let oldUnitName = oldUnit.customName {
            newUnit.customName = oldUnitName
        }
        if let oldUnitMeleeWeapon = oldUnit.selectedCloseWeapon {
            newUnit.availableWeapon?.forEach({ weapon in
                if weapon.name == oldUnitMeleeWeapon.name {
                    newUnit.selectedCloseWeapon = weapon
                }
            })
        }
        if let oldUnitRangeWeapon = oldUnit.selectedRangeWeapon {
            newUnit.availableWeapon?.forEach({ weapon in
                if weapon.name == oldUnitRangeWeapon.name {
                    newUnit.selectedRangeWeapon = weapon
                }
            })
        }
        for (index, oldEquipment) in oldUnit.equipment.enumerated() {
            newKillTeam.equipment.forEach { newEquipment in
                if newEquipment.name == oldEquipment.name {
                    newUnit.equipment.insert(newEquipment, at: index)
                }
            }
        }
        return newUnit
    }
    
    
    
}
