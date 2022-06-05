//
//  ExtentionMoreInfoUnit.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

extension MoreInfoUnitViewController {
    
    @objc private func stepperAction() {
        guard var unit = presenter?.model.choosenUnit,
              let indexPath = presenter?.model.indexPathOfChoosenUnit,
              var killTeam = presenter?.model.killTeam else { return }
        unit.currentWounds = Int(stepper.value)
        currentWoundLabel.text = "Current wound: \(Int(stepper.value))"
        presenter?.model.choosenUnit? = unit
        killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] = unit
        presenter?.store.updateCurrentKillTeam(killTeam: killTeam)
        presenter?.model.killTeam = killTeam
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func setupScrollViewContainer() {
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.axis = .vertical
        scrollViewContainer.spacing = 5
        scrollViewContainer.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }
    
    func setupAdditionalView() {
        guard let unit = presenter?.model.choosenUnit else { return }
        //let characteristicsView = CharacteristicsView()
        //addUnitCharacteristicsView(unit: unit, characteristicsView: characteristicsView)
        //characteristicsView.layoutIfNeeded()
        //let width = characteristicsView.frame.size.width
        //characteristicsView.setupText(unit: unit, widthSuperView: width)
        addUnitCharacteristicsView(unit: unit)
        addCurrentWoundView(unit: unit)
        addDescriptionView(text: unit.description)
        if let rangeWeapon = unit.selectedRangeWeapon {
            addHeaderView(text: "Wargear (Range)")
            addWeaponView(weapon: rangeWeapon)
            setupAdditionalWeapon(unit: unit, type: .range)
        }
     
        if let closeWeapon = unit.selectedCloseWeapon {
            addHeaderView(text: "Wargear (Melee)")
            addWeaponView(weapon: closeWeapon)
            setupAdditionalWeapon(unit: unit, type: .close)
        }
        
        if !unit.equipment.isEmpty {
            addEquipmentView(equipments: unit.equipment)
        }
        if let abilities = unit.abilities {
            addAbilitiesView(abilities: abilities, additionalAbilitie: unit.additionalAbilitie)
        } else {
            if let chaosBlessing = unit.additionalAbilitie as? UnitAbilitie {
                addHeaderView(text: "Abilities")
                setupChaosBlessing(chaosBlessing: chaosBlessing)
            }
        }
        if let uniqueActions = unit.uniqueActions {
            addUniqueActionsView(uniqueActions: uniqueActions)
        }
        addKeywordView()
    }
    
    private func setupAdditionalWeapon(unit: Unit, type: WeaponType) {
        guard let additionalWeapon = unit.additionalWeapon else { return }
        additionalWeapon.forEach { weapon in
            if weapon.type == type &&
                weapon.name != unit.selectedRangeWeapon?.name &&
                weapon.name != unit.selectedCloseWeapon?.name {
                addWeaponView(weapon: weapon)
            }
        }
        
    }
    
    private func addWeaponView(weapon: Weapon) {
        let view = WeaponView()
        scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
        view.setupText(wargear: weapon, delegate: self, viewWidth: view.getViewWidth())
        guard let specialRule = weapon.specialRule, let availableWeapon = presenter?.model.choosenUnit?.availableWeapon else { return }
        if specialRule.contains(where: { weaponSpecialRule in
            weaponSpecialRule.name == "Combi"
        }) || specialRule.contains(where: { weaponSpecialRule in
            weaponSpecialRule.name == "Kombi"
        }) {
            weaponWithCombi(availableWeapon: availableWeapon)
        }
    }
    
    private func weaponWithCombi(availableWeapon: [Weapon]) {
        var mainWeapon: Weapon?
        availableWeapon.forEach { weapon in
            if weapon.name == "Boltgun" {
                mainWeapon = weapon
            }
            if weapon.name == "Deathwatch boltgun" {
                mainWeapon = weapon
            }
            if weapon.name == "Shoota" {
                mainWeapon = weapon
            }
        }
        if let weapon = mainWeapon {
            addWeaponView(weapon: weapon)
        }
    }
    
    private func addCurrentWoundView(unit: Unit) {
        let view = UIView()
        currentWoundLabel.text = "Current wound: \(unit.currentWounds ?? unit.wounds)"
        currentWoundLabel.font = UIFont.boldSystemFont(ofSize: 22)
        stepper.addTarget(self, action: #selector(stepperAction), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorScheme.shared.theme.viewBackground
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 0
        stepper.maximumValue = Double(unit.wounds)
        stepper.value = Double(unit.currentWounds ?? unit.wounds)
        stepper.stepValue = 1
        view.addSubview(currentWoundLabel)
        view.addSubview(stepper)
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: Constant.Size.headerHeight),
            currentWoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentWoundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stepper.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
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
        scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
    }
    
    private func addUniqueActionsView(uniqueActions: [UnitUniqueAction]) {
        addHeaderView(text: "Unique Actions")
        for uniqueAction in uniqueActions {
            let view = UniqueActionView()
            view.backgroundColor = ColorScheme.shared.theme.viewBackground
            view.layer.applyCornerRadius()
            view.layer.masksToBounds = true
            scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
            view.setupTextForUnit(action: uniqueAction, delegate: self, viewWidth: view.getViewWidth())
        }
    }
    
    private func addAbilitiesView (abilities: [UnitAbilitie], additionalAbilitie: UnitAbilitieProtocol?) {
        addHeaderView(text: "Abilities")
        for ability in abilities {
            let view = AbilitieView()
            view.backgroundColor = ColorScheme.shared.theme.viewBackground
            view.layer.applyCornerRadius()
            view.layer.masksToBounds = true
            view.setupText(abilitie: ability)
            scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
        }
        if let chaosBlessing = additionalAbilitie {
            setupChaosBlessing(chaosBlessing: chaosBlessing)
        }
    }
    
    private func setupChaosBlessing(chaosBlessing: UnitAbilitieProtocol) {
        let view = AbilitieView()
        view.backgroundColor = ColorScheme.shared.theme.viewBackground
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
        view.setupText(abilitie: chaosBlessing)
        scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
    }
    
    private func addDescriptionView(text: String) {
        let view = TextView()
        view.addView()
        view.label.text = text
        scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
    }
    
    private func addBackgroundView(contentView: UIView) -> UIView {
        let backgroundView = UIView()
        backgroundView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Constant.Size.Otstup.small),
            contentView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Constant.Size.Otstup.small)
        ])
        return backgroundView
    }
    
    private func addUnitCharacteristicsView(unit: Unit) {
        addHeaderView(text: unit.name)
        let view = CharacteristicsViewWithoutImage(unit: unit)
        scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
    }
    
    //WithImage
    /*
     private func addUnitCharacteristicsView (unit: Unit, characteristicsView: CharacteristicsView) {
         addHeaderView(text: unit.name)
         let contentView = UIView()
         contentView.backgroundColor = ColorScheme.shared.theme.viewBackground
         contentView.layer.applyCornerRadius()
         contentView.layer.masksToBounds = true
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: unit.portrait)
         imageView.contentMode = .scaleToFill
         imageView.backgroundColor = .white
         imageView.layer.applyCornerRadius()
         imageView.layer.masksToBounds = true
         contentView.addSubview(imageView)
         contentView.addSubview(characteristicsView)
         
         NSLayoutConstraint.activate([
             imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.Size.Otstup.normal),
             imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.Size.Otstup.normal),
             imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.Otstup.normal),
             imageView.heightAnchor.constraint(equalToConstant: Constant.Size.PortraitUnit.height),
             imageView.widthAnchor.constraint(equalToConstant: Constant.Size.PortraitUnit.width),
             imageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor)
         ])
         NSLayoutConstraint.activate([
             characteristicsView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             characteristicsView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
             characteristicsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
         ])
         scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: contentView))
     }
     */
    
    private func addEquipmentView(equipments: [Equipment]) {
        addHeaderView(text: "Equipment")
        for equipment in equipments {
            let view = EquipmentView()
            scrollViewContainer.addArrangedSubview(addBackgroundView(contentView: view))
            view.layer.applyCornerRadius()
            view.layer.masksToBounds = true
            view.setupText(wargear: equipment, delegate: self, viewWidth: view.getViewWidth())
            
        }
    }
    
    private func addHeaderView(text: String) {
        let view = HeaderView()
        view.setupText(name: text)
        view.backgroundColor = ColorScheme.shared.theme.viewHeader
        scrollViewContainer.addArrangedSubview(view)
    }
   
}


extension MoreInfoUnitViewController: WeaponRuleButtonDelegate {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
    
    
}

extension UIView {
    
    func getViewWidth() -> CGFloat {
        layoutIfNeeded()
        return frame.size.width
    }
}
