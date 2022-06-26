//
//  ExtensionEditUnit.swift
//  KillTeamApplication
//
//  Created by Apple on 10.04.2022.
//

import Foundation
import UIKit

extension EditUnitViewController {
    
    func showCoachMarks() {
        if !isCoachMarkShowed() {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }
    
//MARK: - ChaosBlessing
    
    func setupChaosBlesisnButton() {
        guard let presenter = presenter else { return }
        if presenter.model.killTeam?.abilitiesOfKillTeam is LegionaryAbilitie ||
            presenter.model.killTeam?.abilitiesOfKillTeam is WarpcovenAbilitie {
            chaosBlessingButton = UIButton()
            presenter.updateButtonImage()
            guard let chaosBlessingButton = chaosBlessingButton else { return }
            setupRightNavigationView(view: chaosBlessingButton)
            chaosBlessingButton.addTarget(self, action: #selector(chaosBlesingButtonAction), for: .touchUpInside)
        }
    }
    
    @objc private func chaosBlesingButtonAction() {
        presenter?.goToAbilitieKillTeamViewController()
    }
    
    
//MARK: - Methods
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: unitNameLabelView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showChooseAbilitieAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func registerCell() {
        tableView.register(EditUnitWargearCell.self, forCellReuseIdentifier: EditUnitWargearCell.identifier)
        tableView.register(EditUnitEquipmentCell.self, forCellReuseIdentifier: EditUnitEquipmentCell.identifier)
    }
    
    func setupWargearView<T: WargearView>(view: T, wargear: T.Wargear, delegate: T.Delegate, viewWidth: CGFloat) {
        view.setupText(wargear: wargear, delegate: delegate as? WeaponRuleButtonDelegate, viewWidth: viewWidth)
        view.setupButton()
        view.setDelegate(delegate: delegate)
        guard let view = view as? UIView else { return }
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
    }
    
    func addSwipeAction(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let action = UIContextualAction(style: .normal, title: "More info") { _, _, complition in
            guard let wargear = self.presenter?.model.wargear[indexPath.section][indexPath.row] else { return }
            if let weapon = wargear as? Weapon {
                let view = WeaponView()
                self.showAlert(alertView: view)
                self.setupWargearView(view: view, wargear: weapon, delegate: self, viewWidth: view.getViewWidth())
            }
            if let equipment = wargear as? Equipment {
                let view = EquipmentView()
                self.showAlert(alertView: view)
                self.setupWargearView(view: view, wargear: equipment, delegate: self, viewWidth: view.getViewWidth())
            }
            complition(true)
        }
        action.backgroundColor = ColorScheme.shared.theme.swipeInfoAction
        action.title = "Info"
        action.image = UIImage(systemName: "info.circle.fill")
        return UISwipeActionsConfiguration(actions: [action])
    }
}


