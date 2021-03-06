//
//  WeaponRuleView.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation
import UIKit

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
        setupBlurView(style: .extraLight)
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
            doneButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Constant.Size.EdgeInsets.normal),
            doneButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: Constant.Size.NormalButton.width),
            doneButton.heightAnchor.constraint(equalToConstant: Constant.Size.NormalButton.height),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.EdgeInsets.normal)
        ])
    }
    
    private func setupTitleLabel(title: String?) {
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.EdgeInsets.normal)
        ])
    }
    
    private func setupMessageLabel(message: String?) {
        addSubview(messageLabel)
        messageLabel.text = message
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.Size.EdgeInsets.normal),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.EdgeInsets.normal),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.EdgeInsets.normal),
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
                label.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: labels[index-1].bottomAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            }
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.EdgeInsets.large).isActive = true
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.EdgeInsets.normal).isActive = true
            if index+1 == subText.count {
                setupButton(topView: labels[index])
            }
        }
    }
}

