//
//  EquipmentView.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

class EquipmentView: UIStackView {
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(equipment: Equipment, delegate: WeaponRuleButtonProtocol) {
        setupHeader(equipment: equipment)
        addTextView(text: equipment.description)
        if let body = equipment.body {
            addTextView(text: body)
        }
        if let subText = equipment.subText {
            addSubTextView(subText: subText)
        }
        if let uniqueAction = equipment.unitAction {
            setupUniqueActionView(action: uniqueAction, delegate: delegate)
        }
        if let abilitie = equipment.uniqueAction {
            setupAbilitie(abilitie: abilitie)
        }
        if let wargear = equipment.wargear {
            setupWeaponView(weapon: wargear, delegate: delegate)
        }
    }
    
    private func configue() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        backgroundColor = .systemGray2
    }
    
    private func setupHeader(equipment: Equipment) {
        let header = HeaderView()
        header.setupText(name: equipment.name, cost: "[\(equipment.cost)EP]")
        addArrangedSubview(header)
    }
 
    private func setupAbilitie(abilitie: UnitAbilities) {
        let view = AbilitieView()
        view.setupText(abilitie: abilitie)
        addArrangedSubview(view)
    }
 
    private func setupUniqueActionView(action: UnitUniqueActions, delegate: WeaponRuleButtonProtocol) {
        let view = UniqueActionView()
        let backgroundView = UIView()
        view.setupText(action: action, delegate: delegate)
        addView(top: 10, bottom: 10, leading: 10, trailing: 10, view: backgroundView, subView: view)
        addArrangedSubview(backgroundView)
        view.backgroundColor = .systemGray4
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 225, green: 165, blue: 0, alpha: 1)
    }
    
    private func setupWeaponView(weapon: Weapon, delegate: WeaponRuleButtonProtocol) {
        let view = WeaponView()
        let backgroundView = UIView()
        view.addText(weapon: weapon, delegate: delegate)
        if let subProfiles = weapon.secondProfile {
            for profile in subProfiles {
                view.addText(weapon: profile, delegate: delegate)
            }
        }
        addArrangedSubview(backgroundView)
        addView(top: 10, bottom: 10, leading: 10, trailing: 10, view: backgroundView, subView: view)
        view.backgroundColor = .systemGray4
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 225, green: 165, blue: 0, alpha: 1)
    }
    
    func setupButton() {
        let view = UIView()
        view.addSubview(button)
        addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .orange
        button.setTitle("Done", for: .normal)
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}


extension UIStackView {
    
    func addSubTextView(subText: [String]) {
        var labels = [UILabel]()
        let view = UIView()
        addArrangedSubview(view)
        for (index, text) in subText.enumerated() {
            let label = UILabel()
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 18)
            label.text = text
            labels.append(label)
            if index == 0 {
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: labels[index-1].bottomAnchor, constant: 10).isActive = true
            }
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            if index+1 == subText.count {
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            }
        }
    }
    
    func addTextView(text: String) {
        let label = UILabel()
        let view = UIView()
        addArrangedSubview(view)
        view.addSubview(label)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        addView(top: 10, bottom: 10, leading: 10, trailing: 10, view: view, subView: label)
    }

    
}

extension UIView {
    
    func addView(top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat, view: UIView, subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subView)
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailing),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom)
        ])
    }
}
