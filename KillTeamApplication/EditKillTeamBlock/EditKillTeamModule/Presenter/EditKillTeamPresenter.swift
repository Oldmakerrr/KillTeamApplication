//
//  EditKillTeamPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol EditKillTeamProtocol: AnyObject {
    var presenter: EditKillTeamPresenterProtocol? { get }
    var customTitleView: LabelWithImageView { get }
    
}

protocol EditKillTeamPresenterProtocol: AnyObject {
    var model: ChosenKillTeam { get }
    var store: StoreProtocol { get }
    init (view: EditKillTeamProtocol, store: StoreProtocol)
    
    func addFireTeam(view: UITableViewController)
    func renameKillTeamAlertController(view: UIViewController)
    func goToEditUnitVC(indexPath: IndexPath)
    
    func changeUnitName(name: String, indexPath: IndexPath)
    func getUnitName(indexPath: IndexPath) -> String
    func removeUnit(indexPath: IndexPath)
    
    func changeUnit(unit: Unit, indexPath: IndexPath)
    func getAvailableUnit(indexPath: IndexPath) -> [Unit]?
}


protocol EditKillTeamPresenterDelegate: AnyObject {
    func didComplete(_presenter: EditKillTeamPresenterProtocol, sender: GoFromEditKillTeam)
}

class EditKillTeamPresenter: EditKillTeamPresenterProtocol {
    
    var model = ChosenKillTeam() 
    weak var view: EditKillTeamProtocol?
    weak var delegate: EditKillTeamPresenterDelegate?
    let store: StoreProtocol
    
    required init(view: EditKillTeamProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        store.multicastDelegate.addDelegate(self)
    }
    
    func addFireTeam(view: UITableViewController) {
        guard let killTeam = model.killTeam else { return }
        if killTeam.choosenFireTeam.isEmpty {
            goToAddFireTeam()
        } else {
            showAddUnitOrFireTeamAlertController(view: view, killTeam: killTeam)
        }
    }
    
//MARK: - Navigation
    
    func goToAddFireTeam() {
        guard let killTeam = model.killTeam else { return }
        delegate?.didComplete(_presenter: self, sender: .addFireTeam)
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
    
    func goToEditUnitVC(indexPath: IndexPath) {
        store.updateIndexChoosenUnit(indexPath: indexPath)
        delegate?.didComplete(_presenter: self, sender: .editUnit)
    }
    
//MARK: - MethodsEditUnit
    
    func removeUnit(indexPath: IndexPath) {
        returnCostEquipment(indexPath: indexPath)
        model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates.remove(at: indexPath.row)
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
    func getAvailableUnit(indexPath: IndexPath) -> [Unit]? {
        return model.killTeam?.choosenFireTeam[indexPath.section].availableDataslates
    }
    
    func changeUnit(unit: Unit, indexPath: IndexPath) {
        var unit = unit
        unit.updateCurrentWounds()
        returnCostEquipment(indexPath: indexPath)
        model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] = unit
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
    func changeUnitName(name: String, indexPath: IndexPath) {
        model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row].customName = name
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
    func getUnitName(indexPath: IndexPath) -> String {
        guard let unit = model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] else { return "" }
        if let unitCustomName = unit.customName {
            return unitCustomName
        } else {
            return unit.name
        }
    }
    
    private func returnCostEquipment(indexPath: IndexPath) {
        model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row].equipment.forEach({ equipment in
            model.killTeam?.countEquipmentPoint += equipment.cost
        })
    }
    
//MARK: MethodsAddUnitOrFireTeam
    
    private func showAddUnitOrFireTeamAlertController(view: UITableViewController, killTeam: KillTeam) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if killTeam.countOfFireTeam != 1 {
            addActionToAlert(alert: alert, view: view)
        } else if killTeam.fireTeam.count > 1 {
            addActionToAlert(alert: alert, view: view)
        } else {
            addUnit(index: 0, view: view)
        }
        
    }
    
    private func addActionToAlert(alert: UIAlertController, view: UITableViewController) {
        let goToAddFireTeamAction = UIAlertAction(title: "Add Fire Team", style: .default) { _ in
            self.goToAddFireTeam()
        }
        let addUnitToFireTeamAction = addUnitToFireTeamAlertAction(view: view)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(goToAddFireTeamAction)
        alert.addAction(addUnitToFireTeamAction)
        alert.addAction(cancelAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    private func addUnitToFireTeamAlertAction(view: UITableViewController) -> UIAlertAction {
        let action = UIAlertAction(title: "Add unit", style: .default) { _ in
            let alert = UIAlertController(title: "Choose FireTeam", message: nil, preferredStyle: .actionSheet)
            if self.model.killTeam?.choosenFireTeam.count == 1 {
                self.addUnit(index: 0, view: view)
            } else {
                for (index, fireTeam) in self.model.killTeam!.choosenFireTeam.enumerated() {
                    let action = UIAlertAction(title: "\(index+1): \(fireTeam.name)", style: .default) { _ in
                        self.addUnit(index: index, view: view)
                    }
                    alert.addAction(action)
                }
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(actionCancel)
                view.present(alert, animated: true, completion: nil)
            }
        }
        return action
    }
    
    private func addUnit(index: Int, view: UITableViewController) {
        if model.killTeam?.choosenFireTeam[index].availableDataslates.count == 1 {
            if var unit = model.killTeam?.choosenFireTeam[index].availableDataslates.first {
                unit.updateCurrentWounds()
                self.model.killTeam?.choosenFireTeam[index].currentDataslates.insert(unit, at: 0)
                view.tableView.reloadData()
                self.store.updateCurrentKillTeam(killTeam: self.model.killTeam!)
            }
        } else {
            let alert = UIAlertController(title: "Add unit", message: nil, preferredStyle: .actionSheet)
            self.model.killTeam?.choosenFireTeam[index].availableDataslates.forEach { unit in
                let action = UIAlertAction(title: unit.name, style: .default) { _ in
                    var unit = unit
                    unit.updateCurrentWounds()
                    self.model.killTeam?.choosenFireTeam[index].currentDataslates.insert(unit, at: 0)
                    view.tableView.reloadData()
                    self.store.updateCurrentKillTeam(killTeam: self.model.killTeam!)
                }
                alert.addAction(action)
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
            view.present(alert, animated: true, completion: nil)
        }
    }
    
//MARK: - EditKillTeam
    
    func renameKillTeamAlertController(view: UIViewController) {
        let alert = UIAlertController(title: "Input name for your Kill Team", message: nil, preferredStyle: .alert)
        let renameAction = UIAlertAction(title: "Rename", style: .default) { [weak self] action in
            guard let self = self else { return }
            do {
                if let text = try alert.inputText() {
                    self.model.killTeam?.userCustomName = text
                    self.view?.customTitleView.setupText(text: text)
                    self.store.updateCurrentKillTeam(killTeam: self.model.killTeam!)
                }
            } catch {
                print(error)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.text = self.model.killTeam?.userCustomName ?? ""
        }
        alert.addAction(renameAction)
        alert.addAction(cancelAction)
        view.present(alert, animated: true, completion: nil)
    }
    
}
//MARK: - Delegate Method


extension EditKillTeamPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let killTeam = killTeam else { return }
        model.killTeam = killTeam
    }
}


