//
//  TacOpView.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import Foundation
import UIKit

protocol TacOpDelegate: AnyObject {
    func didComplete(_ view: TacOpView)
}

class TacOpView: UIStackView {
    
    weak var delegate: TacOpDelegate?
    
    let button = DoneButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorScheme.shared.theme.cellBackground
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hideAlertVew() {
        delegate?.didComplete(self)
    }
    
    func setupButton() {
        let view = UIView()
        addArrangedSubview(view)
        view.addSubview(button)
        button.addTarget(self, action: #selector(hideAlertVew), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.Otstup.normal),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.Otstup.normal),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: Constant.Size.NormalButton.width),
            button.heightAnchor.constraint(equalToConstant: Constant.Size.NormalButton.height)
        ])
    }
    
    func setupText(tacOp: TacOp, delegate: WeaponRuleButtonDelegate) {
        
        setHeader(title: tacOp.name)
        let descriptionLabel = NormalLabel()
        setupSubView(text: tacOp.description, trailingSpace: Constant.Size.Otstup.normal, label: descriptionLabel)
        
        if let subDescription = tacOp.subDescription {
            let label = NormalLabel()
            setupSubView(text: subDescription, trailingSpace: Constant.Size.Otstup.normal, label: label)
        }
        let firstConditionLabel = NormalLabel()
        setupSubView(text: tacOp.firstCondition, trailingSpace: Constant.Size.Otstup.large, label: firstConditionLabel)
        
        if let secondCondition = tacOp.secondCondition {
            let label = NormalLabel()
            setupSubView(text: secondCondition, trailingSpace: Constant.Size.Otstup.large, label: label)
        }
        
        if let subCondition = tacOp.subCondition {
            for (index, text) in subCondition.enumerated() {
                if index == 0 {
                    let label = BoldLabel()
                    setupSubView(text: text, trailingSpace: Constant.Size.Otstup.large, label: label)
                } else {
                    let label = NormalLabel()
                    setupSubView(text: text, trailingSpace: 25, label: label)
                }
            }
        }
        
        if let subText = tacOp.subText {
            let label = NormalLabel()
            setupSubView(text: subText, trailingSpace: Constant.Size.Otstup.normal, label: label)
        }
        
        if let uniquiAction = tacOp.uniquiAction {
            let view = UIView()
            let actionView = UniqueActionView()
            actionView.layer.applyBorder()
            actionView.setupText(action: uniquiAction, delegate: delegate)
            addView(view: view, subView: actionView)
            addArrangedSubview(view)
        }
        
        if let abilitie = tacOp.abilitie {
            let view = AbilitieView()
            view.setupText(abilitie: abilitie)
            addArrangedSubview(view)
        }
    }
    
    private func setHeader(title: String) {
        let view = HeaderView()
        view.setupText(name: title)
        addArrangedSubview(view)
    }
    
    private func setupSubView(text: String, trailingSpace: CGFloat, label: UILabel) {
        let view = UIView()
        let label = label
        view.addSubview(label)
        view.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: trailingSpace).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.Otstup.normal).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.Otstup.small).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.Otstup.small).isActive = true
        addArrangedSubview(view)
        
    }
    
}
