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
    var moreInfoWeapon = WeaponViewAlert()
    var moreInfoEquipment = EquipmentViewAlert()
    lazy var customAlertInfoWeapon = CustomAlert(alertView: moreInfoWeapon, targetView: view)
    lazy var customAlertInfoEquipment = CustomAlert(alertView: moreInfoEquipment, targetView: view)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        tableView.register(EditUnitWargearCell.self, forCellReuseIdentifier: EditUnitWargearCell.identifier)
        tableView.register(EditUnitEquipmentCell.self, forCellReuseIdentifier: EditUnitEquipmentCell.identifier)
            createBarlabel()
        moreInfoWeapon.button.addTarget(self, action: #selector(dismissWeponInfoAlert), for: .touchUpInside)
        moreInfoEquipment.button.addTarget(self, action: #selector(dismissEquipmentInfoAlert), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        countOfEquipmentPointLabel.removeFromSuperview()
       // presenter?.cleareIndex()
    }
    
    func showWeponInfoEquipment() {
        customAlertInfoEquipment.showAlert()
        tableView.isScrollEnabled = false
    
    }
    
    @objc func dismissEquipmentInfoAlert() {
        customAlertInfoEquipment.dismissAlert()
        tableView.isScrollEnabled = true
        moreInfoEquipment.backgroundWeaponView.removeFromSuperview()
        moreInfoEquipment.weaponView.specialRuleView.removeFromSuperview()
        moreInfoEquipment.weaponView.critSpecialRuleView.removeFromSuperview()
        moreInfoEquipment.backgroundUniqueActionView.removeFromSuperview()
        moreInfoEquipment.bodyView.removeFromSuperview()
    }
    
    func showWeponInfoAlert() {
        customAlertInfoWeapon.showAlert()
        tableView.isScrollEnabled = false
    
    }
    
    @objc func dismissWeponInfoAlert() {
        customAlertInfoWeapon.dismissAlert()
        tableView.isScrollEnabled = true
        moreInfoWeapon.specialRuleView.removeFromSuperview()
        moreInfoWeapon.critSpecialRuleView.removeFromSuperview()
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
            let action = UIContextualAction(style: .normal, title: "More info") { _, _, complition in
                self.showWeponInfoAlert()
                if let wargear = self.presenter?.model.currentUnit?.availableWeapon![indexPath.row] {
                    self.moreInfoWeapon.layer.cornerRadius = 12
                    self.moreInfoWeapon.attackLabel.text = "A = \(wargear.attacks)"
                    self.moreInfoWeapon.header.nameLabel.text = "\(wargear.name)"
                    switch wargear.type {
                    case "range":
                        self.moreInfoWeapon.ballisticSkillsLabel.text = "BS = +\(wargear.ballisticWeaponSkill)"
                    case "close":
                        self.moreInfoWeapon.ballisticSkillsLabel.text = "WS = +\(wargear.ballisticWeaponSkill)"
                    default:
                        break
                    }
                    self.moreInfoWeapon.damageLabel.text = "D = \(wargear.damage)/\(wargear.critDamage)"
                    
                    if let sp = wargear.specialRule {
                        var spe = ""
                        for (index, text) in sp.enumerated() {
                            let n = text.name
                            switch index+1 == sp.count {
                            case false:
                                spe += " \(n),"
                            case true:
                                spe += " \(n)."
                            }
                            
                        }
                        self.moreInfoWeapon.specialRuleLabel.text = "Special Rule: \(spe)"
                        self.moreInfoWeapon.setupSpecialRuleView()
                    }
                                    
                    if let sp = wargear.criticalHitspecialRule {
                        var cspe = ""
                        for (index, text) in sp.enumerated() {
                            let n = text.name
                            switch index+1 == sp.count {
                            case false:
                                cspe += " \(n),"
                            case true:
                                cspe += " \(n)."
                            }
                            
                        }
                        self.moreInfoWeapon.critSpecialRuleLabel.text = "!: \(cspe)"
                        self.moreInfoWeapon.setupCritSpecialRuleView()
                    }
                    self.moreInfoWeapon.setupButton()
                    complition(true)
                }
            }
            action.backgroundColor = .blue
            action.title = "Info"
            action.image = UIImage(systemName: "info.circle.fill")
            return UISwipeActionsConfiguration(actions: [action])
        case 1:
            let action = UIContextualAction(style: .normal, title: "More info") { _, _, complition in
                self.showWeponInfoEquipment()
                if let equipment = self.presenter?.model.killTeam?.equipment[indexPath.row] {
                    self.moreInfoEquipment.header.nameLabel.text = equipment.name
                    self.moreInfoEquipment.header.coastLabel.text = "[\(equipment.cost)EP]"
                    self.moreInfoEquipment.setupDescription(text: equipment.description)
                    if let body = equipment.body {
                        self.moreInfoEquipment.setupBody()
                        self.moreInfoEquipment.bodyLabel.text = body
                    }
                    if let uniqueAction = equipment.uniqueAction {
                        self.moreInfoEquipment.setupUniqueActionView()
                        self.moreInfoEquipment.uniqueActionView.nameLabel.text = uniqueAction.name
                        if let cost = uniqueAction.cost {
                            self.moreInfoEquipment.uniqueActionView.coastLabel.text = "\(cost) AP"
                        }
                        self.moreInfoEquipment.uniqueActionView.descriptionLabel.text = uniqueAction.description
                    }
                    if let wargear = equipment.wargear {
                        self.moreInfoEquipment.setupWeaponView()
                        self.moreInfoEquipment.weaponView.layer.cornerRadius = 0
                        self.moreInfoEquipment.weaponView.attackLabel.text = "A = \(wargear.attacks)"
                        self.moreInfoEquipment.weaponView.header.nameLabel.text = wargear.name
                        switch wargear.type {
                        case "range":
                            self.moreInfoEquipment.weaponView.ballisticSkillsLabel.text = "BS = +\(wargear.ballisticWeaponSkill)"
                        case "close":
                            self.moreInfoEquipment.weaponView.ballisticSkillsLabel.text = "WS = +\(wargear.ballisticWeaponSkill)"
                        default:
                            break
                        }
                        self.moreInfoEquipment.weaponView.damageLabel.text = "D = \(wargear.damage)/\(wargear.critDamage)"
                        
                        if let sp = wargear.specialRule {
                            self.moreInfoEquipment.weaponView.setupSpecialRuleView()
                            var spe = ""
                            for (index, text) in sp.enumerated() {
                                let n = text.name
                                switch index+1 == sp.count {
                                case false:
                                    spe += " \(n),"
                                case true:
                                    spe += " \(n)."
                                }
                                
                            }
                            self.moreInfoEquipment.weaponView.specialRuleLabel.text = "Special Rule: \(spe)"
                        }
                                        
                        if let sp = wargear.criticalHitspecialRule {
                            self.moreInfoEquipment.weaponView.setupCritSpecialRuleView()
                            var cspe = ""
                            for (index, text) in sp.enumerated() {
                                let n = text.name
                                switch index+1 == sp.count {
                                case false:
                                    cspe += " \(n),"
                                case true:
                                    cspe += " \(n)."
                                }
                            }
                            self.moreInfoWeapon.critSpecialRuleLabel.text = "!: \(cspe)"
                        }
                    }
                    self.moreInfoEquipment.setupButton()
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

/*
 if let body = equipment.body {
     self.moreInfoEquipment.addArrangedSubview(self.moreInfoEquipment.bodyView)
     self.moreInfoEquipment.bodyLabel.text = body
 }
 if let uniqueAction = equipment.uniqueAction {
     self.moreInfoEquipment.addArrangedSubview(self.moreInfoEquipment.uniqueActionView)
     self.moreInfoEquipment.uniqueActionView.nameLabel.text = uniqueAction.name
     self.moreInfoEquipment.uniqueActionView.coastLabel.text = "\(uniqueAction.coast) AP"
     self.moreInfoEquipment.uniqueActionView.descriptionLabel.text = uniqueAction.discription
 }
 if let wargear = equipment.wargear {
     self.moreInfoEquipment.addArrangedSubview(self.moreInfoEquipment.weaponView)
     self.moreInfoEquipment.weaponView.attackLabel.text = "A = \(wargear.attacks)"
     self.moreInfoEquipment.weaponView.header.nameLabel.text = wargear.name
     switch wargear.type {
     case "range":
         self.moreInfoWeapon.ballisticSkillsLabel.text = "BS = +\(wargear.ballisticWeaponSkill)"
     case "close":
         self.moreInfoWeapon.ballisticSkillsLabel.text = "WS = +\(wargear.ballisticWeaponSkill)"
     default:
         do {return}
     }
     self.moreInfoWeapon.damageLabel.text = "D = \(wargear.damage)/\(wargear.critDamage)"
     
     if let sp = wargear.specialRule {
         var spe = ""
         for (index, text) in sp.enumerated() {
             let n = text.name
             switch index+1 == sp.count {
             case false:
                 spe += " \(n),"
             case true:
                 spe += " \(n)."
             }
             
         }
         self.moreInfoWeapon.specialRuleLabel.text = "Special Rule: \(spe)"
     } else {
         self.moreInfoWeapon.specialRuleLabel.text = "Special Rule:"
     }
                     
     if let sp = wargear.criticalHitspecialRule {
         var cspe = ""
         for (index, text) in sp.enumerated() {
             let n = text.name
             switch index+1 == sp.count {
             case false:
                 cspe += " \(n),"
             case true:
                 cspe += " \(n)."
             }
             
         }
         self.moreInfoWeapon.critSpecialRuleLabel.text = "!: \(cspe)"
     } else {
         self.moreInfoWeapon.critSpecialRuleLabel.text = "!:"
     }
     self.moreInfoEquipment.addArrangedSubview(self.moreInfoEquipment.button)
     //self.moreInfoEquipment.wargear
     
 */
