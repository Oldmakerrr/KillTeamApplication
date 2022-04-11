//
//  WeaponRuleAlertController.swift
//  KillTeamApplication
//
//  Created by Apple on 26.03.2022.
//

import Foundation
import UIKit

class WeaponRuleAlertController: UIAlertController {
    
    let weaponRuleView = WeaponRuleView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    func setupText(rule: WeaponSpecialRule) {
        weaponRuleView.setupText(title: rule.name, message: rule.description, subText: rule.subText)
        self.view.addSubview(weaponRuleView)
        NSLayoutConstraint.activate([
            weaponRuleView.topAnchor.constraint(equalTo: self.view.topAnchor),
            weaponRuleView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            weaponRuleView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WeaponRuleView: UIView {
    
    let titleLabel = BoldLabel()
    let messageLabel = NormalLabel()
    let doneButton = DoneButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = Constant.Size.cornerRadius
        setupBlurView()
    }
    
    func setupText(title: String?, message: String?, subText: [String]?) {
        setupTitleLabel(title: title)
        setupMessageLabel(message: message)
        if subText == nil {
            setupButton(topView: messageLabel)
        } else {
            setupSubTextLabels(subText: subText)
        }
    }
    
    private func setupBlurView() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: .extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(blurEffectView)
            NSLayoutConstraint.activate([
                blurEffectView.topAnchor.constraint(equalTo: topAnchor),
                blurEffectView.widthAnchor.constraint(equalTo: widthAnchor),
                blurEffectView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        } else {
            backgroundColor = ColorScheme.shared.theme.viewBackground
        }
    }
    
    private func setupButton(topView: UIView) {
        addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            doneButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 120),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func setupTitleLabel(title: String?) {
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setupMessageLabel(message: String?) {
        addSubview(messageLabel)
        messageLabel.text = message
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    private func setupSubTextLabels(subText: [String]?) {
        guard let subText = subText else { return }
        var labels = [UILabel]()
        for (index, text) in subText.enumerated() {
            let label = NormalLabel()
            addSubview(label)
            label.text = text
            labels.append(label)
            if index == 0 {
                label.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: labels[index-1].bottomAnchor, constant: 10).isActive = true
            }
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            if index+1 == subText.count {
                setupButton(topView: labels[index])
            }
        }
    }
}
