//
//  Imperative.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class ImperativeView: UIView {
    
    let nameLabel = BigLabel()
    let optimisationLabel = BoldTextLabel()
    let deprecationLabel = BoldTextLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLabel.textAlignment = .center
        addConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImerative(imperative: HunterCladeAbilitie.Imperative) {
        nameLabel.text = imperative.name
        optimisationLabel.addText(bold: "Optimisation", normal: imperative.optimisation)
        deprecationLabel.addText(bold: "Deprecation", normal: imperative.deprecation)
    }
    
    private func addConstraints() {
        addSubview(nameLabel)
        addSubview(optimisationLabel)
        addSubview(deprecationLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constant.Size.Otstup.small)
        ])
        NSLayoutConstraint.activate([
            optimisationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constant.Size.Otstup.small),
            optimisationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.small),
            optimisationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.small),
            optimisationLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constant.Size.Otstup.small)
        ])
        NSLayoutConstraint.activate([
            deprecationLabel.topAnchor.constraint(equalTo: optimisationLabel.bottomAnchor, constant: Constant.Size.Otstup.small),
            deprecationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.small),
            deprecationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.small),
            deprecationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small)
        ])
    }
}
