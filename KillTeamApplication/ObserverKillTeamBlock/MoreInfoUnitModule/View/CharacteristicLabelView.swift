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
        nameCharacteristicLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.045)
        equatableLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.045)
        valueLabel.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenWidth * 0.045) //0.053
        addSubview(nameCharacteristicLabel)
        addSubview(equatableLabel)
        addSubview(valueLabel)
        nameCharacteristicLabel.numberOfLines = 1
        nameCharacteristicLabel.textAlignment = .center
        nameCharacteristicLabel.adjustsFontSizeToFitWidth = true
        equatableLabel.numberOfLines = 1
        equatableLabel.textAlignment = .center
        equatableLabel.adjustsFontSizeToFitWidth = true
        valueLabel.numberOfLines = 1
        valueLabel.textAlignment = .center
        valueLabel.adjustsFontSizeToFitWidth = true
        equatableLabel.text = "="
        NSLayoutConstraint.activate([
            nameCharacteristicLabel.topAnchor.constraint(equalTo: topAnchor),
            nameCharacteristicLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameCharacteristicLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameCharacteristicLabel.trailingAnchor.constraint(equalTo: equatableLabel.leadingAnchor),
            nameCharacteristicLabel.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.085)
        ])
        
        NSLayoutConstraint.activate([
            equatableLabel.topAnchor.constraint(equalTo: topAnchor),
            equatableLabel.leadingAnchor.constraint(equalTo: nameCharacteristicLabel.trailingAnchor),
            equatableLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            equatableLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: equatableLabel.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.073)
        ])

    }
    
}
/*
 NSLayoutConstraint.activate([
     nameCharacteristicLabel.topAnchor.constraint(equalTo: topAnchor),
     nameCharacteristicLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
     nameCharacteristicLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
     nameCharacteristicLabel.trailingAnchor.constraint(lessThanOrEqualTo: equatableLabel.leadingAnchor, constant: -5)
 ])
 
 NSLayoutConstraint.activate([
     equatableLabel.topAnchor.constraint(equalTo: topAnchor),
     equatableLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameCharacteristicLabel.trailingAnchor, constant: 5),
     equatableLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -5),
     equatableLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
 ])
 
 NSLayoutConstraint.activate([
     valueLabel.topAnchor.constraint(equalTo: topAnchor),
     valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: equatableLabel.trailingAnchor, constant: 5),
     valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
     valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
 ])
 */

/*
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
 
 */
