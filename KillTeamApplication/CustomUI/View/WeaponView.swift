//
//  WeaponView.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol WeaponViewDelegate: AnyObject {
    func didComplete(_ weaponView: WeaponView)
}

class WeaponView: UIStackView, WargearView {
    
    typealias Delegate = WeaponViewDelegate
    
    weak var delegate: WeaponViewDelegate?
    
    private let button = DoneButton()
    let header = HeaderView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingsView() 
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(delegate: Delegate) {
        self.delegate = delegate
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
    
    
     func setupText(wargear: WeaponProtocol, delegate: WeaponRuleButtonDelegate?, viewWidth: CGFloat) {
        if let profileName = wargear.profileName {
            setupHeader(title: "\(wargear.name) (\(profileName))")
        } else {
            setupHeader(title: wargear.name)
        }
        switch wargear.type {
        case .range:
            setupCharacteristicView(attack: "A = \(wargear.attacks)",
                                    ballisticSkills: "BS = \(wargear.ballisticWeaponSkill)+",
                                    damage: "D = \(wargear.damage)/\(wargear.critDamage)")
        case .close:
            setupCharacteristicView(attack: "A = \(wargear.attacks)",
                                    ballisticSkills: "WS = \(wargear.ballisticWeaponSkill)+",
                                    damage: "D = \(wargear.damage)/\(wargear.critDamage)")
        }
        if let specialRule = wargear.specialRule {
            setupSpecialRule(rules: specialRule, text: "Special rule:", delegate: delegate, viewWidth: viewWidth)
        }
        
        if let critSpecialRule = wargear.criticalHitspecialRule {
            setupSpecialRule(rules: critSpecialRule, text: "!:", delegate: delegate, viewWidth: viewWidth)
        }
        if let weapon = wargear as? Weapon, let subWeapon = weapon.secondProfile   {
            for weapon in subWeapon {
                setupText(wargear: weapon, delegate: delegate, viewWidth: viewWidth)
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
        header.setupText(name: name)
        addArrangedSubview(header)
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
    
    private func setupSpecialRule(rules: [WeaponSpecialRule], text: String, delegate: WeaponRuleButtonDelegate?, viewWidth: CGFloat) {
        let view = UIView()
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        let label = BigLabel()
        label.text = text
        
        var availableSpace: CGFloat = viewWidth
        var arrayOfView = [[UIView]]()
        
        var numberOfRow = 0
        var numberViewInRow = 0
        
        view.addSubview(label)
        arrayOfView.append([label])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.Otstup.small),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.Otstup.large),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -Constant.Size.Otstup.small),
        ])
        availableSpace -= label.getViewWidth()
        availableSpace -= Constant.Size.Otstup.large
        
        for rule in rules {
            let button = WeaponRuleButton()
            view.addSubview(button)
            button.delegate = delegate
            button.setupText(weaponRule: rule)
            
            NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: arrayOfView[numberOfRow][numberViewInRow].centerYAnchor),
                button.leadingAnchor.constraint(equalTo: arrayOfView[numberOfRow][numberViewInRow].trailingAnchor, constant: Constant.Size.Otstup.small)
            ])
           
            if button.getViewWidth() > availableSpace {
                
                availableSpace = viewWidth
                numberViewInRow = 0
                numberOfRow += 1
                
                button.removeFromSuperview()
                view.addSubview(button)
                arrayOfView.append([button])
               
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: arrayOfView[numberOfRow-1][numberViewInRow].bottomAnchor),
                    button.leadingAnchor.constraint(equalTo: arrayOfView[numberOfRow-1][numberViewInRow].leadingAnchor),
                    button.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -Constant.Size.Otstup.small)
                ])
               
                availableSpace -= button.getViewWidth()
                availableSpace -= Constant.Size.Otstup.large
            } else {
                availableSpace -= button.getViewWidth()
                availableSpace -= Constant.Size.Otstup.small
                arrayOfView[numberOfRow].append(button)
                numberViewInRow += 1
            }
         }
        addArrangedSubview(view)
        
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
