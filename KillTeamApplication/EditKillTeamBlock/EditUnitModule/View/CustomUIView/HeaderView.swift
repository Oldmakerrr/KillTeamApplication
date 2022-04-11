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
    let costLabel = HeaderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.cellHeader
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
        costLabel.numberOfLines = 1
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "BallisticSkill")
        return imageView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(name: String, cost: String?) {
        addSubview(costLabel)
        addSubview(nameLabel)
        
        nameLabel.text = name
        costLabel.text = cost ?? ""
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            costLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            costLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            //costLabel.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: costLabel.leadingAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
    }
}

