//
//  ChooseKillTeamTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class ChooseKillTeamTableViewCell: UITableViewCell {
    
    static let identifier = "ChooseKillTeamTableViewCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let subNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Avenir", size: 16)
        return label
    }()
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupText(killTeam: KillTeam) {
        nameLabel.text = killTeam.killTeamName
        subNameLabel.text = killTeam.factionName
        logoImage.image = UIImage(named: killTeam.factionLogo)
    }
    
    private func setupView() {
        contentView.addSubview(logoImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(subNameLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 40),
            logoImage.widthAnchor.constraint(equalToConstant: 40),
            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: logoImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            subNameLabel.bottomAnchor.constraint(equalTo: logoImage.bottomAnchor),
            subNameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 10)
        ])
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
