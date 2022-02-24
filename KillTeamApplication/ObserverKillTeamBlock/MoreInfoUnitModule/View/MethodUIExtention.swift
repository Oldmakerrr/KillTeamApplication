//
//  MethodUIExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

extension MoreInfoUnitViewController {
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupScrollViewContainer() {
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.axis = .vertical
        scrollViewContainer.spacing = 10
        scrollViewContainer.backgroundColor = .gray
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func setupAdditionalView() {
        guard let unit = presenter?.model.choosenUnit else { return }
        scrollViewContainer.addArrangedSubview(addHeader(text: "Characteristics"))
        scrollViewContainer.addArrangedSubview(characteristicsView)
        scrollViewContainer.addArrangedSubview(addHeader(text: "Wargear"))
        
        if unit.selectedRangeWeapon != nil{
            scrollViewContainer.addArrangedSubview(addWeaponView(weapon: unit.selectedRangeWeapon!))
        }
        scrollViewContainer.addArrangedSubview(addWeaponView(weapon: unit.selectedCloseWeapon))
        if !unit.equipment.isEmpty {
            addEquipmentView()
        }
        if unit.abilities != nil {
            addAbilitiesView()
        }
        if unit.uniqueActions != nil {
            addUniqueActionsView()
        }
        addKeywordView()
    }
    
    func addKeywordView() {
        guard let unit = presenter?.model.choosenUnit else { return }
        scrollViewContainer.addArrangedSubview(addHeader(text: "Keywords"))
        let view = AbilitiesView()
        view.addView()
        var keywords = ":"
        for (index, key) in unit.keyWords.enumerated() {
            switch index+1 == unit.keyWords.count{
            case false:
                keywords += " \(key),"
            case true:
                keywords += " \(key)."
            }
        }
        let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let keywordsString = NSMutableAttributedString(string: "Keywords", attributes: attributBold)
        let allKeywords = NSAttributedString(string: keywords)
        keywordsString.append(allKeywords)
        view.label.attributedText = keywordsString
        scrollViewContainer.addArrangedSubview(view)
    }
    
    func addUniqueActionsView() {
        if let uniqueActions = presenter?.model.choosenUnit?.uniqueActions {
            scrollViewContainer.addArrangedSubview(addHeader(text: "Unique Actions"))
            for uniqueAction in uniqueActions {
                let view = AbilitiesView()
                view.addView()
                let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
                let text = NSMutableAttributedString(string: uniqueAction.name, attributes: attributBold)
                let coast = NSMutableAttributedString(string: " (\(uniqueAction.cost)AP)", attributes: attributBold)
                let description = NSAttributedString(string: ": \(uniqueAction.description)")
                text.append(coast)
                text.append(description)
                view.label.attributedText = text
                scrollViewContainer.addArrangedSubview(view)
            }
        }
    }
    
    func addAbilitiesView () {
        if let abilities = presenter?.model.choosenUnit?.abilities {
            scrollViewContainer.addArrangedSubview(addHeader(text: "Abilities"))
            for ability in abilities {
                let view = AbilitiesView()
                view.addView()
                let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
                let text = NSMutableAttributedString(string: ability.name, attributes: attributBold)
                let description = NSAttributedString(string: ": \(ability.description)")
                text.append(description)
                view.label.attributedText = text
                scrollViewContainer.addArrangedSubview(view)
            }
        }
    }
    
    func addEquipmentView() {
        let unit = presenter?.model.choosenUnit
        let equipments = unit?.equipment
        scrollViewContainer.addArrangedSubview(addHeader(text: "Equipment"))
        for equipment in equipments! {
            let equipmentView = EquipmentView()
            scrollViewContainer.addArrangedSubview(equipmentView)
            equipmentView.nameLabel.text = equipment.name
            equipmentView.descriptionLabel.text = equipment.description
            if let wargear = equipment.wargear {
                let weaponView = addWeaponView(weapon: wargear)
                weaponView.layer.cornerRadius = 0
                equipmentView.addArrangedSubview(weaponView)
            }
            if let uniqueAction = equipment.uniqueAction {
                equipmentView.setupuniqueAction()
                let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
                let text = NSMutableAttributedString(string: uniqueAction.name, attributes: attributBold)
                let description = NSAttributedString(string: ": \(uniqueAction.description)")
                text.append(description)
                equipmentView.uniqueActionDescriptionLabel.attributedText = text
            }
        }
    }
    
    func setupLabelText() {
        if let unit = presenter?.model.choosenUnit {
            characteristicsView.movementLabel.text = "M = \(unit.movement)"
            characteristicsView.actionPointLimit.text = "APL = \(unit.actionPointLimit)"
            characteristicsView.groupActivation.text = "GA = \(unit.groupActivation)"
            characteristicsView.defence.text = "D = \(unit.defense)"
            characteristicsView.save.text = "Sv = \(unit.save)+"
            characteristicsView.wounds.text = "W = \(unit.wounds)"
        }
    }
    
    func addWeaponView(weapon: Weapon) -> UIView {
        let view = WeaponView()
        view.nameLabel.text = weapon.name
        view.attackLabel.text = "A = \(weapon.attacks)"
        switch weapon.type {
        case "range":
            view.ballisticSkillsLabel.text = "BS = \(weapon.ballisticWeaponSkill)+"
        case "close":
            view.ballisticSkillsLabel.text = "WS = \(weapon.ballisticWeaponSkill)+"
        default:
            break
        }
        view.damageLabel.text = "D = \(weapon.damage)/\(weapon.critDamage)"
        if let specialRule = weapon.specialRule {
            let specialRuleView = view.secondSubView
            view.setupView(view: specialRuleView)
            var text = ""
            for (index, rule) in specialRule.enumerated() {
                switch index+1 == specialRule.count {
                case true:
                    text += "\(rule.name)."
                case false:
                    text += "\(rule.name), "
                }
            }
            view.specialRuleLabel.text = "Special rule: \(text)"
        }
        if let critSpecialRule = weapon.criticalHitspecialRule {
            let specialCritRuleView = view.thirdSubView
            view.setupView(view: specialCritRuleView)
            var text = ""
            for (index, rule) in critSpecialRule.enumerated() {
                switch index+1 == critSpecialRule.count {
                case true:
                    text += "\(rule.name)."
                case false:
                    text += "\(rule.name), "
                }
            }
            view.criticalHitspecialRuleLabel.text = "!: \(text)"
        }
        return view
    }
    
    
    func addHeader(text: String) -> UIView {
        let view = UIView()
        let label = UILabel()
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.font = UIFont .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.text = text
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        return view
    }
}
