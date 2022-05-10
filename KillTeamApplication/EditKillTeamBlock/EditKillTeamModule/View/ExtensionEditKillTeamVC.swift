//
//  ExtensionEditKillTeamVC.swift
//  KillTeamApplication
//
//  Created by Apple on 08.05.2022.
//

import UIKit

extension EditKillTeamTableViewController {
    
    @objc func addFireTeam() {
        presenter?.addFireTeam(view: self)
    }
    
    func addGestureToTitleView() {
        guard let titleView = navigationItem.titleView else { return }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        gesture.numberOfTapsRequired = 1
        titleView.addGestureRecognizer(gesture)
    }
    
    @objc private func gestureAction() {
        presenter?.renameKillTeamAlertController(view: self)
    }
    
    func setupTitleView(name: String?) {
        customTitleView.setupText(text: name)
        customTitleView.label.textColor = .white
        let image = UIImage(systemName: "square.and.pencil")
        customTitleView.setupImage(image: image)
        navigationItem.titleView = customTitleView
    }
    
    func setupAddButton() {
        guard let tabBarController = tabBarController, let tabBarView = tabBarController.view else { return }
        addUnitOrFireTeamButton.setupButton(tabBarController: tabBarController, tabBarView: tabBarView)
        addUnitOrFireTeamButton.addTarget(self, action: #selector(addFireTeam), for: .touchUpInside)
    }
    
//MARK: - ContextualActions
    
    func renameUnitAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Rename") { [self] (_, _, completion) in
            renameUnit(indexPath: indexPath)
            completion(true)
        }
        action.backgroundColor = .none
        action.image = UIImage(systemName: "square.and.pencil")
        return action
    }
    
    func changeUnitAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Change") {[self](_, _, completion) in
            changeUnit(indexPath: indexPath)
            completion(true)
        }
        action.backgroundColor = .orange
        action.image = UIImage(systemName: "arrow.swap")
        return action
    }
    
    func removeUnitAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, completion in
            guard let self = self else { return }
            self.presenter?.removeUnit(indexPath: indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "minus.square.fill")
        return action
    }
    
    private func changeUnit(indexPath: IndexPath) {
        guard let availableUnit = presenter?.getAvailableUnit(indexPath: indexPath) else { return }
        let alert = UIAlertController(title: "Change unit", message: nil, preferredStyle: .actionSheet)
        for unit in availableUnit {
            let action = UIAlertAction(title: unit.name, style: .default) {[weak self] _ in
                guard let self = self else { return }
                self.presenter?.changeUnit(unit: unit, indexPath: indexPath)
                self.tableView.reloadData()
            }
            alert.addAction(action)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    private func renameUnit(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Rename",
                                      message: "Input new name for this unit",
                                      preferredStyle: .alert)
        let actionRename = UIAlertAction(title: "Rename", style: .default) { [weak self] action in
            guard let self = self else { return }
            let textField = alert.textFields?.first
            if let newName = textField?.text {
                self.presenter?.changeUnitName(name: newName, indexPath: indexPath)
                self.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alert.addTextField { [ weak self ] textField in
            guard let self = self else { return }
            textField.text = self.presenter?.getUnitName(indexPath: indexPath)
        }
        alert.addAction(actionRename)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
}
