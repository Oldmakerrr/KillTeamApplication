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
            button.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: Constant.Size.Otstup.normal),
            button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -Constant.Size.Otstup.normal),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: Constant.Size.NormalButton.width),
            button.heightAnchor.constraint(equalToConstant: Constant.Size.NormalButton.height)
        ])
        
    }
    
    
     func setupText(wargear: WeaponProtocol, delegate: WeaponRuleButtonDelegate?) {
        if wargear.profileName != nil {
            setupHeader(name: "\(wargear.name) (\(wargear.profileName!))")
        } else {
            setupHeader(name: wargear.name)
        }
        switch wargear.type {
        case .range:
            setupCharacteristicView(attack: "A = \(wargear.attacks)",
                                    ballisticSkills: "BS = +\(wargear.ballisticWeaponSkill)",
                                    damage: "D = \(wargear.damage)/\(wargear.critDamage)")
        case .close:
            setupCharacteristicView(attack: "A = \(wargear.attacks)",
                                    ballisticSkills: "WS = +\(wargear.ballisticWeaponSkill)",
                                    damage: "D = \(wargear.damage)/\(wargear.critDamage)")
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
        spacing = 2
    }
  
    private func setupHeader(name: String) {
        let view = HeaderView()
        view.setupText(name: name)
        addArrangedSubview(view)
    }
    
    private func setupCharacteristicView(attack: String, ballisticSkills: String, damage: String){
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(view)
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        let attackLabel = BigLabel()
        let ballisticSkillsLabel = BigLabel()
        let damageLabel = BigLabel()
        view.addSubview(attackLabel)
        view.addSubview(ballisticSkillsLabel)
        view.addSubview(damageLabel)
        NSLayoutConstraint.activate([
            attackLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 3),
            attackLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3),
            attackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            ballisticSkillsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ballisticSkillsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            damageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            damageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        attackLabel.text = attack
        ballisticSkillsLabel.text = ballisticSkills
        damageLabel.text = damage
    }
    
    private func setupSpecialRule(rules: [WeaponSpecialRule], text: String, delegate: WeaponRuleButtonDelegate?) {
        let view = UIView()
        let label = BigLabel()
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        addArrangedSubview(view)
        view.addSubview(label)
        label.text = text
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.Otstup.small),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.Otstup.large),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.Otstup.small)
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
                button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: Constant.Size.Otstup.small).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: arrayOfButton[index-1].trailingAnchor, constant: Constant.Size.Otstup.small).isActive = true
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
