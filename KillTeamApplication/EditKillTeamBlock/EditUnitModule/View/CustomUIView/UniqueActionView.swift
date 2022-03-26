//
//  UniqueActionView.swift
//  KillTeamApplication
//
//  Created by Apple on 23.03.2022.
//

import Foundation
import UIKit

class UniqueActionView: UIStackView {
   
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
    
    func setupTextForUnit(action: UnitUniqueActions, delegate: WeaponRuleButtonProtocol) {
        setupActionText(uniqueAction: action)
        if let subText = action.subText {
            addSubTextView(subText: subText)
        }
        if let wargear = action.wargear {
            setupWeaponView(weapon: wargear, delegate: delegate)
        }
        if let postSubText = action.postSubText {
            addTextView(text: postSubText)
        }
    }
    
    
    func setupText(action: UnitUniqueActions, delegate: WeaponRuleButtonProtocol) {
        setupHeader(action: action)
        addTextView(text: action.description)
        if let subText = action.subText {
            addSubTextView(subText: subText)
        }
        if let wargear = action.wargear {
            setupWeaponView(weapon: wargear, delegate: delegate)
        }
        if let postSubText = action.postSubText {
            addTextView(text: postSubText)
        }
    }
    
    private func setupActionText(uniqueAction: UnitUniqueActions) {
        let view = UIView()
        //let label = UILabel()
        let label = BoldTextLabel()
        label.addText(bold: "\(uniqueAction.name) (\(uniqueAction.cost)AP)", normal: uniqueAction.description)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        addArrangedSubview(view)
        addView(top: 10, bottom: 10, leading: 10, trailing: 10, view: view, subView: label)
    }
    
    private func setupHeader(action: UnitUniqueActions) {
        let header = HeaderView()
        header.setupText(name: action.name, cost: "\(action.cost) AP")
        addArrangedSubview(header)
    }
    
    private func setupWeaponView(weapon: Weapon, delegate: WeaponRuleButtonProtocol) {
        let view = WeaponView()
        let backgroundView = UIView()
        if let subWeapon = weapon.secondProfile {
            for weapon in subWeapon {
                view.addText(weapon: weapon, delegate: delegate)
            }
        }
        addView(top: 10, bottom: 10, leading: 10, trailing: 10, view: backgroundView, subView: view)
        addArrangedSubview(backgroundView)
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 225, green: 165, blue: 0, alpha: 1)
        view.addText(weapon: weapon, delegate: delegate)
        
    }
}

