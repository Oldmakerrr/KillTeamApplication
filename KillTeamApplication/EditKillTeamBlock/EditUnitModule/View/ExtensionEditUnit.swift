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
        if presenter.model.killTeam?.abilityOfKillTeam is LegionaryAbility ||
            presenter.model.killTeam?.abilityOfKillTeam is WarpcovenAbility {
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
    
    func setupUnitNameLabelView() {
        guard let unit = presenter?.model.currentUnit else { return }
        view.addSubview(unitNameLabelView)
        unitNameLabelView.setupText(text: unit.customName ?? unit.name)
        unitNameLabelView.label.textColor = .white
        unitNameLabelView.label.numberOfLines = 1
        unitNameLabelView.label.adjustsFontSizeToFitWidth = true
        unitNameLabelView.label.textAlignment = .center
        NSLayoutConstraint.activate([
            unitNameLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            unitNameLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            unitNameLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            unitNameLabelView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupTableView() {
        tableView.dataSource = presenter as? UITableViewDataSource
        tableView.delegate = presenter as? UITableViewDelegate
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
    
    func showMoreInfo(AboutWargear wargear: Wargear) {
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
    }
}


