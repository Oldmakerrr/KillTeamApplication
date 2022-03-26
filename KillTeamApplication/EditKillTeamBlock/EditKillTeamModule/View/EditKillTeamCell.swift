//
//  EditKillTeamCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class EditKillTeamCell: UITableViewCell {

    static let identifire = "EditKillTeamCell"
    
    var view = UIStackView()
    
    func setupText(unit: Unit) {
        view = UIStackView()
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
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        contentView.addSubview(view)
        view.axis = .vertical
        view.spacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
    
    private func addNameLabel(text: String) {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7960784314, blue: 0.6549019608, alpha: 1)
        let label = UILabel()
        view.addView(top: 4, bottom: 4, leading: 10, trailing: 10, view: view, subView: label)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = text
        label.textAlignment = .center
        self.view.addArrangedSubview(view)
    }
    
    private func addWeaponLabel(weaponName: String, text: String) {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.906050384, green: 0.8984230161, blue: 0.8774103522, alpha: 1)
        let label = BoldTextLabel()
        label.boldSize = 16
        label.addText(bold: text, normal: weaponName)
        view.addView(top: 4, bottom: 4, leading: 10, trailing: 10, view: view, subView: label)
        self.view.addArrangedSubview(view)
    }
    
    private func addEquipmentLabel(array: [String]) {
        let view = UIView()
        let label = BoldTextLabel()
        view.backgroundColor = #colorLiteral(red: 0.906050384, green: 0.8984230161, blue: 0.8774103522, alpha: 1)
        let text = label.mergedString(array: array)
        label.boldSize = 16
        label.addText(bold: "Equipment", normal: text)
        view.addView(top: 4, bottom: 4, leading: 10, trailing: 10, view: view, subView: label)
        self.view.addArrangedSubview(view)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .none
        //contentView.backgroundColor = #colorLiteral(red: 0.6, green: 0.6392156863, blue: 0.6431372549, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
