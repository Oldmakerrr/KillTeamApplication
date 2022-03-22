//
//  WeaponViewAlert.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

class WeaponView: UIStackView{
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingsView() 
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        let buttonView = UIView()
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
    
    func addText(weapon: WeaponProtocol) {
        if weapon.profileName != nil {
            setupHeader(name: "\(weapon.name) (\(weapon.profileName!))")
        } else {
            setupHeader(name: weapon.name)
        }
        switch weapon.type {
        case "range":
            setupCharacteristicView(attack: "A = \(weapon.attacks)",
                                    ballisticSkills: "BS = +\(weapon.ballisticWeaponSkill)",
                                    damage: "D = \(weapon.damage)/\(weapon.critDamage)")
        case "close":
            setupCharacteristicView(attack: "A = \(weapon.attacks)",
                                    ballisticSkills: "WS = +\(weapon.ballisticWeaponSkill)",
                                    damage: "D = \(weapon.damage)/\(weapon.critDamage)")
        default:
            return
        }
        if let specialRule = weapon.specialRule {
            var finalText = ""
            for (index, text) in specialRule.enumerated() {
                let specialRuleName = text.name
                switch index+1 == specialRule.count {
                case false:
                    finalText += " \(specialRuleName),"
                case true:
                    finalText += " \(specialRuleName)."
                }
                
            }
            setupSpecialRule(rules: "Special Rule: \(finalText)")
        }
        
        if let critSpecialRule = weapon.criticalHitspecialRule {
            var finalText = ""
            for (index, text) in critSpecialRule.enumerated() {
                let specialRuleName = text.name
                switch index+1 == critSpecialRule.count {
                case false:
                    finalText += " \(specialRuleName),"
                case true:
                    finalText += " \(specialRuleName)."
                }
                
            }
            setupSpecialRule(rules: "!: \(finalText)")
        }
    }
    
    private func settingsView() {
        backgroundColor = .systemGray2
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 10
    }
    
    private func setupLabel(label: UILabel, view: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(label)
    }
    
    private func addAnchorToLabel(label: UILabel, view: UIView) {
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setupHeader(name: String) {
        let header = HeaderView()
        header.setupText(name: name, cost: nil)
        addArrangedSubview(header)
    }
    
    private func setupCharacteristicView(attack: String, ballisticSkills: String, damage: String){
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(view)
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .systemGray4
        let attackLabel = UILabel()
        let ballisticSkillsLabel = UILabel()
        let damageLabel = UILabel()
        setupLabel(label: attackLabel, view: view)
        setupLabel(label: ballisticSkillsLabel, view: view)
        setupLabel(label: damageLabel, view: view)
        attackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        attackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        ballisticSkillsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ballisticSkillsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        damageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        damageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        attackLabel.text = attack
        ballisticSkillsLabel.text = ballisticSkills
        damageLabel.text = damage
    }
    
    private func setupSpecialRule(rules: String) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        addArrangedSubview(view)
        let label = UILabel()
        label.numberOfLines = 0
        setupLabel(label: label, view: view)
        addAnchorToLabel(label: label, view: view)
        label.text = rules
    }
}

class HeaderView: UIView {
    
    lazy var nameLabel = UILabel()
    var costLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(name: String, cost: String?) {
        addSubview(nameLabel)
        addSubview(costLabel)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.text = name
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: costLabel.leadingAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        costLabel.font = UIFont.boldSystemFont(ofSize: 22)
        costLabel.text = cost ?? ""
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
}
 
