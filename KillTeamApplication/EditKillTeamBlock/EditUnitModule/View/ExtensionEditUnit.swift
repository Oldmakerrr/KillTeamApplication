//
//  ExtensionEditUnit.swift
//  KillTeamApplication
//
//  Created by Apple on 10.04.2022.
//

import Foundation
import UIKit

extension EditUnitViewController {
    
//MARK: - ChaosBlessing
    
    func setupChaosBlesisnButton() {
        if presenter?.model.killTeam?.abilitiesOfKillTeam is LegionaryAbilitie ||
            presenter?.model.killTeam?.abilitiesOfKillTeam is WarpcovenAbilitie {
            chaosBlessingButton = UIBarButtonItem(image: UIImage(named: presenter?.setImage() ?? "killTeamViewController"),
                                     style: .done,
                                     target: self,
                                     action: #selector(chaosBlesingButtonAction))
            navigationItem.rightBarButtonItem = chaosBlessingButton
        }
        
    }
    
    @objc private func chaosBlesingButtonAction() {
        presenter?.goToAbilitieKillTeamViewController()
    }
    
    
//MARK: - Methods
    
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
    
    func setupNavigationTitlelabel() {
        guard let countOfEquipmentPoint = presenter?.model.killTeam?.countEquipmentPoint  else { return }
        countOfEquipmentPointLabel.text = "EP = \(countOfEquipmentPoint)"
        countOfEquipmentPointLabel.textColor = .white
        navigationItem.titleView = countOfEquipmentPointLabel
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

