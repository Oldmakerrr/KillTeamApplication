//
//  PloyView.swift
//  KillTeamApplication
//
//  Created by Apple on 10.04.2022.
//

import Foundation
import UIKit

protocol PloyViewDelegate: AnyObject {
    func didComplete(_ view: PloyView)
}

class PloyView: UIStackView {
    
    weak var delegate: PloyViewDelegate?
    
    let weaponView = WeaponView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction() {
        delegate?.didComplete(self)
    }
    
    func setupPloy(ploy: Ploy, image: UIImage? = nil, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        setupHeader(name: ploy.name, cost: ploy.cost, image: image)
        setupDescription(description: ploy.description)
        
        if let subText = ploy.subTexts {
            addSubTextPointView(subText: subText)
        }
        
        if let postText = ploy.postSubText {
            setupDescription(description: postText)
        }
        
        if let abilitie = ploy.ability {
            setupAbilitiesView(abilities: abilitie)
        }
        
        if let action = ploy.uniqueAction {
            setupUniqueAction(action: action, delegate: delegate, viewWidth: viewWidth)
        }
        
        if let weapon = ploy.weapon {
            setupWeponView(weapon: weapon, viewWidth: viewWidth, delegate: delegate)
        }
    }
    
    func setupView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constant.Size.EdgeInsets.normal).isActive = true
        addArrangedSubview(view)
    }
    
    private func setupWeponView(weapon: Weapon, viewWidth: CGFloat, delegate: WeaponRuleButtonDelegate) {
        let backgroundView = UIView()
    
        addView(view: backgroundView, subView: weaponView)
        addArrangedSubview(backgroundView)
        weaponView.setupText(wargear: weapon, delegate: delegate, viewWidth: viewWidth)
        weaponView.layer.applyBorder()
    }
    
    private func setupUniqueAction(action: UnitUniqueAction, delegate: WeaponRuleButtonDelegate, viewWidth: CGFloat) {
        let backgroundView = UIView()
        let view = UniqueActionView()
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        addView(view: backgroundView, subView: view)
        view.layer.applyBorder()
        view.setupText(action: action, delegate: delegate, viewWidth: viewWidth)
        addArrangedSubview(backgroundView)
    }
    
    private func setupAbilitiesView(abilities: UnitAbilitie) {
        let view = AbilitieView()
        view.setupText(abilitie: abilities)
        addArrangedSubview(view)
    }
    
    private func setupDescription(description: String) {
        let view = UIView()
        let label = NormalLabel()
        label.text = description
        addView(view: view, subView: label)
        addArrangedSubview(view)
    }
    
    private func setupHeader(name: String, cost: Int, image: UIImage?) {
        let header = HeaderImageView()
        header.setupText(name: name, cost: "\(cost) CP", image: image)
        header.imageView.image = image?.withRenderingMode(.alwaysTemplate)
        header.imageView.tintColor = .black
        addArrangedSubview(header)
    }
    
    func setupButton(delegate: PloyViewDelegate) {
        let view = UIView()
        let button = DoneButton()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.delegate = delegate
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.EdgeInsets.normal),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.EdgeInsets.normal),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: Constant.Size.NormalButton.width),
            button.heightAnchor.constraint(equalToConstant: Constant.Size.NormalButton.height)
        ])
        addArrangedSubview(view)
    }
    
    private func configure() {
        backgroundColor = ColorScheme.shared.theme.viewBackground
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
    }
}

extension UIView {
    
    func addArrayLabels(subTexts: [String]) -> UIView {
        let view = UIView()
        var arrayLabels = [UILabel]()
        for (index, text) in subTexts.enumerated() {
            let label = NormalLabel()
            arrayLabels.append(label)
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.text = text
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.EdgeInsets.large),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.EdgeInsets.normal)
            ])
            if index == 0 {
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: arrayLabels[index-1].bottomAnchor, constant: Constant.Size.EdgeInsets.normal).isActive = true
            }
            if index+1 == subTexts.count {
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.EdgeInsets.normal).isActive = true
            }
            
        }
        
        return view
    }
}
