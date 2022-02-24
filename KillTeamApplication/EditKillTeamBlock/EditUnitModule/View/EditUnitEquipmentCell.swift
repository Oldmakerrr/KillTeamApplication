//
//  EditUnitEquipmentCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Foundation

protocol EditUnitEquipmentCellDelegate: AnyObject {
    func selectEquipment(equipment: Equipment, selected: Bool)
}

class EditUnitEquipmentCell: UITableViewCell {

    static let identifier = "EditUnitEquipmentCell"

    var equipment: Equipment?
    
    var indexUnit: IndexPath?
    
    var unit: Unit? {
        didSet{
            if unit!.equipment.contains(where: { equip in
                equip == equipment
            }) {
                contentView.backgroundColor = .orange
            } else {
                contentView.backgroundColor = .gray
            }
        }
    }
    
    weak var delegate: EditUnitEquipmentCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        if ((unit?.equipment.contains(where: { equip in
            equip == equipment
        })) != nil) {
            contentView.backgroundColor = .orange
        } else {
            contentView.backgroundColor = .gray
        }

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        delegate?.selectEquipment(equipment: equipment!, selected: selected)
    }
    
}

extension EditUnitEquipmentCell: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        indexUnit = killTeam?.indexOfChoosenUnit
        guard let indexPath = indexUnit else { return }
            unit = killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
    }
}
