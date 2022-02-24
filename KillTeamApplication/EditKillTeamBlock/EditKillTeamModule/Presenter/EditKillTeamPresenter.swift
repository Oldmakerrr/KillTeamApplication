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
    func changeUnitAction(indexPath: IndexPath, view: UITableViewController)-> UIContextualAction
    func addUnitAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction
    func removeUnitAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction
    func renameUnitAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction
    func additionalSettings(view: UITableViewController)
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
        delegate?.didComplete(_presenter: self, sender: .addFireTeam)
        store.addKillTeam(killTeam: model.killTeam!)
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
    
    func removeUnitAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction {
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
    
    func addUnitAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Add") { _, _, completion in
            self.addUnitAlert(indexPath: indexPath, view: view)
            completion(true)
        }
        action.backgroundColor = .green
        action.image = UIImage(systemName: "plus.app.fill")
        return action
    }
    
    func changeUnitAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Change") {(_, _, completion) in
            self.changeUnitaAlert(indexPath: indexPath, view: view)
            completion(true)
        }
        action.backgroundColor = .orange
        action.image = UIImage(systemName: "arrow.swap")
        return action
    }
    
    func renameUnitAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Rename") {(_, _, completion) in
            self.renameUnitAlert(indexPath: indexPath, view: view)
            completion(true)
        }
        action.backgroundColor = .blue
        action.image = UIImage(systemName: "square.and.pencil")
        return action
    }
    
    func changeUnitaAlert(indexPath: IndexPath, view: UITableViewController) {
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
        view.present(alert, animated: true, completion: nil)
    }
    

    
    func addUnitAlert(indexPath: IndexPath, view: UITableViewController) {
        let alert = UIAlertController(title: "Add unit", message: nil, preferredStyle: .actionSheet)
        if let availableUnit = model.killTeam?.choosenFireTeam[indexPath.section].availableDataslates {
            for unit in availableUnit {
                let action = UIAlertAction(title: unit.name, style: .default) { _ in
                    self.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates.insert(unit, at: indexPath.row)
                    view.tableView.reloadData()
                    self.store.addKillTeam(killTeam: self.model.killTeam!)
                }
                alert.addAction(action)
            }
        }
        view.present(alert, animated: true, completion: nil)
    }
    
    func renameUnitAlert(indexPath: IndexPath, view: UITableViewController) {
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
    
//MARK: EdditingKillTeamAlert
    
    func additionalSettings(view: UITableViewController) {
        let alert = UIAlertController(title: "Edit your Kill Team", message: nil, preferredStyle: .alert)
        let renameKillTeamAction = UIAlertAction(title: "Rename Kill Team", style: .default) { _ in
            self.renameKillTeamAlertController(title: "Rename", alertTitle: "Input name for your Kill Team", message: "")
        }
        
        let goToAddFireTeamAction = UIAlertAction(title: "Add Fire Team", style: .default) { _ in
            self.delegate?.didComplete(_presenter: self, sender: .addFireTeam)
            self.store.addKillTeam(killTeam: self.model.killTeam!)
        }
    
        let cancel = UIAlertAction(title: "Cancle", style: .cancel) { _ in
        }
        alert.addAction(goToAddFireTeamAction)
        alert.addAction(renameKillTeamAction)
        alert.addAction(cancel)
        view.present(alert, animated: true, completion: nil)
    }
    
    func renameKillTeamAlertController(title: String, alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let actionRename = UIAlertAction(title: title, style: .default) { action in
            let textField = alert.textFields?.first
            if let newName = textField?.text {
                self.model.killTeam?.userCustomName = newName
                self.store.addKillTeam(killTeam: self.model.killTeam!)
            }
        }
        let cancel = UIAlertAction(title: "Cancle", style: .cancel) { _ in
        }
        
        alert.addTextField { textField in
            textField.text = self.model.killTeam?.userCustomName ?? ""
        }
        alert.addAction(actionRename)
        alert.addAction(cancel)
        let view = view as? UITableViewController
        if let view = view {
            view.present(alert, animated: true, completion: nil)
        }
    }
}
//MARK: - Delegate Method
    
extension EditKillTeamPresenter: DataSenderUnitProtocol {
    func sendUnit(unit: Unit) {
        model.choosenUnits.append(unit)
    }
}

extension EditKillTeamPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        model.killTeam = killTeam
    }
}
