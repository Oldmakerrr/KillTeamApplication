//
//  EditKillTeamCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class EditKillTeamCell: UITableViewCell {

    static let identifire = "EditKillTeamCell"
    
    let view = UIStackView()
    
    func setupText(unit: Unit) {
        addNameLabel(text: unit.customName ?? unit.name)
        if let rangeWeapon = unit.selectedRangeWeapon {
            addWeaponLabel(weaponName: rangeWeapon.name, text: "Ranged weapon")
        }
        if let closeWeapon = unit.selectedCloseWeapon {
            addWeaponLabel(weaponName: closeWeapon.name, text: "Melee weapon")
        }
        if !unit.equipment.isEmpty {
            var text = [String]()
            unit.equipment.forEach { equipment in
                text.append(equipment.name)
            }
            addEquipmentLabel(array: text)
        }
    }
    
    private func addNameLabel(text: String) {
        let view = UIView()
        view.backgroundColor = ColorScheme.shared.theme.cellHeader
        let label = BoldLabel()
        label.text = text
        view.addView(top: 4, bottom: 4, leading: 10, trailing: 10, view: view, subView: label)
        label.textAlignment = .center
        self.view.addArrangedSubview(view)
    }
    
    private func addWeaponLabel(weaponName: String, text: String) {
        let view = UIView()
        view.backgroundColor = ColorScheme.shared.theme.cellBackground
        let label = BoldTextLabel()
        label.addText(bold: text, normal: weaponName)
        view.addView(top: 4, bottom: 4, leading: 10, trailing: 10, view: view, subView: label)
        self.view.addArrangedSubview(view)
    }
    
    private func addEquipmentLabel(array: [String]) {
        let view = UIView()
        let label = BoldTextLabel()
        view.backgroundColor = ColorScheme.shared.theme.cellBackground
        let text = label.mergedString(array: array)
        label.addText(bold: "Equipment", normal: text)
        view.addView(top: 4, bottom: 4, leading: 10, trailing: 10, view: view, subView: label)
        self.view.addArrangedSubview(view)
    }
    
    private func configure() {
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        contentView.addSubview(view)
        view.axis = .vertical
        view.spacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constant.Size.cornerRadius
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
