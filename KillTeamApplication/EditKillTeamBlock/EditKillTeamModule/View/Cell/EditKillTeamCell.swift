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
        view.setupText(name: unit.name)
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
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.Otstup.small),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.Otstup.small),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.Otstup.small),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.Otstup.small)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class EditKillTeamCell2: UITableViewCell {

    static let identifire = "EditKillTeamCell"
    
    var header = HeaderView()
    let weaponMeleeLabel = BoldTextLabel()
    let weaponRangeLabel = BoldTextLabel()
    let equipmentLabel = BoldTextLabel()
    
    func setupText(unit: Unit) {
        setupTextHeader(unit: unit)
        if let rangeWeapon = unit.selectedRangeWeapon {
            weaponRangeLabel.addText(bold: "Ranged weapon", normal: rangeWeapon.name)
        } else {
            weaponRangeLabel.text = ""
        }
        if let meleeWeapon = unit.selectedCloseWeapon {
            weaponMeleeLabel.addText(bold: "Melee weapon", normal: meleeWeapon.name)
        } else {
            weaponMeleeLabel.text = ""
        }
        if !unit.equipment.isEmpty {
            var text = [String]()
            unit.equipment.forEach { equipment in
                text.append(equipment.name)
            }
            let finalText = equipmentLabel.mergedString(array: text)
            equipmentLabel.addText(bold: "Equipment", normal: finalText)
        } else {
            equipmentLabel.text = ""
        }
    }
    
    func setupTextHeader(unit: Unit) {
        header.setupText(name: unit.customName ?? unit.name)
    }
    
    func setupHeader() {
        contentView.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: contentView.topAnchor),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            header.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
        ])
    }
    
    private func setupAllLabels() {
        
        contentView.addSubview(weaponRangeLabel)
        contentView.addSubview(weaponMeleeLabel)
        contentView.addSubview(equipmentLabel)
        
        
        NSLayoutConstraint.activate([
            weaponRangeLabel.topAnchor.constraint(greaterThanOrEqualTo: header.bottomAnchor,constant: Constant.Size.Otstup.small),
            weaponRangeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Constant.Size.Otstup.normal),
            weaponRangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -Constant.Size.Otstup.normal),
         
        ])
        
        NSLayoutConstraint.activate([
            weaponMeleeLabel.topAnchor.constraint(greaterThanOrEqualTo: weaponRangeLabel.bottomAnchor,constant: Constant.Size.Otstup.small),
            weaponMeleeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Constant.Size.Otstup.normal),
            weaponMeleeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -Constant.Size.Otstup.normal),
        
        ])
        
        NSLayoutConstraint.activate([
            equipmentLabel.topAnchor.constraint(equalTo: weaponMeleeLabel.bottomAnchor,constant: Constant.Size.Otstup.small),
            equipmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Constant.Size.Otstup.normal),
            equipmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -Constant.Size.Otstup.normal),
            equipmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -Constant.Size.Otstup.small),
        ])
    }
    
    func configure() {
        contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        layer.applyCornerRadius()
        layer.masksToBounds = true
        setupHeader()
        setupAllLabels()

    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

