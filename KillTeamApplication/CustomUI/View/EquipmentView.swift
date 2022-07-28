//
//  EquipmentView.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol WargearView {
    associatedtype Wargear
    associatedtype Delegate
    func setupText(wargear: Wargear, delegate: WeaponRuleButtonDelegate?, viewWidth: CGFloat)
    func setupButton()
    func setDelegate(delegate: Delegate)
}

protocol EquipmentViewDelegate: AnyObject {
    func didComplete(_ equipmentView: EquipmentView)
}

class EquipmentView: UIStackView, WargearView {
    
    typealias Delegate = EquipmentViewDelegate?
    
    
    func setDelegate(delegate: Delegate) {
        self.delegate = delegate
    }
    
    weak var delegate: EquipmentViewDelegate?
    
    private let button = DoneButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(wargear: Equipment, delegate: WeaponRuleButtonDelegate?, viewWidth: CGFloat) {
        
        setupHeader(equipment: wargear)
        addTextView(text: wargear.description)
        if let subText = wargear.subTexts {
            addSubTextPointView(subText: subText)
        }
        if let uniqueAction = wargear.uniqueAction {
            guard let delegate = delegate else { return }
            setupUniqueActionView(action: uniqueAction, delegate: delegate, viewWidth: viewWidth)
        }
        if let body = wargear.additionalText {
            addTextView(text: body)
        }
        if let abilitie = wargear.ability {
            setupAbilitie(abilitie: abilitie)
        }
        if let wargear = wargear.weapon {
            guard let delegate = delegate else { return }
            setupWeaponView(weapon: wargear, delegate: delegate, viewWidth: viewWidth)
        }
        
    }
    
    private func configue() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        backgroundColor = ColorScheme.shared.theme.viewBackground
    }
    
    @objc private func buttonAction() {
        delegate?.didComplete(self)
    }
    
    private func setupHeader(equipment: Equipment) {
        let header = HeaderIntView()
        header.setupText(name: equipment.name, cost: "[\(equipment.cost)EP]")
        addArrangedSubview(header)
    }
 
    private func setupAbilitie(abilitie: UnitAbilitie) {
        let view = AbilitieView()
        view.setupText(abilitie: abilitie)
        addArrangedSubview(view)
    }
 
    private func setupUniqueActionView(action: UnitUniqueAction, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        let view = UniqueActionView()
        let backgroundView = UIView()
        view.setupText(action: action, delegate: delegate, viewWidth: viewWidth)
        addView(view: backgroundView, subView: view)
        addArrangedSubview(backgroundView)
        view.backgroundColor = ColorScheme.shared.theme.viewBackground
        view.layer.borderWidth = Constant.Size.borderWidht
        view.layer.borderColor = ColorScheme.shared.theme.cellBorder.cgColor
    }
    
    private func setupWeaponView(weapon: Weapon, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        let view = WeaponView()
        let backgroundView = UIView()
        view.setupText(wargear: weapon, delegate: delegate, viewWidth: viewWidth)
        view.backgroundColor = ColorScheme.shared.theme.viewBackground
        view.layer.borderWidth = Constant.Size.borderWidht
        view.layer.borderColor = ColorScheme.shared.theme.cellBorder.cgColor
        addArrangedSubview(backgroundView)
        addView(view: backgroundView, subView: view)
    }
    
    func setupButton() {
        let view = UIView()
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.EdgeInsets.normal),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.EdgeInsets.normal),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: Constant.Size.NormalButton.width),
            button.heightAnchor.constraint(equalToConstant: Constant.Size.NormalButton.height)
        ])
        
    }
}


extension UIStackView {
    
    func addSubTextView(subText: [String]) {
        var labels = [UILabel]()
        let view = UIView()
        addArrangedSubview(view)
        for (index, text) in subText.enumerated() {
            let label = NormalLabel()
            view.addSubview(label)
            label.text = text
            labels.append(label)
            if index == 0 {
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: labels[index-1].bottomAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            }
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.EdgeInsets.normal).isActive = true
            if index+1 == subText.count {
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            }
        }
    }
    
    func addSubTextPointView(subText: [String]) {
        var labels = [UILabel]()
        let view = UIView()
        addArrangedSubview(view)
        for (index, text) in subText.enumerated() {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "circle.fill")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tintColor = .black
            let label = NormalLabel()
            view.addSubview(label)
            view.addSubview(imageView)
            label.text = text
            labels.append(label)
            if index == 0 {
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: labels[index-1].bottomAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            }
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constant.Size.EdgeInsets.small).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.EdgeInsets.normal).isActive = true
            if index+1 == subText.count {
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.EdgeInsets.normal).isActive = true
            }
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: label.topAnchor, constant: label.font.pointSize/2 - 2),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.EdgeInsets.normal),
                imageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -Constant.Size.EdgeInsets.small),
                imageView.heightAnchor.constraint(equalToConstant: Constant.Size.imagePointSize),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
        }
    }
    
    func addTextView(text: String) {
        let label = NormalLabel()
        let view = UIView()
        addArrangedSubview(view)
        view.addSubview(label)
        label.text = text
        addView(view: view, subView: label)
    }

    func setupHeader(title: String) {
        let header = HeaderView()
        header.setupText(name: title)
        addArrangedSubview(header)
    }
    
    func setupTextView(text: String) {
        let view = UIView()
        let label = NormalLabel()
        label.text = text
        addView(view: view, subView: label)
        addArrangedSubview(view)
    }
    
}

extension UIView {
    
    func addView(top: CGFloat = Constant.Size.EdgeInsets.small,
                 bottom: CGFloat = Constant.Size.EdgeInsets.small,
                 leading: CGFloat = Constant.Size.EdgeInsets.normal,
                 trailing: CGFloat = Constant.Size.EdgeInsets.normal,
                 view: UIView, subView:
                    UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subView)
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailing),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom)
        ])
    }
}
