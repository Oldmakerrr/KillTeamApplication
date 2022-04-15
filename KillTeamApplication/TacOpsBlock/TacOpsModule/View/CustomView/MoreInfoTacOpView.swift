//
//  MoreInfoTacOpView.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import Foundation
import UIKit

protocol MoreInfoTacOpDelegate: AnyObject {
    func didComplete(_ view: MoreInfoTacOp)
}

class MoreInfoTacOp: UIStackView {
    
    weak var delegate: MoreInfoTacOpDelegate?
    
    let button = DoneButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorScheme.shared.theme.viewBackground
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubView(text: String, trailingSpace: CGFloat) {
        let view = UIView()
        let label = NormalLabel()
        view.addSubview(label)
        view.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: trailingSpace).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.Otstup.normal).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.Otstup.small).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.Otstup.small).isActive = true
        addArrangedSubview(view)
        
    }
    
    @objc func hideAlertVew() {
        delegate?.didComplete(self)
    }
    
    private func setupButton() {
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
    
    private func setHeader(title: String) {
        let view = HeaderView()
        view.setupText(name: title)
        addArrangedSubview(view)
    }
    
    func setupText(tacOp: TacOps, delegate: WeaponRuleButtonDelegate) {
        
        setHeader(title: tacOp.name)
        setupSubView(text: tacOp.description, trailingSpace: Constant.Size.Otstup.normal)
        setupSubView(text: tacOp.firstCondition, trailingSpace: Constant.Size.Otstup.large)
        
        if let secondCondition = tacOp.secondCondition {
            setupSubView(text: secondCondition, trailingSpace: Constant.Size.Otstup.large)
        }
        
        if let subText = tacOp.subText {
            setupSubView(text: subText, trailingSpace: Constant.Size.Otstup.normal)
        }
        
        if let uniquiAction = tacOp.uniquiAction {
            let actionView = UniqueActionView()
            actionView.setupText(action: uniquiAction, delegate: delegate)
            addArrangedSubview(actionView)
        }
        setupButton()
    }
    
}
