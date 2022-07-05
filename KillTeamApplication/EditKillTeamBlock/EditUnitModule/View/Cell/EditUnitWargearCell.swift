//
//  EditUnitWargearCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class EditUnitWargearCell: UITableViewCell, ReusableView {
    
    static var identifier: String {
        String(describing: self)
    }
    
    let nameWeaponLabel = NormalLabel()
    
    var wargear: Weapon?
    
    var unit: Unit? {
        didSet{
            checkSelectedState()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupNameWeaponLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(weapon: Weapon) {
        nameWeaponLabel.text = weapon.name
    }
    
    private func checkSelectedState() {
        if unit?.selectedRangeWeapon == wargear || unit?.selectedMeleeWeapon == wargear || isAdditionalWeapon() {
            contentView.backgroundColor = ColorScheme.shared.theme.selectedCell
        } else {
            contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        }
    }
    
    private func isAdditionalWeapon () -> Bool {
        guard let additionalWeapon = unit?.additionalWeapons, let wargear = wargear else {
            return false
        }
        return additionalWeapon.contains(wargear) ? true : false
       
    }
    
    private func setupNameWeaponLabel() {
        contentView.addSubview(nameWeaponLabel)
        NSLayoutConstraint.activate([
            nameWeaponLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.EdgeInsets.small),
            nameWeaponLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.EdgeInsets.small),
            nameWeaponLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.EdgeInsets.large)
        ])
    }
    
}
