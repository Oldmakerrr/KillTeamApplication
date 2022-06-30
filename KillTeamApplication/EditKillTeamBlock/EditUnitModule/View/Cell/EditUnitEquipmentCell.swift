//
//  EditUnitEquipmentCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Foundation

class EditUnitEquipmentCell: UITableViewCell, ReusableView {

    static var identifier: String {
        String(describing: self)
    }

    let costEquipmentLabel = NormalLabel()
    let nameEquipmentLabel = NormalLabel()
    
    var equipment: Equipment?
    
    var unit: Unit? {
        didSet{
            checkSelectedState()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupNameEquipmentLabel()
        setupCostEquipmentLabel()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            nameEquipmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.EdgeInsets.small),
            nameEquipmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.EdgeInsets.small),
            nameEquipmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.EdgeInsets.large)
        ])
    }
    
    private func setupCostEquipmentLabel() {
        contentView.addSubview(costEquipmentLabel)
        NSLayoutConstraint.activate([
            costEquipmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.EdgeInsets.small),
            costEquipmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.EdgeInsets.small),
            costEquipmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.Size.EdgeInsets.large)
        ])
    }
    
}
