//
//  EditKillTeamCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class EditKillTeamCell: UITableViewCell, ReusableView {
    
    static var identifier: String {
        String(describing: self)
    }

    var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell() {
        stackView.removeFromSuperview()
        stackView = UIStackView()
        setupStackView()
    }
    
    func setupText(unit: Unit) {
        self.stackView.addArrangedSubview(addNameLabel(unit: unit))
        
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
    
    func changeBackgroundAlpha() {
        stackView.alpha = Constant.Size.notEnaibleAlpha
    }
    
    func addNameLabel(unit: Unit) -> UIView {
        let view = HeaderView()
        view.setupText(name: unit.customName ?? unit.name)
        return view
    }
    
    private func addWeaponLabel(weaponName: String, text: String) {
        let view = UIView()
        view.backgroundColor = ColorScheme.shared.theme.cellBackground
        let label = BoldTextLabel()
        label.addText(bold: text, normal: weaponName)
        view.addView(view: view, subView: label)
        self.stackView.addArrangedSubview(view)
    }
    
    private func addEquipmentLabel(array: [String]) {
        let view = UIView()
        let label = BoldTextLabel()
        view.backgroundColor = ColorScheme.shared.theme.cellBackground
        let text = label.mergedString(array: array)
        label.addText(bold: "Equipment", normal: text)
        view.addView(view: view, subView: label)
        self.stackView.addArrangedSubview(view)
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        stackView.layer.cornerRadius = Constant.Size.cornerRadius
        stackView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.EdgeInsets.small),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.EdgeInsets.small),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.EdgeInsets.small),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.EdgeInsets.small)
        ])
    }
    
}

