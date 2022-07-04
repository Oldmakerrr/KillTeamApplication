//
//  TacticalAssetsView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class TacticalAssetsView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        backgroundColor = ColorScheme.shared.theme.viewBackground
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(tacticalAssets: VeteranGuardsmanAbility.TacticalAssets, delegate: WeaponRuleButtonDelegate) {
        setupHeader(title: tacticalAssets.name)
        setupTextView(text: tacticalAssets.description)
        setupWeaponView(weapon: tacticalAssets.weapon, delegate: delegate)
    }
    
    private func setupWeaponView(weapon: Weapon, delegate: WeaponRuleButtonDelegate) {
        let backgroundView = UIView()
        let view = WeaponView()
        view.addView(view: backgroundView, subView: view)
        addArrangedSubview(backgroundView)
        view.layer.applyBorder()
        view.setupText(wargear: weapon, delegate: delegate, viewWidth: UIScreen.main.bounds.width - 20)
    }
}
