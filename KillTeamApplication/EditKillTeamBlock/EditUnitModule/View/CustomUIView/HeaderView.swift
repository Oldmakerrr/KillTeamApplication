//
//  HeaderView.swift
//  KillTeamApplication
//
//  Created by Apple on 23.03.2022.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    var fontSize: CGFloat = 24
    let nameLabel = UILabel()
    let costLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .orange
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
        addSubview(nameLabel)
        addSubview(costLabel)
      //  addSubview(imageView)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        nameLabel.text = name
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: costLabel.leadingAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        costLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        costLabel.text = cost ?? ""
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        
   //     NSLayoutConstraint.activate([
   //         imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
   //         imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
   //         imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
   //         imageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -5)
   //     ])
    }
}

