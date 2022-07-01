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
        if killTeam.chosenFireTeams.isEmpty {
            return updatedKillTeam
        } else {
            updatedKillTeam = updateFireTeam(newKillTeam: updatedKillTeam, oldKillTeam: killTeam)
            updatedKillTeam = updateUnitInFireTeam(newKillTeam: updatedKillTeam, oldKillTeam: killTeam)
            return updatedKillTeam
        }
    }
    
    func updateUnitInFireTeam(newKillTeam: KillTeam, oldKillTeam: KillTeam) -> KillTeam {
        var newKillTeam = newKillTeam
        for (indexF, oldFireTeam) in oldKillTeam.chosenFireTeams.enumerated() {
            for (IndexU, oldUnit) in oldFireTeam.currentDataslates.enumerated() {
                newKillTeam.fireTeams.forEach { ft in
                    ft.availableDataslates.forEach { newUnit in
                        if newUnit.name == oldUnit.name {
                            newKillTeam.chosenFireTeams[indexF].currentDataslates.insert(updateUnit(newUnit: newUnit, oldUnit: oldUnit, newKillTeam: newKillTeam), at: IndexU)
                        }
                    }
                }
            }
        }
        return newKillTeam
    }
    
    func updateFireTeam(newKillTeam: KillTeam, oldKillTeam: KillTeam) -> KillTeam {
        var newKillTeam = newKillTeam
        for (index, oldFireTeam) in oldKillTeam.chosenFireTeams.enumerated() {
            newKillTeam.fireTeams.forEach { newFireTeam in
                if newFireTeam.name == oldFireTeam.name {
                    newKillTeam.chosenFireTeams.insert(newFireTeam, at: index)
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
        if let oldUnitMeleeWeapon = oldUnit.selectedMeleeWeapon {
            newUnit.availableWeapons?.forEach({ weapon in
                if weapon.name == oldUnitMeleeWeapon.name {
                    newUnit.selectedMeleeWeapon = weapon
                }
            })
        }
        if let oldUnitRangeWeapon = oldUnit.selectedRangeWeapon {
            newUnit.availableWeapons?.forEach({ weapon in
                if weapon.name == oldUnitRangeWeapon.name {
                    newUnit.selectedRangeWeapon = weapon
                }
            })
        }
        for (index, oldEquipment) in oldUnit.equipments.enumerated() {
            newKillTeam.equipments.forEach { newEquipment in
                if newEquipment.name == oldEquipment.name {
                    newUnit.equipments.insert(newEquipment, at: index)
                }
            }
        }
        return newUnit
    }
    
    
    
}
