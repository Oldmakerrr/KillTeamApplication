//
//  PsychicPowerView.swift
//  KillTeamApplication
//
//  Created by Apple on 25.04.2022.
//

import Foundation
import UIKit

class PsychicPowerView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        backgroundColor = ColorScheme.shared.theme.viewBackground
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(psychicPower: PsychicPower, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        setupHeader(psychicPower: psychicPower)
        if let type = psychicPower.type {
            setupTypeView(type: type)
        }
        setupDescription(psychicPower: psychicPower)
        if let subText = psychicPower.subText {
            setupSubText(subText: subText)
        }
        if let weapon = psychicPower.weapon {
            setupWeaponView(weapon: weapon, delegate: delegate, viewWidth: viewWidth)
        }
        setupView()
    }
    
    private func setupHeader(psychicPower: PsychicPower) {
        let view = HeaderView()
        view.backgroundColor = ColorScheme.shared.theme.psychicPowerViewHeader
        view.nameLabel.textColor = ColorScheme.shared.theme.textWhite
        view.setupText(name: psychicPower.name)
        addArrangedSubview(view)
    }
    
    private func setupTypeView(type: String) {
        let view = UIView()
        let label: UILabel = {
            let label = UILabel()
            label.font = UIFont.italicSystemFont(ofSize: 16)
            label.text = type
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        view.addView(top: Constant.Size.EdgeInsets.normal,
                     bottom: 0,
                     leading: Constant.Size.EdgeInsets.normal,
                     trailing: Constant.Size.EdgeInsets.small,
                     view: view,
                     subView: label)
        addArrangedSubview(view)
    }
    
    private func setupDescription(psychicPower: PsychicPower) {
        let view = UIView()
        let label = NormalLabel()
        label.text = psychicPower.description
        view.addView(view: view, subView: label)
        addArrangedSubview(view)
    }
    
    private func setupSubText(subText: [String]) {
        addSubTextPointView(subText: subText)
    }
    
    private func setupWeaponView(weapon: Weapon, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        let backgroundView = UIView()
        let view = WeaponView()
        backgroundView.addView(top: Constant.Size.EdgeInsets.small,
                               bottom: Constant.Size.EdgeInsets.small,
                               leading: Constant.Size.EdgeInsets.small,
                               trailing: Constant.Size.EdgeInsets.small,
                               view: backgroundView,
                               subView: view)
        addArrangedSubview(backgroundView)
        view.setupText(wargear: weapon, delegate: delegate, viewWidth: viewWidth)
        view.header.backgroundColor = ColorScheme.shared.theme.psychicPowerViewHeader
        view.header.nameLabel.textColor = ColorScheme.shared.theme.textWhite
        view.layer.borderColor = ColorScheme.shared.theme.psychicPowerViewHeader.cgColor
        view.layer.borderWidth = Constant.Size.borderWidht
    }
    
    private func setupView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constant.Size.EdgeInsets.small).isActive = true
        addArrangedSubview(view)
    }
    
}
