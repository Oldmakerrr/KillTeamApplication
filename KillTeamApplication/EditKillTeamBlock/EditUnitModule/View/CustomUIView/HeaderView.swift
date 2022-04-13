//
//  HeaderView.swift
//  KillTeamApplication
//
//  Created by Apple on 23.03.2022.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    let nameLabel = HeaderLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupLabel()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.cellHeader
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(name: String) {
        nameLabel.text = name
        
    }
    
    private func setupLabel() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.normal),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.normal)
        ])
    }
}

class HeaderViewWithInt: UIView {
    
    let costLabel = HeaderLabel()
    let nameLabel = HeaderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.cellHeader
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
        costLabel.numberOfLines = 1
        costLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupText(name: String, cost: String) {
        nameLabel.text = name
        costLabel.text = cost
    }
    
    
    private func setupLabel() {
        addSubview(nameLabel)
        addSubview(costLabel)
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            costLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.large),
            costLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(equalTo: costLabel.leadingAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.large)
        ])
    }
    
}

