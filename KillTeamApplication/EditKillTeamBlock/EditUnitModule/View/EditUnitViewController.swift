//
//  EditUnitViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

class EditUnitViewController: UITableViewController, EditUnitViewControllerProtocol {
    
    var presenter: EditUnitPresenterProtocol?
    
    var countOfEquipmentPointLabel = UILabel()
    
    var weaponView = WeaponView()
    var equipmentView = EquipmentView()
    lazy var customAlertInfoWeapon = CustomAlert(alertView: weaponView, targetView: view)
    lazy var customAlertInfoEquipment = CustomAlert(alertView: equipmentView, targetView: view)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        tableView.register(EditUnitWargearCell.self, forCellReuseIdentifier: EditUnitWargearCell.identifier)
        tableView.register(EditUnitEquipmentCell.self, forCellReuseIdentifier: EditUnitEquipmentCell.identifier)
            createBarlabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        countOfEquipmentPointLabel.removeFromSuperview()
    }
    
    func showWeponInfoEquipment() {
        customAlertInfoEquipment.showAlert()
        tableView.isScrollEnabled = false
    
    }
    
    @objc func dismissEquipmentInfoAlert() {
        customAlertInfoEquipment.dismissAlert()
        tableView.isScrollEnabled = true
        equipmentView = EquipmentView()
        customAlertInfoEquipment.alertView = equipmentView
    }
    
    func showWeponInfoAlert() {
        customAlertInfoWeapon.showAlert()
        tableView.isScrollEnabled = false
    }
    
    @objc func dismissWeponInfoAlert() {
        customAlertInfoWeapon.dismissAlert()
        tableView.isScrollEnabled = true
        weaponView = WeaponView()
        customAlertInfoWeapon.alertView = weaponView
    }
    
    func createBarlabel() {
        guard let navigationBar = navigationController?.navigationBar, let countOfEquipmentPoint = presenter?.model.killTeam?.countEquipmentPoint  else { return }
        navigationBar.addSubview(countOfEquipmentPointLabel)
        countOfEquipmentPointLabel.translatesAutoresizingMaskIntoConstraints = false
        countOfEquipmentPointLabel.text = "Count of Equipment Point = \(countOfEquipmentPoint)"
        NSLayoutConstraint.activate([
            countOfEquipmentPointLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -15),
            countOfEquipmentPointLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
        ])
    }
    
    func setupWeaponCell(tableView: UITableView, indexPath: IndexPath, wargear: [Weapon]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditUnitWargearCell.identifier, for: indexPath) as! EditUnitWargearCell
        presenter?.store.multicastDelegate.addDelegate(cell)
        cell.textLabel?.text = wargear[indexPath.row].name
        cell.wargear = wargear[indexPath.row]
        cell.unit = presenter?.model.currentUnit
        cell.delegate = presenter as? EditUnitCellDelegate
        return cell
    }
    
    func setupEquipmentCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditUnitEquipmentCell.identifier, for: indexPath) as! EditUnitEquipmentCell
        if let equipment = presenter?.model.killTeam?.equipment[indexPath.row] {
            presenter?.store.multicastDelegate.addDelegate(cell)
            cell.equipment = equipment
            cell.unit = presenter?.model.currentUnit
            cell.delegate = presenter as? EditUnitEquipmentCellDelegate
            cell.textLabel?.text = "\(equipment.name)"
            cell.setupCostLabel(cost: equipment.cost)
        }
            return cell
    }
    
    func addWeaponAction(wargear: [Weapon], indexPtah: IndexPath) -> UISwipeActionsConfiguration {
        let action = UIContextualAction(style: .normal, title: "More info") { [self] _, _, complition in
            let weapon = wargear[indexPtah.row]
            self.showWeponInfoAlert()
            self.weaponView.addText(weapon: weapon, delegate: self)
            if let subWeapon = weapon.secondProfile {
                for weapon in subWeapon {
                    self.weaponView.addText(weapon: weapon, delegate: self)
                }
            }
            self.weaponView.setupButton()
            self.weaponView.button.addTarget(self, action: #selector(self.dismissWeponInfoAlert), for: .touchUpInside)
            self.weaponView.layer.masksToBounds = true
            self.weaponView.layer.cornerRadius = 12
        complition(true)
        }
        action.backgroundColor = .blue
        action.title = "Info"
        action.image = UIImage(systemName: "info.circle.fill")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func addEquipmentAction(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let action = UIContextualAction(style: .normal, title: "More info") { _, _, complition in
            self.showWeponInfoEquipment()
            if let equipment = self.presenter?.model.killTeam?.equipment[indexPath.row] {
                self.equipmentView.setupText(equipment: equipment, delegate: self)
                self.equipmentView.setupButton()
                self.equipmentView.button.addTarget(self, action: #selector(self.dismissEquipmentInfoAlert), for: .touchUpInside)
                self.equipmentView.layer.masksToBounds = true
                self.equipmentView.layer.cornerRadius = 12
                self.equipmentView.axis = .vertical
               
            complition(true)
            }
        }
        action.backgroundColor = .blue
        action.title = "Info"
        action.image = UIImage(systemName: "info.circle.fill")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.numberOfRow.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter?.model.numberOfRow[0] ?? 0
        case 1:
            return presenter?.model.numberOfRow[1] ?? 0
        case 2:
            return presenter?.model.numberOfRow[2] ?? 0
        default:
            return  0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return presenter?.model.headerForRow[0]
        case 1:
            return presenter?.model.headerForRow[1]
        case 2:
            return presenter?.model.headerForRow[2]
        default:
            return  ""
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.model else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            if !model.rangeWeapon.isEmpty {
                return setupWeaponCell(tableView: tableView, indexPath: indexPath, wargear: model.rangeWeapon)
            } else {
                if !model.closeWeapon.isEmpty {
                    return setupWeaponCell(tableView: tableView, indexPath: indexPath, wargear: model.closeWeapon)
                } else {
                    return setupEquipmentCell(tableView: tableView, indexPath: indexPath)
                }
            }
        case 1:
            if model.rangeWeapon.isEmpty {
                return setupEquipmentCell(tableView: tableView, indexPath: indexPath)
            } else {
                if !model.closeWeapon.isEmpty {
                    return setupWeaponCell(tableView: tableView, indexPath: indexPath, wargear: model.closeWeapon)
                } else {
                    return setupEquipmentCell(tableView: tableView, indexPath: indexPath)
                }
            }
        case 2:
            return setupEquipmentCell(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let model = presenter?.model else { return nil }
        switch indexPath.section {
        case 0:
            if !model.rangeWeapon.isEmpty {
                return addWeaponAction(wargear: model.rangeWeapon, indexPtah: indexPath)
            } else {
                if !model.closeWeapon.isEmpty {
                    return addWeaponAction(wargear: model.closeWeapon, indexPtah: indexPath)
                } else {
                    return addEquipmentAction(indexPath: indexPath)
                }
            }
        case 1:
            if model.rangeWeapon.isEmpty {
                return addEquipmentAction(indexPath: indexPath)
            } else {
                if !model.closeWeapon.isEmpty {
                    return addWeaponAction(wargear: model.closeWeapon, indexPtah: indexPath)
                } else {
                    return addEquipmentAction(indexPath: indexPath)
                }
            }
        case 2:
            return addEquipmentAction(indexPath: indexPath)
        default:
            return nil
        }
    }
}

extension EditUnitViewController: WeaponRuleButtonProtocol {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}

extension UIViewController {
    
    func moreInfoWeaponRuleAlert(weaponRule: WeaponSpecialRule) {
        let screenSize: CGRect = UIScreen.main.bounds
        let alert = WeaponRuleAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.weaponRuleView.widthAnchor.constraint(equalToConstant: screenSize.width - 40).isActive = true
        alert.setupText(rule: weaponRule)
        alert.weaponRuleView.doneButton.addTarget(self, action: #selector(dismissMoreInfoWeaponRuleAlert), for: .touchUpInside)
        alert.addAction(UIAlertAction())
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func dismissMoreInfoWeaponRuleAlert() {
        dismiss(animated: true, completion: nil)
    }
    
}
