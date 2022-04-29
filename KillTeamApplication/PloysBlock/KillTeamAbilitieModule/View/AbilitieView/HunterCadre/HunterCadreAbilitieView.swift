//
//  HunterCadreAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class HunterCadreAbilitieView: KillTeamAbilitieView {
    
    func setupDroneRule(abilitie: HunterCadreAbilitie) {
        setupHeader(title: abilitie.title)
        let rule = abilitie.rule
        addTextView(text: rule.text)
        addSubTextPointView(subText: rule.dronesList)
        addTextView(text: rule.postText)
    }
    
    func setupUniqueAction(action: HunterCadreAbilitie.UniqueAction) {
        let backgroundView = UIView()
        let contentView = UIStackView()
        backgroundView.addView(view: backgroundView, subView: contentView)
        contentView.axis = .vertical
        contentView.layer.applyBorder()
        let header = HeaderIntView()
        header.costLabel.text = "\(action.cost) AP"
        header.nameLabel.text = action.name
        contentView.addArrangedSubview(header)
        action.description.forEach { text in
            let view = UIView()
            let label = NormalLabel()
            label.text = text
            view.addView(view: view, subView: label)
            contentView.addArrangedSubview(view)
        }
        addArrangedSubview(backgroundView)
        
    }
    
    func setupAbiliteRule(abilitie: HunterCadreAbilitie.Abilitie) {
        setupHeader(title: abilitie.name)
        if let subText = abilitie.subText {
            addSubTextPointView(subText: subText)
        }
        if let text = abilitie.text {
            text.forEach { rule in
                setupTextView(text: rule)
            }
        }
        if abilitie.name == "ARTIFICIAL INTELLIGENCE" {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "HunterCadreDrone")
            addArrangedSubview(imageView)
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 10).isActive = true
            addArrangedSubview(view)
        }
    }
}
