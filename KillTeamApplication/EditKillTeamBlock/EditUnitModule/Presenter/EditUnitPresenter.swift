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
    var chaosBlessingButton: UIButton? { get }
    func showChooseAbilitieAlert(title: String)
}

protocol EditUnitPresenterProtocol: AnyObject {
    var view: EditUnitViewControllerProtocol? { get }
    var model: ChoosenUnit { get }
    var store: StoreProtocol { get }
    var userSettings: UserSettingsProtocol { get }
    init (view: EditUnitViewControllerProtocol, store: StoreProtocol, userSettings: UserSettingsProtocol)
    
    func goToAbilitieKillTeamViewController()
    func updateButtonImage()
    func selectCell(wargear: Wargear)
    func clearIndex()
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
            updateButtonImage()
        }
    }
    
    var store: StoreProtocol
    
    let userSettings: UserSettingsProtocol
    
    required init(view: EditUnitViewControllerProtocol, store: StoreProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.store = store
        self.userSettings = userSettings
        self.store.multicastDelegate.addDelegate(self)
        self.model.indexPathUnit = store.indexOfChoosenUnit
        prepareModel()
        prepeareWargear(store: store)
    }
    
    func clearIndex() {
        store.clearIndexChoosenUnit()
    }
    
    private func prepareModel() {
        guard let killTeam = store.getKillTeam(), let indexPath = store.indexOfChoosenUnit else { return }
        model.killTeam = killTeam
        model.indexPathUnit = indexPath
        if !killTeam.chosenFireTeams.isEmpty {
            model.currentUnit = killTeam.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row]
        }
    }
    
    private func prepeareWargear(store: StoreProtocol) {
        guard let killTeam = store.getKillTeam(),
              let indexPath = store.indexOfChoosenUnit else { return }
        let unit = killTeam.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row]
        if let weapon = unit.availableWeapons {
            sortSeapon(weapons: weapon)
        }
        model.wargear.append(killTeam.equipments)
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
    
    private func getImageName() -> String {
        guard let chaosBlessing = model.currentUnit?.additionalAbility else { return "killTeamViewController" }
        if let chaosBlessingName = chaosBlessing.name.components(separatedBy: " ").first {
            return chaosBlessingName
        } else {
            return "killTeamViewController"
        }
    }
    
    func updateButtonImage() {
        guard let button = view?.chaosBlessingButton else { return }
        let imageName = getImageName()
        let image = UIImage(named: imageName)?.withTintColor(ColorScheme.shared.theme.selectedView).withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
    }
    
    func selectCell(wargear: Wargear) {
        guard var unit = model.currentUnit,
              var killTeam = model.killTeam else { return }
        if let weapon = wargear as? Weapon {
            switch weapon.type {
            case .range:
                unit.selectedRangeWeapon = weapon
            case .close:
                unit.selectedMeleeWeapon = weapon
            }
        }
        if let equipment = wargear as? Equipment {
            if unit.equipments.contains(equipment) {
                killTeam.countEquipmentPoint += equipment.cost
                unit.equipments.removeAll(where: { equip in
                    equip == equipment
                })
            } else {
                unit.equipments.append(equipment)
                killTeam.countEquipmentPoint -= equipment.cost
            }
        }
        updateUnitWargear(unit: unit, killTeam: killTeam)
    }
    
    private func updateUnitWargear(unit: Unit, killTeam: KillTeam) {
        guard let indexPath = model.indexPathUnit else { return }
        var killTeam = killTeam
        killTeam.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row] = unit
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
    
    private func addAdditionalAbilitie(abilitie: UnitAbilitieProtocol) {
        guard var unit = model.currentUnit,
              let indexPath = model.indexPathUnit else { return }
        unit.additionalAbility = abilitie
        model.killTeam?.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row] = unit
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
}

extension EditUnitPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let killTeam = killTeam, let indexPath = store.indexOfChoosenUnit else { return }
        model.killTeam = killTeam
        if !killTeam.chosenFireTeams.isEmpty {
            model.currentUnit = killTeam.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row]
        }
    }
}

//MARK: - KillTeamAbilitieViewControllerDelegate

extension EditUnitPresenter: ChaosBlessingTableViewControllerDelegate {
    func didSelect(_ chaosBlessingTableViewController: ChaosBlessingTableViewController, chaosBlessing: UnitAbilitie) {
        guard let view = view as? UIViewController else { return }
        addAdditionalAbilitie(abilitie: chaosBlessing)
        chaosBlessingTableViewController.dismiss(animated: true) { 
            if let nameOfMarkOfChaos = chaosBlessing.name.components(separatedBy: " ").first {
                view.showToast(message: "Mark of \(nameOfMarkOfChaos) selected")
            }
        }
    }
    
    
}

extension EditUnitPresenter: BoonOfTzeenchTableViewControllerDelegate {
    func didComplete(_ boonOfTzeenchTableViewController: BoonOfTzeenchTableViewController, boonOfTzeentch: WarpcovenAbilitie.BoonsOfTzeentch) {
        guard let view = view as? UIViewController else { return }
        addAdditionalAbilitie(abilitie: boonOfTzeentch)
        boonOfTzeenchTableViewController.dismiss(animated: true) {
            view.showToast(message: "\(boonOfTzeentch.name) selected")
        }
        
    }
    
    
}
