//
//  RosterTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 12.04.2022.
//

import Foundation
import UIKit

class RosterTableViewCell: EditKillTeamCell {
    
    static let identifier = "RosterTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addNameLabel(unit: Unit) -> UIView {
        let header = HeaderViewWithImage()
        if let currentWounds = unit.currentWounds {
            header.setupText(name: unit.name, cost: "W = \(currentWounds)")
             if currentWounds == 0 {
                changeBackgroundAlpha()
                let image = UIImage(named: "Skull")
                header.setupImage(image: image)
             } else if currentWounds < sdf(int: unit.wounds) {
                let image = UIImage(named: "Damage")
                header.setupImage(image: image)
            }
         }
        return header
    }
    
    func sdf(int: Int) -> Int {
        var int = int
        if int % 2 != 0 {
            int += 1
            int /= 2
            return int
        }
        return int/2
    }
    
    func setupInjuredImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Damage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
}

class HeaderViewWithImage: UIView {
    
    let costLabel = HeaderLabel()
    let nameLabel = HeaderLabel()
    let imageView = UIImageView()
    
    
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
        costLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
        costLabel.adjustsFontSizeToFitWidth = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupImage(image: UIImage?) {
        imageView.image = image
    }
    
    func setupText(name: String, cost: String) {
        nameLabel.text = name
        costLabel.text = cost
    }
    
    
    private func setupLabel() {
        addSubview(nameLabel)
        addSubview(costLabel)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            costLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.large),
            costLabel.leadingAnchor.constraint(greaterThanOrEqualTo: imageView.trailingAnchor, constant: Constant.Size.Otstup.small),
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.large)
        ])
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: costLabel.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constant.Font.sizeHeaderFont),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.7),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: costLabel.leadingAnchor, constant: -Constant.Size.Otstup.small),
            imageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: Constant.Size.Otstup.small),
            
        ])
    }
    
}
