//
//  EquipmentViewAlert.swift
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
        settingsView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(equipment: Equipment) {
        setupHeader(equipment: equipment)
        setupDescription(description: equipment.description)
        if let body = equipment.body {
            setupBody(body: body)
        }
        if let subText = equipment.subText {
            setupSubText(subText: subText)
        }
        if let uniqueAction = equipment.unitAction {
            setupUniqueActionView(action: uniqueAction)
        }
        if let abilitie = equipment.uniqueAction {
            setupAbilitie(abilitie: abilitie)
        }
        if let wargear = equipment.wargear {
            setupWeaponView(weapon: wargear)
        }
    }
    
    private func settingsView() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        backgroundColor = .systemGray2
        
    }
    
    private func setupHeader(equipment: Equipment) {
        let header = HeaderView()
        header.setupText(name: equipment.name, cost: "[\(equipment.cost)EP]")
        addArrangedSubview(header)
       // header.nameLabel.text = equipment.name
       // header.costLabel.text = "[\(equipment.cost)EP]"
       // header.translatesAutoresizingMaskIntoConstraints = false
       // header.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupDescription(description: String) {
        let label = UILabel()
        let view = UIView()
        addArrangedSubview(view)
        view.addSubview(label)
        label.numberOfLines = 0
        label.text = description
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
    }
    
    private func setupBody(body: String) {
        let label = UILabel()
        let view = UIView()
        addArrangedSubview(view)
        view.addSubview(label)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = body
        view.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setupSubText(subText: [String]) {
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
    
    private func setupAbilitie(abilitie: UnitAbilities) {
        let view = AbilitieView()
        view.setupText(abilitie: abilitie)
        addArrangedSubview(view)
    }

        private func setuppostSubTextLabel(postSubText: String) {
            let view = UIView()
            let label = UILabel()
            addArrangedSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 18)
            label.numberOfLines = 0
            label.text = postSubText
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

        }
     
    private func setupUniqueActionView(action: UnitUniqueActions) {
        let view = uniqueActionView()
        let backgroundView = UIView()
        view.setupText(action: action)
        backgroundView.addSubview(view)
        addArrangedSubview(backgroundView)
        view.backgroundColor = .systemGray4
        view.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10).isActive = true
        view.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10).isActive = true
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 225, green: 165, blue: 0, alpha: 1)
        
    }
    
    private func setupWeaponView(weapon: Weapon) {
        let view = WeaponView()
        let backgroundView = UIView()
        view.addText(weapon: weapon)
        if let subProfiles = weapon.secondProfile {
            for profile in subProfiles {
                view.addText(weapon: profile)
            }
        }
        addArrangedSubview(backgroundView)
        backgroundView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10).isActive = true
        view.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10).isActive = true
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

class uniqueActionView: UIStackView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSettings()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSettings() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        backgroundColor = .systemGray2
    }
    
    func setupTextForUnit(action: UnitUniqueActions) {
        setupActionText(uniqueAction: action)
        if let subText = action.subText {
            setupSubText(subText: subText)
        }
        if let wargear = action.wargear {
            setupWeaponView(weapon: wargear)
        }
        if let postSubText = action.postSubText {
            setuppostSubTextLabel(postSubText: postSubText)
        }
    }
    
    
    func setupText(action: UnitUniqueActions) {
        setupHeader(action: action)
        setupDescriptionLabel(description: action.description)
        if let subText = action.subText {
            setupSubText(subText: subText)
        }
        if let wargear = action.wargear {
            setupWeaponView(weapon: wargear)
        }
        if let postSubText = action.postSubText {
            setuppostSubTextLabel(postSubText: postSubText)
        }
    }
    
    private func setupActionText(uniqueAction: UnitUniqueActions) {
        let view = UIView()
        let label = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        addArrangedSubview(view)
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let text = NSMutableAttributedString(string: uniqueAction.name, attributes: attributBold)
        let coast = NSMutableAttributedString(string: " (\(uniqueAction.cost)AP)", attributes: attributBold)
        let description = NSAttributedString(string: ": \(uniqueAction.description)")
        text.append(coast)
        text.append(description)
        label.attributedText = text
    }
    
    private func setupHeader(action: UnitUniqueActions) {
        let header = HeaderView()
        header.setupText(name: action.name, cost: "\(action.cost) AP")
        addArrangedSubview(header)
       // header.nameLabel.text = action.name
       // header.costLabel.text = "\(action.cost) AP"
       // header.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupDescriptionLabel(description: String) {
        let view = UIView()
        let label = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        addArrangedSubview(view)
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = description
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

    }
    
    private func setupWeaponView(weapon: Weapon) {
        let view = WeaponView()
        let backgroundView = UIView()
        backgroundView.addSubview(view)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        if let subWeapon = weapon.secondProfile {
            for weapon in subWeapon {
                view.addText(weapon: weapon)
            }
        }
        view.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10).isActive = true
        view.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10).isActive = true
        view.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10).isActive = true
        addArrangedSubview(backgroundView)
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 225, green: 165, blue: 0, alpha: 1)
        view.addText(weapon: weapon)
        
    }
    
    private func setupSubText(subText: [String]) {
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
    
    private func setuppostSubTextLabel(postSubText: String) {
        let view = UIView()
        let label = UILabel()
        addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = postSubText
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

    }
    
}


class AbilitieView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSettings()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupText(abilitie: UnitAbilities) {
        setupAbilitie(abilitie: abilitie)
        if let subText = abilitie.subText {
            setupSubText(subText: subText)
        }
    }
    
    private func setupSettings() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
    }
    
    
    private func setupAbilitie(abilitie: UnitAbilities) {
        let view = UIView()
        let label = UILabel()
        addArrangedSubview(view)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        label.numberOfLines = 0
        let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let text = NSMutableAttributedString(string: abilitie.name, attributes: attributBold)
        let description = NSAttributedString(string: ": \(abilitie.description)")
        text.append(description)
        label.attributedText = text
        
    }
    
    private func setupSubText(subText: [String]) {
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
}
