//
//  WeaponRuleButton.swift
//  KillTeamApplication
//
//  Created by Apple on 26.03.2022.
//

import Foundation
import UIKit

protocol WeaponRuleButtonProtocol: AnyObject {
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule)
}

class WeaponRuleButton: UIButton {
     
    weak var delegate: WeaponRuleButtonProtocol?
    
    private var weaponRule: WeaponSpecialRule?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        titleLabel?.textColor = ColorScheme.shared.theme.textHyperlink
        titleLabel?.font = Constant.Font.systemFont
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(actionForButton), for: .touchUpInside)
    }
    
    @objc private func actionForButton() {
        if let weaponRule = weaponRule {
            delegate?.didComplete(self, weaponRule: weaponRule)
        }
    }
    
    func setupText(weaponRule: WeaponSpecialRule) {
        self.weaponRule = weaponRule
        let underlineAttriString = NSAttributedString(string: weaponRule.name,
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        setAttributedTitle(underlineAttriString, for: .normal)
    }
}

protocol TextButtonProtocol: AnyObject {
    func didComplete(TextButton: TextButton)
}

class TextButton: UIButton {
     
    weak var delegate: TextButtonProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        titleLabel?.textColor = ColorScheme.shared.theme.textHyperlink
        titleLabel?.font = Constant.Font.systemFont
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(actionForButton), for: .touchUpInside)
    }
    
    @objc private func actionForButton() {
        delegate?.didComplete(TextButton: self)
    }
    
    func setupText(text: String) {
        let underlineAttriString = NSAttributedString(string: text,
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        setAttributedTitle(underlineAttriString, for: .normal)
    }
}
