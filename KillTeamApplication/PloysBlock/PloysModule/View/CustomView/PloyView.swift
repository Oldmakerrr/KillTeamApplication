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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction() {
        delegate?.didComplete(self)
    }
    
    func setupPloy(ploy: Ploy, delegate: WeaponRuleButtonDelegate) {
        setupHeader(name: ploy.name, cost: ploy.cost)
        setupDescription(description: ploy.description)
        
        if let subText = ploy.subText {
            addSubTextPointView(subText: subText)
        }
        
        if let abilitie = ploy.passiveAbilities {
            setupAbilitiesView(abilities: abilitie)
        }
        
        if let action = ploy.abilities {
            setupUniqueAction(action: action, delegate: delegate)
        }
        
        if let weapon = ploy.wargear {
            setupWeponView(weapon: weapon)
        }
    }
    
    func setupView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constant.Size.Otstup.normal).isActive = true
        addArrangedSubview(view)
    }
    
    private func setupWeponView(weapon: Weapon) {
        let backgroundView = UIView()
        let view = WeaponView()
        addView(view: backgroundView, subView: view)
        view.setupText(wargear: weapon, delegate: nil)
        view.layer.applyBorder()
        addArrangedSubview(backgroundView)
    }
    
    private func setupUniqueAction(action: UnitUniqueAction, delegate: WeaponRuleButtonDelegate) {
        let backgroundView = UIView()
        //let view = UnitUniqueAtionView()
        let view = UniqueActionView()
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        addView(view: backgroundView, subView: view)
        view.layer.applyBorder()
        view.setupText(action: action, delegate: delegate)
        addArrangedSubview(backgroundView)
    }
    
    private func setupAbilitiesView(abilities: UnitAbilitie) {
        let view = AbilitieView()
        view.setupText(abilitie: abilities)
        addArrangedSubview(view)
    }
    
  //  private func setupSubText(subText: [String]) {
  //      let view = addArrayLabels(subTexts: subText)
  //      addArrangedSubview(view)
  //  }
    
    private func setupDescription(description: String) {
        let view = UIView()
        let label = NormalLabel()
        label.text = description
        addView(view: view, subView: label)
        addArrangedSubview(view)
    }
    
    private func setupHeader(name: String, cost: Int) {
        let header = HeaderIntView()
        header.setupText(name: name, cost: "\(cost) CP")
        addArrangedSubview(header)
    }
    
    func setupButton(delegate: PloyViewDelegate) {
        let view = UIView()
        let button = DoneButton()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.delegate = delegate
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.Otstup.normal),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.Otstup.normal),
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
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.Otstup.large),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.Otstup.normal)
            ])
            if index == 0 {
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Size.Otstup.normal).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: arrayLabels[index-1].bottomAnchor, constant: Constant.Size.Otstup.normal).isActive = true
            }
            if index+1 == subTexts.count {
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.Otstup.normal).isActive = true
            }
            
        }
        
        return view
    }
}
