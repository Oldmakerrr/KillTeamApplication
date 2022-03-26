//
//  CurrentKillTeamView.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class CurrentKillTeamView: UIView {
    
    let nameLabel = UILabel()
    let killTeamLogo = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        settingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setupImageView()
        setupLabel()
    }
    
    private func settingView() {
        backgroundColor = .systemGray2
        layer.masksToBounds = true
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: killTeamLogo.trailingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        nameLabel.textAlignment = .center
        nameLabel.text = "Choose Kill Team"
    }
    
    private func setupImageView() {
        addSubview(killTeamLogo)
        killTeamLogo.layer.masksToBounds = true
        killTeamLogo.image = UIImage(named: "KILL_TEAM")
        killTeamLogo.translatesAutoresizingMaskIntoConstraints = false
        killTeamLogo.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        killTeamLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        killTeamLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        killTeamLogo.widthAnchor.constraint(equalToConstant: 80).isActive = true
        killTeamLogo.contentMode = .scaleAspectFit
        killTeamLogo.layer.cornerRadius = 40
        killTeamLogo.backgroundColor = .orange
        killTeamLogo.layer.borderWidth = 1
    }
}
