//
//  EditUnitViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Instructions
import UIKit

protocol EditUnitProtocol: AnyObject {
    func didComplete(_ EditUnitViewController: EditUnitViewController)
}

class EditUnitViewController: UIViewController, EditUnitViewControllerProtocol {
    
    let coachMarksController = CoachMarksController()
    
    weak var delegate: EditUnitProtocol?
    
    var presenter: EditUnitPresenterProtocol?
    
    var countOfEquipmentPointLabel = BoldLabel()
    var chaosBlessingButton: UIButton?
    var unitNameLabelView = ViewWithLabel(label: BoldLabel(), blureStyle: .dark)
    
    let customAlert = CustomScrollAlert()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        title = "Edit Unit"
        setupUnitNameLabelView()
        setupTableView()
        setupViewsOnNavigationBar()
        registerCell()
        
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.clearNavigationBar()
        presenter?.clearIndex()
        coachMarksController.stop(immediately: true)
    }
    
    private func setupViewsOnNavigationBar() {
        setupChaosBlesisnButton()
        setupRightNavigationView(view: countOfEquipmentPointLabel, toRight: chaosBlessingButton)
        countOfEquipmentPointLabel.textColor = .white
        countOfEquipmentPointLabel.text = "EP = \(presenter?.model.killTeam?.countEquipmentPoint ?? 0)"
    }

    
    func showAlert(alertView: UIView) {
        tableView.isScrollEnabled = false
        customAlert.showAlert(alertView: alertView, targetViewController: self)
        delegate = customAlert
    }
    
    private func dismissAlert() {
        delegate?.didComplete(self)
        tableView.isScrollEnabled = true
    }

}

extension EditUnitViewController: WeaponRuleButtonDelegate {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}

extension EditUnitViewController: WeaponViewDelegate {
    func didComplete(_ weaponView: WeaponView) {
        dismissAlert()
    }
}

extension EditUnitViewController: EquipmentViewDelegate {
    func didComplete(_ equipmentView: EquipmentView) {
        dismissAlert()
    }
}
