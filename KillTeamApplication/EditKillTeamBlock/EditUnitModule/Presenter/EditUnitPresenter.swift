//
//  EditUnitPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol EditUnitViewControllerProtocol: AnyObject {
    var presenter: EditUnitPresenterProtocol? { get }
    var countOfEquipmentPointLabel: NormalLabel { get }
}

protocol EditUnitPresenterProtocol: AnyObject {
    var view: EditUnitViewControllerProtocol? { get }
    var model: ChoosenUnit { get }
    var store: StoreProtocol { get }
    init (view: EditUnitViewControllerProtocol, store: StoreProtocol)
    func cleareIndex()
}

class EditUnitPresenter: EditUnitPresenterProtocol {
    
    
    weak var view: EditUnitViewControllerProtocol?
    
    var model = ChoosenUnit() {
        didSet {
            view?.countOfEquipmentPointLabel.text = "EP = \(model.killTeam?.countEquipmentPoint ?? 0)"
        }
    }
    
    var store: StoreProtocol
    
    required init(view: EditUnitViewControllerProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        self.store.multicastDelegate.addDelegate(self)
        
    }
    
    func cleareIndex() {
        model.killTeam?.indexOfChoosenUnit = nil
        store.updateCurrentKillTeam(killTeam: model.killTeam!)
    }
    
    private func sortirateWEapon(weapons: [Weapon]) {
        var countRangeWeapon = 0
        var countCloseWeapon = 0
        weapons.forEach { weapon in
            switch weapon.type {
            case "range":
                countRangeWeapon += 1
                model.rangeWeapon.append(weapon)
            case "close":
                countCloseWeapon += 1
                model.closeWeapon.append(weapon)
            default:
                break
            }
        }
        if let additionalWeapon = model.currentUnit?.additionalWeapon {
            additionalWeapon.forEach { weapon in
                switch weapon.type {
                case "range":
                    countRangeWeapon += 1
                    model.rangeWeapon.append(weapon)
                case "close":
                    countCloseWeapon += 1
                    model.closeWeapon.append(weapon)
                default:
                    break
                }
            }
        }
        if countRangeWeapon != 0 {
            model.numberOfRow.append(countRangeWeapon)
            model.headerForRow.append("Range Weapon")
        }
        if countCloseWeapon != 0 {
            model.numberOfRow.append(countCloseWeapon)
            model.headerForRow.append("Close Weapon")
        }
    }
    
}

extension EditUnitPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        guard let indexPath = killTeam.indexOfChoosenUnit else { return }
        model.killTeam = killTeam
        model.indexPathUnit = indexPath
        if !killTeam.choosenFireTeam.isEmpty {
            model.currentUnit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
        }
        if let availableWeapon = model.currentUnit?.availableWeapon {
            sortirateWEapon(weapons: availableWeapon)
        }
        if !killTeam.equipment.isEmpty {
            model.numberOfRow.append(killTeam.equipment.count)
            model.headerForRow.append("Equipment")
        }
    }
}

extension EditUnitPresenter: EditUnitCellDelegate {
    func selectedWargear(wargear: Weapon, selected: Bool) {
        guard var unit = model.currentUnit, let indexPath = model.indexPathUnit  else { return }
        if let additionalWeapon = unit.additionalWeapon {
            guard !additionalWeapon.contains(wargear) else { return }
        }
        if selected {
            switch wargear.type {
            case "close":
                unit.selectedCloseWeapon = wargear
            case "range":
                unit.selectedRangeWeapon = wargear
            default:
                return
            }
            store.updateUnitWargearInChoosenFireTeam(indexPath: indexPath, unit: unit)
        }
    }
}

extension EditUnitPresenter: EditUnitEquipmentCellDelegate {
    func selectEquipment(equipment: Equipment, selected: Bool) {
        guard var unit = model.currentUnit, let indexPath = model.indexPathUnit  else { return }
        if selected {
            if unit.equipment.contains(equipment) {
                model.killTeam?.countEquipmentPoint += equipment.cost
                unit.equipment.removeAll(where: { equip in
                    equip == equipment
                })
            } else {
                unit.equipment.append(equipment)
                model.killTeam?.countEquipmentPoint -= equipment.cost
            }
            store.updateCurrentKillTeam(killTeam: model.killTeam!)
            store.updateUnitWargearInChoosenFireTeam(indexPath: indexPath, unit: unit)
        }
    }
    
    
}
