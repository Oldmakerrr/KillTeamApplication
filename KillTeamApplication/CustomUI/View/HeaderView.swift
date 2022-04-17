//
//  HeaderView.swift
//  KillTeamApplication
//
//  Created by Apple on 23.03.2022.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    let nameLabel = BigLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addConstraints()
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.cellHeader
        addSubview(nameLabel)
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
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.normal),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.normal)
        ])
    }
}

class HeaderIntView: HeaderView {
    
    let costLabel = BigLabel()
    
    override func configure() {
        super.configure()
        addSubview(costLabel)
        nameLabel.textAlignment = .left
        costLabel.numberOfLines = 1
        costLabel.textAlignment = .right
    }
    
    func setupText(name: String, cost: String) {
        super.setupText(name: name)
        costLabel.text = cost
    }
    
    override func addConstraints() {
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            costLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.large),
            costLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: Constant.Size.Otstup.normal)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: costLabel.leadingAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.large)
        ])
    }
    
    
}

class HeaderImageView: HeaderIntView {
    
    let imageView = UIImageView()
    
    override func configure() {
        super.configure()
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupText(name: String, cost: String, image: UIImage?) {
        super.setupText(name: name, cost: cost)
        imageView.image = image
    }
    
    override func addConstraints() {
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            costLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.Otstup.large),
            costLabel.leadingAnchor.constraint(greaterThanOrEqualTo: imageView.trailingAnchor, constant: Constant.Size.Otstup.small),
            costLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.large),
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

/*

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
 */
 
/*

class HeaderViewWithInt: UIView {
    
    let costLabel = HeaderLabel()
    var nameLabel = HeaderLabel()
    
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
            costLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: Constant.Size.Otstup.normal)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.Size.Otstup.small),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: costLabel.leadingAnchor, constant: -Constant.Size.Otstup.small),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.large)
        ])
    }
    
}
*/
