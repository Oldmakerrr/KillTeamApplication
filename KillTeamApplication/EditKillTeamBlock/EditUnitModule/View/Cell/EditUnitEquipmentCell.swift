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

    let costEquipmentLabel = NormalLabel()
    let nameEquipmentLabel = NormalLabel()
    
    var equipment: Equipment?
    
    var unit: Unit? {
        didSet{
            checkSelectedState()
        }
    }
    
    weak var delegate: EditUnitEquipmentCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupNameEquipmentLabel()
        setupCostEquipmentLabel()
        checkSelectedState()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        guard let equipment = equipment  else { return }
        delegate?.selectEquipment(equipment: equipment, selected: selected)
    }
    
    func setupText(equipment: Equipment) {
        nameEquipmentLabel.text = equipment.name
        costEquipmentLabel.text = "[\(equipment.cost)EP]"
    }
    
    private func checkSelectedState() {
        guard let equipments = unit?.equipment, let equipment = equipment else { return }
        if equipments.contains(equipment) {
            contentView.backgroundColor = ColorScheme.shared.theme.selectedCell
        } else {
            contentView.backgroundColor = ColorScheme.shared.theme.cellBackground
        }
    }
    
    private func setupNameEquipmentLabel() {
        contentView.addSubview(nameEquipmentLabel)
        NSLayoutConstraint.activate([
            nameEquipmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.Otstup.small),
            nameEquipmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameEquipmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.Otstup.large)
        ])
    }
    
    private func setupCostEquipmentLabel() {
        contentView.addSubview(costEquipmentLabel)
        NSLayoutConstraint.activate([
            costEquipmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.Otstup.small),
            costEquipmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.Otstup.small),
            costEquipmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.Otstup.large)
        ])
    }
    
}

extension EditUnitEquipmentCell: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        guard let indexPath = killTeam.indexOfChoosenUnit else { return }
        unit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
    }
}
