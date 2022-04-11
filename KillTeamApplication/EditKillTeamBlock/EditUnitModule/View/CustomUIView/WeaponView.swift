//
//  WeaponView.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol WeaponViewProtocol: AnyObject {
    func didComplete(_ weaponView: WeaponView)
}

class WeaponView: UIStackView, WargearView {
    
    typealias Delegate = WeaponViewProtocol
    
    func setDelegate(delegate: Delegate) {
        self.delegate = delegate
    }
    
    weak var delegate: WeaponViewProtocol?
    
    private let button = DoneButton()
    
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
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 15),
            button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -15),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 180),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    
     func setupText(wargear: WeaponProtocol, delegate: WeaponRuleButtonProtocol?) {
        if wargear.profileName != nil {
            setupHeader(name: "\(wargear.name) (\(wargear.profileName!))")
        } else {
            setupHeader(name: wargear.name)
        }
        switch wargear.type {
        case "range":
            setupCharacteristicView(attack: "A = \(wargear.attacks)",
                                    ballisticSkills: "BS = +\(wargear.ballisticWeaponSkill)",
                                    damage: "D = \(wargear.damage)/\(wargear.critDamage)")
        case "close":
            setupCharacteristicView(attack: "A = \(wargear.attacks)",
                                    ballisticSkills: "WS = +\(wargear.ballisticWeaponSkill)",
                                    damage: "D = \(wargear.damage)/\(wargear.critDamage)")
        default:
            return
        }
        if let specialRule = wargear.specialRule {
            setupSpecialRule(rules: specialRule, text: "Special rule:", delegate: delegate)
        }
        
        if let critSpecialRule = wargear.criticalHitspecialRule {
            setupSpecialRule(rules: critSpecialRule, text: "!:", delegate: delegate)
        }
        if let weapon = wargear as? Weapon, let subWeapon = weapon.secondProfile   {
            for weapon in subWeapon {
                setupText(wargear: weapon, delegate: delegate)
            }
        }
    }
    
    @objc private func buttonAction() {
        delegate?.didComplete(self)
    }
    
    private func settingsView() {
        backgroundColor = ColorScheme.shared.theme.viewBackground
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 10
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
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        let attackLabel = BoldLabel()
        let ballisticSkillsLabel = BoldLabel()
        let damageLabel = BoldLabel()
        view.addSubview(attackLabel)
        view.addSubview(ballisticSkillsLabel)
        view.addSubview(damageLabel)
        NSLayoutConstraint.activate([
            attackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            attackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            ballisticSkillsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ballisticSkillsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            damageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            damageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        attackLabel.text = attack
        ballisticSkillsLabel.text = ballisticSkills
        damageLabel.text = damage
    }
    
    private func setupSpecialRule(rules: [WeaponSpecialRule], text: String, delegate: WeaponRuleButtonProtocol?) {
        let view = UIView()
        let label = BoldLabel()
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        addArrangedSubview(view)
        view.addSubview(label)
        label.text = text
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
