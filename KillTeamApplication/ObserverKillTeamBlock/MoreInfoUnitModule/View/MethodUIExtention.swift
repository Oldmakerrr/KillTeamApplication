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
        addHeaderView(text: "Characteristics")
        characteristicsView.setupText(unit: unit)
        scrollViewContainer.addArrangedSubview(characteristicsView)
        if let rangeWeapon = unit.selectedRangeWeapon {
            addWeaponView(weapon: rangeWeapon, title: "Wargear (Range)")
        }
     
        if let closeWeapon = unit.selectedCloseWeapon {
            addWeaponView(weapon: closeWeapon, title: "Wargear (Close)")
        }
        
        if !unit.equipment.isEmpty {
            addEquipmentView(equipments: unit.equipment)
        }
        if let abilities = unit.abilities {
            addAbilitiesView(abilities: abilities)
        }
        if let uniqueActions = unit.uniqueActions {
            addUniqueActionsView(uniqueActions: uniqueActions)
        }
        addKeywordView()
    }
    
    private func addWeaponView(weapon: Weapon, title: String) {
        addHeaderView(text: title)
        let view = WeaponView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.addText(weapon: weapon)
        scrollViewContainer.addArrangedSubview(view)
        if let subProfiles = weapon.secondProfile {
            for weapon in subProfiles {
                let subView = WeaponView()
                subView.layer.masksToBounds = true
                subView.layer.cornerRadius = 12
                subView.addText(weapon: weapon)
                scrollViewContainer.addArrangedSubview(subView)
            }
        }
    }
    
    private func addKeywordView() {
        guard let unit = presenter?.model.choosenUnit else { return }
        addHeaderView(text: "Keywords")
        let view = TextView()
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
    
    private func addUniqueActionsView(uniqueActions: [UnitUniqueActions]) {
        addHeaderView(text: "Unique Actions")
        for uniqueAction in uniqueActions {
            let view = uniqueActionView()
            view.setupTextForUnit(action: uniqueAction)
            view.backgroundColor = .systemGray2
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 12
            scrollViewContainer.addArrangedSubview(view)
        }
    }
    
    private func addAbilitiesView (abilities: [UnitAbilities]) {
        addHeaderView(text: "Abilities")
        for ability in abilities {
            let view = AbilitieView()
            view.backgroundColor = .systemGray2
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 12
            view.setupText(abilitie: ability)
            scrollViewContainer.addArrangedSubview(view)
        }
    }
    
    private func addEquipmentView(equipments: [Equipment]) {
        addHeaderView(text: "Equipment")
        for equipment in equipments {
            let view = EquipmentView()
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 12
            view.setupText(equipment: equipment)
            scrollViewContainer.addArrangedSubview(view)
        }
    }
    
    private func addHeaderView(text: String) {
        let view = HeaderView()
        view.setupText(name: text, cost: nil)
       // view.nameLabel.text = text
       // view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .systemOrange
        view.nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        scrollViewContainer.addArrangedSubview(view)
    }
}
