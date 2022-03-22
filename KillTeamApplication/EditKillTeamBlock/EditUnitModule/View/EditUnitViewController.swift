//
//  EditUnitViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

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
        equipmentView.button.addTarget(self, action: #selector(dismissEquipmentInfoAlert), for: .touchUpInside)
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
        weaponView.button.addTarget(self, action: #selector(dismissWeponInfoAlert), for: .touchUpInside)
    }
    
    func createBarlabel() {
        countOfEquipmentPointLabel.text = "Count of Equipment Point = \(presenter?.model.killTeam?.countEquipmentPoint ?? 0)"
        countOfEquipmentPointLabel.frame = CGRect(x: 160, y: 10, width: 0, height: 20)
        countOfEquipmentPointLabel.sizeToFit()
        navigationController?.navigationBar.addSubview(countOfEquipmentPointLabel)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter?.model.currentUnit?.availableWeapon?.count ?? 0
        default:
            return presenter?.model.killTeam?.equipment.count ?? 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Wargear"
        default:
            return "Equipment"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditUnitWargearCell.identifier, for: indexPath) as! EditUnitWargearCell
            presenter?.store.multicastDelegate.addDelegate(cell)
            let wargear = presenter?.model.currentUnit?.availableWeapon![indexPath.row]
            cell.textLabel?.text = wargear?.name
            cell.wargear = wargear
            cell.unit = presenter?.model.currentUnit
            cell.delegate = presenter as? EditUnitCellDelegate
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditUnitEquipmentCell.identifier, for: indexPath) as! EditUnitEquipmentCell
            let equipment = presenter?.model.killTeam?.equipment[indexPath.row]
            presenter?.store.multicastDelegate.addDelegate(cell)
            cell.equipment = equipment
            cell.unit = presenter?.model.currentUnit
            cell.delegate = presenter as? EditUnitEquipmentCellDelegate
            if let equip = equipment {
                cell.textLabel?.text = "\(equip.name)      [\(equip.cost)EP]"
            }
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 0:
            let action = UIContextualAction(style: .normal, title: "More info") { [self] _, _, complition in
                self.showWeponInfoAlert()
                if let wargear = self.presenter?.model.currentUnit?.availableWeapon![indexPath.row] {
                    self.weaponView.addText(weapon: wargear)
                    if let subWeapon = wargear.secondProfile {
                        for weapon in subWeapon {
                            self.weaponView.addText(weapon: weapon)
                        }
                    }
                    self.weaponView.setupButton()
                    self.weaponView.button.addTarget(self, action: #selector(self.dismissWeponInfoAlert), for: .touchUpInside)
                    self.weaponView.layer.masksToBounds = true
                    self.weaponView.layer.cornerRadius = 12
                }
            complition(true)
                
            }
            action.backgroundColor = .blue
            action.title = "Info"
            action.image = UIImage(systemName: "info.circle.fill")
            return UISwipeActionsConfiguration(actions: [action])
        case 1:
            let action = UIContextualAction(style: .normal, title: "More info") { _, _, complition in
                self.showWeponInfoEquipment()
                if let equipment = self.presenter?.model.killTeam?.equipment[indexPath.row] {
                    self.equipmentView.setupText(equipment: equipment)
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
        default:
            return UISwipeActionsConfiguration()
        }
    }
}
