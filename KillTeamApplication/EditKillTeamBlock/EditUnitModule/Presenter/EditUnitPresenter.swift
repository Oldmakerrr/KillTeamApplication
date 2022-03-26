//
//  EditUnitPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol EditUnitViewControllerProtocol: AnyObject {
    var presenter: EditUnitPresenterProtocol? { get }
    var countOfEquipmentPointLabel: UILabel { get }
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
            view?.countOfEquipmentPointLabel.text = "Count of Equipment Point = \(model.killTeam?.countEquipmentPoint ?? 0)"
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
        store.addKillTeam(killTeam: model.killTeam!)
    }
    
}

extension EditUnitPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        if let indexPath = killTeam.indexOfChoosenUnit {
            model.indexPathUnit = indexPath
            if !killTeam.choosenFireTeam.isEmpty {
                model.currentUnit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
            }
        }
        model.killTeam = killTeam
        if let availableWeapon = model.currentUnit?.availableWeapon {
            var countRangeWeapon = 0
            var countCloseWeapon = 0
            availableWeapon.forEach { weapon in
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
            if countRangeWeapon != 0 {
                model.numberOfRow.append(countRangeWeapon)
                model.headerForRow.append("Range Weapon")
            }
            if countCloseWeapon != 0 {
                model.numberOfRow.append(countCloseWeapon)
                model.headerForRow.append("Close Weapon")
            }
        }
        if !killTeam.equipment.isEmpty {
            model.numberOfRow.append(killTeam.equipment.count)
            model.headerForRow.append("Equipment")
        }
    }
}

extension EditUnitPresenter: EditUnitCellDelegate {
    func selectedWargear(wargear: Weapon, selected: Bool) {
        var unit = model.currentUnit
        if selected {
            switch wargear.type {
            case "close":
                unit?.selectedCloseWeapon = wargear
            case "range":
                unit?.selectedRangeWeapon = wargear
            default:
                return
            }
            store.updateWargear(indexPath: self.model.indexPathUnit!, unit: unit!)
        }
    }
}

extension EditUnitPresenter: EditUnitEquipmentCellDelegate {
    func selectEquipment(equipment: Equipment, selected: Bool) {
        var unit = model.currentUnit
        if selected {
            if unit!.equipment.contains(equipment) {
                model.killTeam?.countEquipmentPoint += equipment.cost
                unit?.equipment.removeAll(where: { equip in
                    equip == equipment
                
                })
            } else {
                unit?.equipment.append(equipment)
                model.killTeam?.countEquipmentPoint -= equipment.cost
            }
            store.addKillTeam(killTeam: model.killTeam!)
            store.updateWargear(indexPath: self.model.indexPathUnit!, unit: unit!)
        }
    }
    
    
}
