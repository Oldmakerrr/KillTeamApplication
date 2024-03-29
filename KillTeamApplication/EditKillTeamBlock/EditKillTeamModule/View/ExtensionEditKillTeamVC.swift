//
//  ExtensionEditKillTeamVC.swift
//  KillTeamApplication
//
//  Created by Apple on 08.05.2022.
//

import UIKit
import Instructions

extension EditKillTeamTableViewController {
    
    func showCoachMarks() {
        guard let killTeam = presenter?.model.killTeam else { return }
        if !isCoachMarkShowed() && !killTeam.chosenFireTeams.isEmpty {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }
    
    func checkTableViewState() {
        if presenter?.model.killTeam?.chosenFireTeams.count == 0 {
            setEmptyState(title: "No Fire Team",
                          message: "Please add a Fire Team",
                          buttonTitle: "Add a Fire Team",
                          delegate: presenter as? TableViewEmptyStateDelegate)
            addUnitOrFireTeamButton.removeFromSuperview()
        } else {
            restore()
            setupAddButton()
        }
    }
    
    @objc func addFireTeam() {
        addUnitOrFireTeamButton.animateSelectView(scale: 0.9) { _ in
            self.presenter?.addFireTeam(view: self)
        }
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
        action.backgroundColor = ColorScheme.shared.theme.selectedView
        action.image = UIImage(systemName: "arrow.swap")
        return action
    }
    
    func removeUnitAction(indexPath: IndexPath, section: IndexSet, tableView: UITableView) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Remove") { [weak self] action, _, completion in
            guard let self = self else { return }
            action.backgroundColor = .clear
            self.presenter?.removeUnit(indexPath: indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            if self.presenter?.model.killTeam?.chosenFireTeams[indexPath.section].currentDataslates.count == 0 {
                tableView.beginUpdates()
                self.presenter?.removeFireTeam(indexPath: indexPath)
                self.tableView.deleteSections(section, with: .automatic)
                tableView.endUpdates()
            }
            completion(true)
            self.checkTableViewState()
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
            guard let self = self,
                  let unit = self.presenter?.model.killTeam?.chosenFireTeams[indexPath.section].currentDataslates[indexPath.row] else { return }
            do {
                if let newName = try alert.inputText(maxTextLength: unit.name.count + 15) {
                    self.presenter?.changeUnitName(name: newName, indexPath: indexPath)
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { [ weak self ] textField in
            guard let self = self else { return }
            textField.text = self.presenter?.getUnitName(indexPath: indexPath)
        }
        alert.addAction(actionRename)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
}
