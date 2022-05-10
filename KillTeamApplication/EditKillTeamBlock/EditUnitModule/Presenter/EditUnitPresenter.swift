//
//  EditUnitPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol EditUnitViewControllerProtocol: AnyObject {
    var presenter: EditUnitPresenterProtocol? { get }
    var countOfEquipmentPointLabel: BoldLabel { get }
    var chaosBlessingButton: UIBarButtonItem? { get }
    func showChooseAbilitieAlert(title: String)
}

protocol EditUnitPresenterProtocol: AnyObject {
    var view: EditUnitViewControllerProtocol? { get }
    var model: ChoosenUnit { get }
    var store: StoreProtocol { get }
    init (view: EditUnitViewControllerProtocol, store: StoreProtocol)
    
    func goToAbilitieKillTeamViewController()
    func setImage() -> String?
    func selectCell(wargear: Wargear)
}

protocol EditUnitPresenterDelegate: AnyObject {
    func didComplete(_ editUnitPresenter: EditUnitPresenter)
}

class EditUnitPresenter: EditUnitPresenterProtocol {
    
    weak var delegate: EditUnitPresenterDelegate?
    
    weak var view: EditUnitViewControllerProtocol?
    
    var model = ChoosenUnit() {
        didSet {
            view?.countOfEquipmentPointLabel.text = "EP = \(model.killTeam?.countEquipmentPoint ?? 0)"
            updateButtonImage(imageName: setImage())
        }
    }
    
    var store: StoreProtocol
    
    required init(view: EditUnitViewControllerProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        self.store.multicastDelegate.addDelegate(self)
        self.model.indexPathUnit = store.indexOfChoosenUnit
        prepareModel()
        prepeareWargear(store: store)
    }
    
    private func prepareModel() {
        guard let killTeam = store.getKillTeam(), let indexPath = store.indexOfChoosenUnit else { return }
        model.killTeam = killTeam
        model.indexPathUnit = indexPath
        if !killTeam.choosenFireTeam.isEmpty {
            model.currentUnit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
        }
    }
    
    private func prepeareWargear(store: StoreProtocol) {
        guard let killTeam = store.getKillTeam(),
              let indexPath = store.indexOfChoosenUnit else { return }
        let unit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
        if let weapon = unit.availableWeapon {
            sortSeapon(weapons: weapon)
        }
        model.wargear.append(killTeam.equipment)
        model.headerForRow.append("Equipment")
    }
    
    private func sortSeapon(weapons: [Weapon]) {
        var rangeWeapon = [Weapon]()
        var meleeWeapon = [Weapon]()
        weapons.forEach { weapon in
            switch weapon.type {
            case .range:
                rangeWeapon.append(weapon)
            case .close:
                meleeWeapon.append(weapon)
            }
        }
        if !rangeWeapon.isEmpty {
            model.headerForRow.append("Range Weapon")
            model.wargear.append(rangeWeapon)
        }
        if !meleeWeapon.isEmpty {
            model.wargear.append(meleeWeapon)
            model.headerForRow.append("Melee Weapon")
        }
    }
    
    
    func goToAbilitieKillTeamViewController() {
        delegate?.didComplete(self)
    }
    
    func setImage() -> String? {
        guard let chaosBlessing = model.currentUnit?.additionalAbilitie else { return nil }
        let chaosBlessingName = chaosBlessing.name
        return chaosBlessingName.components(separatedBy: " ").first
    }
    
    private func updateButtonImage(imageName: String?) {
        guard let button = view?.chaosBlessingButton, let imageName = imageName else { return }
        button.image = UIImage(named: imageName)
    }
    
    func selectCell(wargear: Wargear) {
        guard var unit = model.currentUnit,
              var killTeam = model.killTeam else { return }
        if let weapon = wargear as? Weapon {
            switch weapon.type {
            case .range:
                unit.selectedRangeWeapon = weapon
            case .close:
                unit.selectedCloseWeapon = weapon
            }
        }
        if let equipment = wargear as? Equipment {
            if unit.equipment.contains(equipment) {
                killTeam.countEquipmentPoint += equipment.cost
                unit.equipment.removeAll(where: { equip in
                    equip == equipment
                })
            } else {
                unit.equipment.append(equipment)
                killTeam.countEquipmentPoint -= equipment.cost
            }
        }
        updateUnitWargear(unit: unit, killTeam: killTeam)
    }
    
    private func updateUnitWargear(unit: Unit, killTeam: KillTeam) {
        guard let indexPath = model.indexPathUnit else { return }
        var killTeam = killTeam
        killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] = unit
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
    
    private func addAdditionalAbilitie(abilitie: UnitAbilitieProtocol) {
        guard var unit = model.currentUnit,
              let indexPath = model.indexPathUnit else { return }
        unit.additionalAbilitie = abilitie
        model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] = unit
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
}

extension EditUnitPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let killTeam = killTeam, let indexPath = store.indexOfChoosenUnit else { return }
        model.killTeam = killTeam
        if !killTeam.choosenFireTeam.isEmpty {
            model.currentUnit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
        }
    }
}

//MARK: - KillTeamAbilitieViewControllerDelegate

extension EditUnitPresenter: ChaosBlessingTableViewControllerDelegate {
    func didSelect(_ chaosBlessingTableViewController: ChaosBlessingTableViewController, chaosBlessing: UnitAbilitie) {
        addAdditionalAbilitie(abilitie: chaosBlessing)
        chaosBlessingTableViewController.dismiss(animated: true) { [self] in
            if let nameOfMarkOfChaos = chaosBlessing.name.components(separatedBy: " ").first {
                view?.showChooseAbilitieAlert(title: "Mark of \(nameOfMarkOfChaos) choosen")
            }
        }
    }
    
    
}

extension EditUnitPresenter: BoonOfTzeenchTableViewControllerDelegate {
    func didComplete(_ boonOfTzeenchTableViewController: BoonOfTzeenchTableViewController, boonOfTzeentch: WarpcovenAbilitie.BoonsOfTzeentch) {
        addAdditionalAbilitie(abilitie: boonOfTzeentch)
        boonOfTzeenchTableViewController.dismiss(animated: true) {  [self] in
            view?.showChooseAbilitieAlert(title: "\(boonOfTzeentch.name) choosen")
            
        }
        
    }
    
    
}
