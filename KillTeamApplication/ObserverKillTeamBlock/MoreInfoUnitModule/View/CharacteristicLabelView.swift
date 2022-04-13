//
//  CharacteristicLabelView.swift
//  KillTeamApplication
//
//  Created by Apple on 13.04.2022.
//

import Foundation
import UIKit

class CharacteristicLabelView: UIView {
    
    private let nameCharacteristicLabel = HeaderLabel()
    private let equatableLabel = HeaderLabel()
    private let valueLabel = HeaderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(nameCharacteristic: String, value: String) {
        nameCharacteristicLabel.text = nameCharacteristic
        valueLabel.text = value
    }
    
    private func setupLabels() {
        nameCharacteristicLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.053)
        equatableLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.053)
        valueLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.053)
        addSubview(nameCharacteristicLabel)
        addSubview(equatableLabel)
        addSubview(valueLabel)
        equatableLabel.text = "="
        NSLayoutConstraint.activate([
            nameCharacteristicLabel.topAnchor.constraint(equalTo: topAnchor),
            nameCharacteristicLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameCharacteristicLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            equatableLabel.topAnchor.constraint(equalTo: topAnchor),
            equatableLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.screenWidth * 0.1),
            equatableLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: equatableLabel.trailingAnchor, constant: Constant.Size.screenWidth * 0.006),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

    }
    
}
