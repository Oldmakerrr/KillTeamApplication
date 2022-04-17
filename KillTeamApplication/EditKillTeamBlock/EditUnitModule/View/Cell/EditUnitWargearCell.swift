//
//  EditUnitWargearCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol EditUnitCellDelegate: AnyObject {
    func selectedWargear(wargear: Weapon, selected: Bool)
}

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
    
    weak var delegate: EditUnitCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupNameWeaponLabel()
        checkSelectedState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        guard let wargear = wargear else { return }
        delegate?.selectedWargear(wargear: wargear, selected: selected)
    }
    
    func setupText(weapon: Weapon) {
        nameWeaponLabel.text = weapon.name
    }
    
    private func checkSelectedState() {
        if unit?.selectedRangeWeapon == wargear || unit?.selectedCloseWeapon == wargear || isAdditionalWeapon() {
            contentView.backgroundColor = ColorScheme.shared.theme.selectedCell
        } else {
            contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        }
    }
    
    private func isAdditionalWeapon () -> Bool {
        guard let additionalWeapon = unit?.additionalWeapon, let wargear = wargear else {
            return false
        }
        return additionalWeapon.contains(wargear) ? true : false
       
    }
    
    private func setupNameWeaponLabel() {
        contentView.addSubview(nameWeaponLabel)
        NSLayoutConstraint.activate([
            nameWeaponLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.Otstup.small),
            nameWeaponLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameWeaponLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.Otstup.large)
        ])
    }
    
}

extension EditUnitWargearCell: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let killTeam = killTeam, let indexPath = killTeam.indexOfChoosenUnit else { return }
        unit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
    }
}
