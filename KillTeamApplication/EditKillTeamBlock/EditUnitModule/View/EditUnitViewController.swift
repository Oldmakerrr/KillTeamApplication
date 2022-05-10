//
//  EditUnitViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol EditUnitProtocol: AnyObject {
    func didComplete(_ EditUnitViewController: EditUnitViewController)
}

class EditUnitViewController: UITableViewController, EditUnitViewControllerProtocol {
    
    weak var delegate: EditUnitProtocol?
    
    var presenter: EditUnitPresenterProtocol?
    
    var countOfEquipmentPointLabel = BoldLabel()
    var chaosBlessingButton: UIBarButtonItem?
    
    let customAlert = CustomScrollAlert()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        registerCell()
        setupChaosBlesisnButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationTitlelabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        countOfEquipmentPointLabel.removeFromSuperview()
    }
    
    func showAlert(alertView: UIView) {
        tableView.isScrollEnabled = false
        customAlert.showAlert(alertView: alertView, targetViewController: self)
        delegate = customAlert
    }
    
    func dismissAlert() {
        delegate?.didComplete(self)
        tableView.isScrollEnabled = true
    }

// MARK: - TableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.wargear.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.wargear[section].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        view.label.text = presenter?.model.headerForRow[section]
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constant.Size.headerHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weaponCell = tableView.dequeueReusableCell(withIdentifier: EditUnitWargearCell.identifier) as! EditUnitWargearCell
        let equipmentCell = tableView.dequeueReusableCell(withIdentifier: EditUnitEquipmentCell.identifier) as! EditUnitEquipmentCell
        let wargear = presenter?.model.wargear[indexPath.section]
            if let weapon = wargear as? [Weapon] {
                weaponCell.wargear = weapon[indexPath.row]
                weaponCell.unit = presenter?.model.currentUnit
                weaponCell.setupText(weapon: weapon[indexPath.row])
                return weaponCell
            }
            if let equipment = wargear as? [Equipment] {
                equipmentCell.setupText(equipment: equipment[indexPath.row])
                equipmentCell.equipment = equipment[indexPath.row]
                equipmentCell.unit = presenter?.model.currentUnit
                return equipmentCell
            }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Size.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return addSwipeAction(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let wargear = presenter?.model.wargear[indexPath.section][indexPath.row] else { return }
        presenter?.selectCell(wargear: wargear)
        tableView.reloadData()
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

extension EditUnitViewController: EquipmentViewProtocol {
    func didComplete(_ EquipmentView: EquipmentView) {
        dismissAlert()
    }
}

//MARK: - extension UIViewController

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

enum IdentifierTableHeaderView: String {
    case editKillTeamTableView
}

class TableHeaderView: UIView {
    
    static let identifier: IdentifierTableHeaderView = .editKillTeamTableView
    
    let label = HeaderLabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorScheme.shared.theme.viewHeader
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() {
        addSubview(label)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.large),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Constant.Size.Otstup.large)
        ])
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: Constant.Size.Otstup.large),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Constant.Size.Otstup.large),
            imageView.topAnchor.constraint(equalTo: label.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}
