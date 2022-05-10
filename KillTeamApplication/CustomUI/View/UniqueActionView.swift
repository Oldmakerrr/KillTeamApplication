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
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        backgroundColor = ColorScheme.shared.theme.subViewBackground
    }
    
    func setupTextForUnit(action: UnitUniqueAction, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        setupActionText(uniqueAction: action)
        if let subText = action.subText {
            addSubTextPointView(subText: subText)
        }
        if let wargear = action.wargear {
            setupWeaponView(weapon: wargear, delegate: delegate, viewWidth: viewWidth)
        }
        if let postSubText = action.postSubText {
            addTextView(text: postSubText)
        }
    }
    
    
    func setupText(action: UnitUniqueAction, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        setupHeader(action: action)
        addTextView(text: action.description)
        if let subText = action.subText {
            addSubTextPointView(subText: subText)
        }
        if let wargear = action.wargear {
            setupWeaponView(weapon: wargear, delegate: delegate, viewWidth: viewWidth)
        }
        if let postSubText = action.postSubText {
            addTextView(text: postSubText)
        }
    }
    
    private func setupActionText(uniqueAction: UnitUniqueAction) {
        let view = UIView()
        let label = BoldTextLabel()
        label.addText(bold: "\(uniqueAction.name) (\(uniqueAction.cost)AP)", normal: uniqueAction.description)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        addArrangedSubview(view)
        addView(view: view, subView: label)
    }
    
    private func setupHeader(action: UnitUniqueAction) {
        let header = HeaderIntView()
        header.setupText(name: action.name, cost: "\(action.cost) AP")
        addArrangedSubview(header)
    }
    
    private func setupWeaponView(weapon: Weapon, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        let view = WeaponView()
        let backgroundView = UIView()
        addView(view: backgroundView, subView: view)
        addArrangedSubview(backgroundView)
        view.setupText(wargear: weapon, delegate: delegate, viewWidth: viewWidth)
        view.layer.borderWidth = Constant.Size.borderWidht
        view.layer.borderColor = ColorScheme.shared.theme.cellBorder.cgColor
    }
}

