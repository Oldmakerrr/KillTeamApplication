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
    
    var countOfEquipmentPointLabel = NormalLabel()
    
    let customAlert = CustomScrollAlert()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        countOfEquipmentPointLabel.removeFromSuperview()
        presenter?.cleareIndex()
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        switch section {
        case 0:
            view.label.text = presenter?.model.headerForRow[0]
        case 1:
            view.label.text = presenter?.model.headerForRow[1]
        case 2:
            view.label.text = presenter?.model.headerForRow[2]
        default:
            view.label.text = ""
        }
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constant.Size.headerHeight
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Size.cellHeight
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

extension EditUnitViewController: WeaponRuleButtonDelegate {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}

extension EditUnitViewController: WeaponViewProtocol {
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
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
           // imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}
