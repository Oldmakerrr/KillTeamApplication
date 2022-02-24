//
//  WeaponViewAlert.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

class WeaponViewAlert: UIStackView {
    
    let header = HeaderView()
    let characteristicView = UIView()
    
    let attackLabel = UILabel()
    let ballisticSkillsLabel = UILabel()
    let damageLabel = UILabel()
    
    let specialRuleView = UIView()
    let specialRuleLabel = UILabel()
    
    let critSpecialRuleView = UIView()
    let critSpecialRuleLabel = UILabel()
    
    let buttonView = UIButton()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingsView()
        setupHeader()
        setupCharacteristicView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeader() {
        addArrangedSubview(header)
        header.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupCharacteristicView() {
        addArrangedSubview(characteristicView)
        characteristicView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        attackLabel.translatesAutoresizingMaskIntoConstraints = false
        attackLabel.font = UIFont.systemFont(ofSize: 18)
        characteristicView.addSubview(attackLabel)
        
        ballisticSkillsLabel.translatesAutoresizingMaskIntoConstraints = false
        ballisticSkillsLabel.font = UIFont.systemFont(ofSize: 18)
        characteristicView.addSubview(ballisticSkillsLabel)

        
        damageLabel.translatesAutoresizingMaskIntoConstraints = false
        damageLabel.font = UIFont.systemFont(ofSize: 18)
        characteristicView.addSubview(damageLabel)

        attackLabel.centerYAnchor.constraint(equalTo: characteristicView.centerYAnchor).isActive = true
        attackLabel.leadingAnchor.constraint(equalTo: characteristicView.leadingAnchor, constant: 20).isActive = true
        
        ballisticSkillsLabel.topAnchor.constraint(equalTo: attackLabel.topAnchor).isActive = true
        ballisticSkillsLabel.centerXAnchor.constraint(equalTo: characteristicView.centerXAnchor).isActive = true
        
        damageLabel.topAnchor.constraint(equalTo: attackLabel.topAnchor).isActive = true
        damageLabel.trailingAnchor.constraint(equalTo: characteristicView.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupSpecialRuleView() {
        addArrangedSubview(specialRuleView)
        specialRuleView.addSubview(specialRuleLabel)
        specialRuleLabel.translatesAutoresizingMaskIntoConstraints = false
        specialRuleLabel.font = UIFont.systemFont(ofSize: 18)
        specialRuleLabel.numberOfLines = 0
        
        specialRuleLabel.topAnchor.constraint(equalTo: specialRuleView.topAnchor, constant: 15).isActive = true
        specialRuleLabel.leadingAnchor.constraint(equalTo: specialRuleView.leadingAnchor, constant: 15).isActive = true
        specialRuleLabel.trailingAnchor.constraint(equalTo: specialRuleView.trailingAnchor, constant: -15).isActive = true
        specialRuleLabel.bottomAnchor.constraint(equalTo: specialRuleView.bottomAnchor, constant: -15).isActive = true
    }
    
    func setupCritSpecialRuleView() {
        addArrangedSubview(critSpecialRuleView)
        critSpecialRuleView.addSubview(critSpecialRuleLabel)
        critSpecialRuleLabel.translatesAutoresizingMaskIntoConstraints = false
        critSpecialRuleLabel.font = UIFont.systemFont(ofSize: 18)
        critSpecialRuleLabel.numberOfLines = 0
        
        critSpecialRuleLabel.topAnchor.constraint(equalTo: critSpecialRuleView.topAnchor, constant: 15).isActive = true
        critSpecialRuleLabel.leadingAnchor.constraint(equalTo: critSpecialRuleView.leadingAnchor, constant: 15).isActive = true
        critSpecialRuleLabel.trailingAnchor.constraint(equalTo: critSpecialRuleView.trailingAnchor, constant: -15).isActive = true
        critSpecialRuleLabel.bottomAnchor.constraint(equalTo: critSpecialRuleView.bottomAnchor, constant: -15).isActive = true
    }
    
    func setupButton() {
        addArrangedSubview(buttonView)
        buttonView.addSubview(button)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .orange
        button.setTitle("Done", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 15).isActive = true
        button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -15).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    
    func settingsView() {
        backgroundColor = .systemGray2
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
    }
}
    
class HeaderView: UIView {
    
    lazy var nameLabel = UILabel()
    var coastLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAnchor()
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAnchor() {
        addSubview(nameLabel)
        addSubview(coastLabel)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        coastLabel.font = UIFont.boldSystemFont(ofSize: 22)
        coastLabel.translatesAutoresizingMaskIntoConstraints = false
        coastLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        coastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
}
 
