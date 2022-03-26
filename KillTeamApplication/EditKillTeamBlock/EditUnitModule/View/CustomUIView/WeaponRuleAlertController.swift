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
    
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.4431372549, green: 0.4901960784, blue: 0.4941176471, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9764705882, blue: 0.9058823529, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.6980392157, blue: 0.4784313725, alpha: 1)
        return button
    }()
    
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
        layer.cornerRadius = 12
        backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9215686275, blue: 0.8156862745, alpha: 1)
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setupMessageLabel(message: String?) {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
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
            let label = UILabel()
            addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16)
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
