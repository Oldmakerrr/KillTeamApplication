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
    
    
    @objc private func buttonAction() {
        delegate?.didComplete(self)
    }
    
    weak var delegate: TacOpDelegate?
    
    let button = DoneButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.cellBackground
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        let view = UIView()
        addArrangedSubview(view)
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.EdgeInsets.normal),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.EdgeInsets.normal),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: Constant.Size.NormalButton.width),
            button.heightAnchor.constraint(equalToConstant: Constant.Size.NormalButton.height)
        ])
    }
    
    func setupText(tacOp: TacOp, delegate: WeaponRuleButtonDelegate) {
        
        let descriptionLabel = NormalLabel()
        addTextView(text: tacOp.description, trailingSpace: Constant.Size.EdgeInsets.normal, label: descriptionLabel)
        
        if let subDescription = tacOp.subDescription {
            let label = NormalLabel()
            addTextView(text: subDescription, trailingSpace: Constant.Size.EdgeInsets.normal, label: label)
        }
        
        addConditionTextView(text: tacOp.firstCondition, trailingSpace: Constant.Size.EdgeInsets.large)
        
        if let secondCondition = tacOp.secondCondition {
            addConditionTextView(text: secondCondition, trailingSpace: Constant.Size.EdgeInsets.large)
        }
        
        if let subConditionTitle = tacOp.subConditionTitle {
            let label = BoldLabel()
            addTextView(text: subConditionTitle, trailingSpace: Constant.Size.EdgeInsets.large, label: label)
        }
        
        if let subCondition = tacOp.subConditions {
            subCondition.forEach { text in
                addConditionTextView(text: text, trailingSpace: 25)
            }
        }
        
        if let subText = tacOp.subText {
            let label = NormalLabel()
            addTextView(text: subText, trailingSpace: Constant.Size.EdgeInsets.normal, label: label)
        }
        
        if let uniquiAction = tacOp.uniqueAction {
            let view = UIView()
            let actionView = UniqueActionView()
            actionView.layer.applyBorder()
            addView(view: view, subView: actionView)
            addArrangedSubview(view)
            actionView.setupText(action: uniquiAction, delegate: delegate, viewWidth: actionView.getViewWidth())
        }
        
        if let abilitie = tacOp.ability {
            let view = AbilitieView()
            view.setupText(abilitie: abilitie)
            addArrangedSubview(view)
        }
    }
    
    func setHeader(title: String) {
        let view = HeaderView()
        view.setupText(name: title)
        addArrangedSubview(view)
    }
    
    private func addTextView(text: String, trailingSpace: CGFloat, label: UILabel) {
        let view = UIView()
        let label = label
        view.addSubview(label)
        label.text = text
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: trailingSpace).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.EdgeInsets.normal).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.EdgeInsets.small).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.EdgeInsets.small).isActive = true
        addArrangedSubview(view)
        
    }
    
    func addConditionTextView(text: String, trailingSpace: CGFloat) {
        let view = UIView()
        let label = NormalLabel()
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = .black
        view.addSubview(label)
        view.addSubview(imageView)
        label.text = text
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constant.Size.EdgeInsets.small),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.EdgeInsets.normal),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.EdgeInsets.small),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.EdgeInsets.small)
        ])
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: trailingSpace),
            imageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -Constant.Size.EdgeInsets.small),
            imageView.topAnchor.constraint(equalTo: label.topAnchor, constant: label.font.pointSize/2 - 2),
            imageView.heightAnchor.constraint(equalToConstant: Constant.Size.imagePointSize),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        addArrangedSubview(view)
    }
    
}

