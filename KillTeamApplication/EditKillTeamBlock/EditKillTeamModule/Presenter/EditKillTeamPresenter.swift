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
    var userSettings: UserSettingsProtocol { get set }
    init (view: EditKillTeamProtocol, store: StoreProtocol, userSettings: UserSettingsProtocol)
    
    func addFireTeam(view: UITableViewController)
    func renameKillTeamAlertController(view: UIViewController)
    func goToEditUnitVC(indexPath: IndexPath)
    
    func changeUnitName(name: String, indexPath: IndexPath)
    func getUnitName(indexPath: IndexPath) -> String
    func removeUnit(indexPath: IndexPath)
    func removeFireTeam(indexPath: IndexPath)
    
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
    var userSettings: UserSettingsProtocol
    
    required init(view: EditKillTeamProtocol, store: StoreProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.store = store
        self.userSettings = userSettings
        store.multicastDelegate.addDelegate(self)
    }
    
    func addFireTeam(view: UITableViewController) {
        guard let killTeam = model.killTeam else { return }
        if killTeam.chosenFireTeams.isEmpty {
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
        model.killTeam?.chosenFireTeams[indexPath.section].currentDataslates.remove(at: indexPath.row)
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
    func removeFireTeam(indexPath: IndexPath) {
        model.killTeam?.chosenFireTeams.remove(at: indexPath.section)
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
    func getAvailableUnit(indexPath: IndexPath) -> [Unit]? {
        return model.killTeam?.chosenFireTeams[indexPath.section].availableDataslates
    }
    
    func changeUnit(unit: Unit, indexPath: IndexPath) {
        returnCostEquipment(indexPath: indexPath)
        model.killTeam?.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row] = unit
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
    func changeUnitName(name: String, indexPath: IndexPath) {
        model.killTeam?.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row].customName = name
        if let killTeam = model.killTeam {
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
    }
    
    func getUnitName(indexPath: IndexPath) -> String {
        guard let unit = model.killTeam?.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row] else { return "" }
        if let unitCustomName = unit.customName {
            return unitCustomName
        } else {
            return unit.name
        }
    }
    
    private func returnCostEquipment(indexPath: IndexPath) {
        model.killTeam?.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row].equipments.forEach({ equipment in
            model.killTeam?.countEquipmentPoint += equipment.cost
        })
    }
    
//MARK: MethodsAddUnitOrFireTeam
    
    private func showAddUnitOrFireTeamAlertController(view: UITableViewController, killTeam: KillTeam) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if killTeam.countOfFireTeam != 1 {
            addActionToAlert(alert: alert, view: view)
        } else if killTeam.fireTeams.count > 1 {
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
            if self.model.killTeam?.chosenFireTeams.count == 1 {
                self.addUnit(index: 0, view: view)
            } else {
                for (index, fireTeam) in self.model.killTeam!.chosenFireTeams.enumerated() {
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
        if model.killTeam?.chosenFireTeams[index].availableDataslates.count == 1 {
            if let unit = model.killTeam?.chosenFireTeams[index].availableDataslates.first {
                self.model.killTeam?.chosenFireTeams[index].currentDataslates.insert(unit, at: 0)
                view.tableView.reloadData()
                self.store.updateCurrentKillTeam(killTeam: self.model.killTeam!)
            }
        } else {
            let alert = UIAlertController(title: "Add unit", message: nil, preferredStyle: .actionSheet)
            self.model.killTeam?.chosenFireTeams[index].availableDataslates.forEach { unit in
                let action = UIAlertAction(title: unit.name, style: .default) { _ in
                    self.model.killTeam?.chosenFireTeams[index].currentDataslates.insert(unit, at: 0)
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
        let alert = UIAlertController(title: "Enter a name for your Kill Team", message: nil, preferredStyle: .alert)
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

extension EditKillTeamPresenter: TableViewEmptyStateDelegate {
    func didComplete(_ tableViewEmptyState: TableViewEmptyState) {
        goToAddFireTeam()
    }
    
    
}

