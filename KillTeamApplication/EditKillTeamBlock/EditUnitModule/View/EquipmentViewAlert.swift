//
//  EquipmentViewAlert.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

class EquipmentViewAlert: UIStackView {
    
    let header = HeaderView()
    private let descriptionView = UIView()
    let bodyView = UIView()
    let buttonView = UIView()

    let descriptionLabel = UILabel()
    let bodyLabel = UILabel()
    let backgroundUniqueActionView = UIView()
    let uniqueActionView = UnitUniqueAtionView()
    
    let backgroundWeaponView = UIView()
    let weaponView = WeaponViewAlert()
    
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingsView()
        setupHeader()
    }
    
    func settingsView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray2
        layer.masksToBounds = true
        layer.cornerRadius = 12
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     private func setupHeader() {
        addArrangedSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupDescription(text: String) {
        addArrangedSubview(descriptionView)
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = text
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 15).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -15).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -15).isActive = true
    }
    
    func setupBody() {
        addArrangedSubview(bodyView)
        bodyView.addSubview(bodyLabel)
        bodyLabel.numberOfLines = 0
        bodyLabel.font = UIFont.systemFont(ofSize: 18)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 15).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 15).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -15).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -15).isActive = true
    }
    
    func setupUniqueActionView() {
        addArrangedSubview(backgroundUniqueActionView)
        backgroundUniqueActionView.addSubview(uniqueActionView)
        backgroundUniqueActionView.translatesAutoresizingMaskIntoConstraints = false
        
        uniqueActionView.topAnchor.constraint(equalTo: backgroundUniqueActionView.topAnchor, constant: 10).isActive = true
        uniqueActionView.leadingAnchor.constraint(equalTo: backgroundUniqueActionView.leadingAnchor, constant: 10).isActive = true
        uniqueActionView.trailingAnchor.constraint(equalTo: backgroundUniqueActionView.trailingAnchor, constant: -10).isActive = true
        uniqueActionView.bottomAnchor.constraint(equalTo: backgroundUniqueActionView.bottomAnchor, constant: -10).isActive = true
        uniqueActionView.backgroundColor = .systemGray4
        uniqueActionView.layer.borderWidth = 2
        uniqueActionView.layer.borderColor = CGColor(red: 225, green: 165, blue: 0, alpha: 1)
    }
    
    func setupWeaponView() {
        addArrangedSubview(backgroundWeaponView)
        backgroundWeaponView.addSubview(weaponView)
        backgroundWeaponView.translatesAutoresizingMaskIntoConstraints = false
        
        weaponView.topAnchor.constraint(equalTo: backgroundWeaponView.topAnchor, constant: 10).isActive = true
        weaponView.leadingAnchor.constraint(equalTo: backgroundWeaponView.leadingAnchor, constant: 10).isActive = true
        weaponView.trailingAnchor.constraint(equalTo: backgroundWeaponView.trailingAnchor, constant: -10).isActive = true
        weaponView.bottomAnchor.constraint(equalTo: backgroundWeaponView.bottomAnchor, constant: -10).isActive = true
        weaponView.backgroundColor = .systemGray4
        weaponView.layer.borderWidth = 2
        weaponView.layer.borderColor = CGColor(red: 225, green: 165, blue: 0, alpha: 1)
    }
    
    func setupButton() {
        addArrangedSubview(buttonView)
        buttonView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .orange
        button.setTitle("Done", for: .normal)
        button.topAnchor.constraint(equalTo: buttonView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -20).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
