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

class EditUnitWargearCell: UITableViewCell {
    
    static let identifier = "EditUnitWargearCell"
    
    var wargear: Weapon?
    
    var indexUnit: IndexPath?
    
    var unit: Unit? {
        didSet{
            if unit?.selectedRangeWeapon == wargear || unit?.selectedCloseWeapon == wargear {
                contentView.backgroundColor = .orange
            } else {
                contentView.backgroundColor = .gray
            }
        }
    }
    
    weak var delegate: EditUnitCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        if unit?.selectedRangeWeapon == wargear || unit?.selectedCloseWeapon == wargear {
            contentView.backgroundColor = .orange
        } else {
            contentView.backgroundColor = .gray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        delegate?.selectedWargear(wargear: wargear!, selected: selected)
    }
    
}

extension EditUnitWargearCell: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        indexUnit = killTeam?.indexOfChoosenUnit
        
        guard let indexPath = indexUnit else { return }
            unit = killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
    }
}
