//
//  WeaponView.swift
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
    
    func addText(weapon: WeaponProtocol, delegate: WeaponRuleButtonProtocol?) {
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
            setupSpecialRule(rules: specialRule, text: "Special rule:", delegate: delegate)
        }
        
        if let critSpecialRule = weapon.criticalHitspecialRule {
            setupSpecialRule(rules: critSpecialRule, text: "!:", delegate: delegate)
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
    
    private func setupSpecialRule(rules: [WeaponSpecialRule], text: String, delegate: WeaponRuleButtonProtocol?) {
        let view = UIView()
        let label = UILabel()
        view.backgroundColor = .systemGray4
        addArrangedSubview(view)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 16)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        var arrayOfButton = [UIButton]()
        for (index, rule) in rules.enumerated() {
            let button = WeaponRuleButton()
            button.delegate = delegate
            button.setupText(weaponRule: rule)
            arrayOfButton.append(button)
            view.addSubview(button)
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
            if index == 0 {
                button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: arrayOfButton[index-1].trailingAnchor, constant: 5).isActive = true
            }
        }
    }

    
    private func dsetupSpecialRule(rules: [String], text: String) {
        let view = UIView()
        view.backgroundColor = .systemGray4
        addArrangedSubview(view)
        let label = UILabel()
        view.addSubview(label)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        let ruleText = label.mergedString(array: rules)
        label.text = "\(text) \(ruleText)"
    }
}

extension UILabel {
    func mergedString(array: [String]) -> String {
        var finalText = ""
        for (index, text) in array.enumerated() {
            switch index+1 == array.count {
            case false:
                finalText += " \(text),"
            case true:
                finalText += " \(text)."
            }
        }
        return finalText
    }
}
