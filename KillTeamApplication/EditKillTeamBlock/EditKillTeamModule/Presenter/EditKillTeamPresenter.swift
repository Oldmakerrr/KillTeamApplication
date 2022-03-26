//
//  EditKillTeamPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol EditKillTeamProtocol: AnyObject {
    var presenter: EditKillTeamPresenterProtocol? { get set }
    
}

protocol EditKillTeamPresenterProtocol: AnyObject {
    var model: ChosenKillTeam { get set }
    var store: StoreProtocol { get }
    init (view: EditKillTeamProtocol, store: StoreProtocol)
    func goToEditUnitVC(indexPath: IndexPath)
    func goToAddFireTeam()
    func changeUnitAction(indexPath: IndexPath)-> UIContextualAction
    func removeUnitAction(indexPath: IndexPath) -> UIContextualAction
    func renameUnitAction(indexPath: IndexPath) -> UIContextualAction
    func additionalSettings()
}

protocol DataSenderUnitProtocol: AnyObject {
    func sendUnit(unit: Unit)
}

protocol EditKillTeamPresenterDelegate: AnyObject {
    func didComplete(_presenter: EditKillTeamPresenterProtocol, sender: GoFromEditKillTeam)
}

class EditKillTeamPresenter: EditKillTeamPresenterProtocol {
    
    var model = ChosenKillTeam() {
        didSet {
            guard let view = view as? UITableViewController else { return }
            view.title = model.killTeam?.userCustomName ?? model.killTeam?.killTeamName
        }
    }
    weak var view: EditKillTeamProtocol?
    weak var delegate: EditKillTeamPresenterDelegate?
    var store: StoreProtocol
    
    var arrayKey: [String] = []
    
    required init(view: EditKillTeamProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        store.multicastDelegate.addDelegate(self)
        if let keys = KeySaver.getKey() {
            arrayKey = keys
        
        }
    }
    
    //MARK: - Navigation
    
    func goToAddFireTeam() {
        guard let killTeam = model.killTeam else { return }
        delegate?.didComplete(_presenter: self, sender: .addFireTeam)
        store.addKillTeam(killTeam: killTeam)
    }
    
    func goToEditUnitVC(indexPath: IndexPath) {
        delegate?.didComplete(_presenter: self, sender: .editUnit)
        store.addIndexOfChoosenUnit(index: indexPath)
    }
    
    //MARK: - Edit KillTeam
    
    func editKillTeamAlert() {
        //
    }
    
    //MARK: - Change Unit with TableView
    
    func removeUnitAction(indexPath: IndexPath) -> UIContextualAction {
        guard let view = view as? UITableViewController else { return UIContextualAction() }
        let action = UIContextualAction(style: .destructive, title: "Remove") { _, _, completion in
            self.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates.remove(at: indexPath.row)
            view.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.store.addKillTeam(killTeam: self.model.killTeam!)
            completion(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "minus.square.fill")
        return action
    }
    
    func changeUnitAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Change") {(_, _, completion) in
            self.changeUnitaAlert(indexPath: indexPath)
            completion(true)
        }
        action.backgroundColor = .orange
        action.image = UIImage(systemName: "arrow.swap")
        return action
    }
    
    func renameUnitAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Rename") {(_, _, completion) in
            self.renameUnitAlert(indexPath: indexPath)
            completion(true)
        }
        action.backgroundColor = .blue
        action.image = UIImage(systemName: "square.and.pencil")
        return action
    }
    
    func changeUnitaAlert(indexPath: IndexPath) {
        guard let view = view as? UITableViewController else { return }
        let alert = UIAlertController(title: "Change unit", message: nil, preferredStyle: .actionSheet)
        if let availableUnit = model.killTeam?.choosenFireTeam[indexPath.section].availableDataslates {
            for unit in availableUnit {
                let action = UIAlertAction(title: unit.name, style: .default) { _ in
                    self.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] = unit
                    view.tableView.reloadData()
                    self.store.addKillTeam(killTeam: self.model.killTeam!)
                }
                alert.addAction(action)
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionCancel)
        view.present(alert, animated: true, completion: nil)
    }
    
    func renameUnitAlert(indexPath: IndexPath) {
        guard let view = view as? UITableViewController else { return }
        let alert = UIAlertController(title: "Rename", message: "Input new name for this unit", preferredStyle: .alert)
        let actionRename = UIAlertAction(title: "Rename", style: .default) { action in
            let textField = alert.textFields?.first
            if let newName = textField?.text {
                self.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row].customName = newName
                self.store.addKillTeam(killTeam: self.model.killTeam!)
                view.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Cancle", style: .cancel) { _ in
        }
        
        alert.addTextField { textField in
            let unit = self.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
            textField.text = unit?.customName ?? unit?.name
        }
        alert.addAction(actionRename)
        alert.addAction(cancel)
        view.present(alert, animated: true, completion: nil)
        
    }
    
//MARK: - EdditingKillTeamAlert
    
    private func addUnitToFireTeam() -> UIAlertAction {
        guard let view = view as? UITableViewController else { return UIAlertAction() }
        let action = UIAlertAction(title: "Add unit", style: .default) { _ in
            let alert = UIAlertController(title: "Add unit", message: "Choose FireTeam", preferredStyle: .alert)
            if self.model.killTeam?.choosenFireTeam.count == 1 {
                self.addUnit(index: 0)
            } else {
                for (index, fireTeam) in self.model.killTeam!.choosenFireTeam.enumerated() {
                    let action = UIAlertAction(title: fireTeam.name, style: .default) { _ in
                        self.addUnit(index: index)
                    }
                    alert.addAction(action)
                }
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
            view.present(alert, animated: true, completion: nil)
        }
        return action
    }
    
    private func addUnit(index: Int) {
        guard let view = view as? UITableViewController else { return }
        let alert = UIAlertController(title: "Add unit", message: nil, preferredStyle: .actionSheet)
        self.model.killTeam?.choosenFireTeam[index].availableDataslates.forEach { unit in
            let action = UIAlertAction(title: unit.name, style: .default) { _ in
                self.model.killTeam?.choosenFireTeam[index].currentDataslates.insert(unit, at: 0)
                view.tableView.reloadData()
                self.store.addKillTeam(killTeam: self.model.killTeam!)
            }
            alert.addAction(action)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionCancel)
        view.present(alert, animated: true, completion: nil)
    }
    
    func additionalSettings() {

        guard let view = view as? UITableViewController, let killTeam = model.killTeam else { return }
        let alert = UIAlertController(title: "Edit your Kill Team", message: nil, preferredStyle: .alert)
        let renameKillTeamAction = self.renameKillTeamAlertController()
        let goToAddFireTeamAction = UIAlertAction(title: "Add Fire Team", style: .default) { _ in
            self.goToAddFireTeam()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(goToAddFireTeamAction)
        if !killTeam.choosenFireTeam.isEmpty {
            let addUnitToFireTeamAction = addUnitToFireTeam()
            alert.addAction(addUnitToFireTeamAction)
        }
        alert.addAction(renameKillTeamAction)
        alert.addAction(cancelAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    func renameKillTeamAlertController() -> UIAlertAction {
        guard let view = view as? UITableViewController else { return UIAlertAction() }
        let action = UIAlertAction(title: "Rename Kill Team", style: .default) { _ in
            let alert = UIAlertController(title: "Input name for your Kill Team", message: nil, preferredStyle: .alert)
            let renameAction = UIAlertAction(title: "Rename", style: .default) { action in
                let textField = alert.textFields?.first
                if let newName = textField?.text {
                    self.model.killTeam?.userCustomName = newName
                    self.store.addKillTeam(killTeam: self.model.killTeam!)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addTextField { textField in
                textField.text = self.model.killTeam?.userCustomName ?? ""
            }
            alert.addAction(renameAction)
            alert.addAction(cancelAction)
            view.present(alert, animated: true, completion: nil)
        }
        return action
    }
}
//MARK: - Delegate Method
    
extension EditKillTeamPresenter: DataSenderUnitProtocol {
    func sendUnit(unit: Unit) {
        model.choosenUnits.append(unit)
    }
}

extension EditKillTeamPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        model.killTeam = killTeam
    }
}
