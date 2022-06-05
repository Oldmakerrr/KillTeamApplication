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
    var chaosBlessingButton: UIBarButtonItem?
    var unitNameLabelView = ViewWithLabel(label: BoldLabel(), blureStyle: .dark)
    
    let customAlert = CustomScrollAlert()
    
    let tableView = UITableView()
    
    
    func setupUnitNameLabrlView() {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        setupUnitNameLabrlView()
        setupTableView()
        setupRightNavigationLabel(label: countOfEquipmentPointLabel)
        countOfEquipmentPointLabel.text = "EP = \(presenter?.model.killTeam?.countEquipmentPoint ?? 0)"
        title = "Edit Unit"
        registerCell()
        setupChaosBlesisnButton()
        
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        countOfEquipmentPointLabel.removeFromSuperview()
        presenter?.clearIndex()
        coachMarksController.stop(immediately: true)
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
// MARK: - TableView DataSource
    
extension EditUnitViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.wargear.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.wargear[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        view.label.text = presenter?.model.headerForRow[section]
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constant.Size.headerHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Size.cellHeight
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return addSwipeAction(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
