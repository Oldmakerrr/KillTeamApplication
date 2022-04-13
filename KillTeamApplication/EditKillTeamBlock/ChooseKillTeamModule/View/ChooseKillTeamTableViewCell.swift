//
//  ChooseKillTeamTableViewCell.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class ChooseKillTeamTableViewCell: UITableViewCell {
    
    
    static let identifier = "ChooseKillTeamTableViewCell"
    
    private let nameLabel = NormalLabel()
    
    private let subNameLabel = NormalLabel()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupText(killTeam: KillTeam) {
        if let customName = killTeam.userCustomName {
            nameLabel.text = customName
            subNameLabel.text = killTeam.killTeamName
            DispatchQueue.main.async {
                self.logoImage.image = UIImage(named: killTeam.factionLogo)
            }
        } else {
            nameLabel.text = killTeam.killTeamName
            subNameLabel.text = killTeam.factionName
            DispatchQueue.main.async {
                self.logoImage.image = UIImage(named: killTeam.factionLogo)
            }
        }
    }
    
    private func setupView() {
        contentView.addSubview(logoImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(subNameLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: Constant.Size.LogoImage.height),
            logoImage.widthAnchor.constraint(equalToConstant: Constant.Size.LogoImage.width),
            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.Size.Otstup.normal)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: logoImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: Constant.Size.Otstup.normal)
        ])
        
        NSLayoutConstraint.activate([
            subNameLabel.bottomAnchor.constraint(equalTo: logoImage.bottomAnchor),
            subNameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: Constant.Size.Otstup.normal)
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

enum KillTeamTableViewCell: String {
    case ChooseKillTeamTableViewCell
    case ChooseLoadedKillTeamCell
}
