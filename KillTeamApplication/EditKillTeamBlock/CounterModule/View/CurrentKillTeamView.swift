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
        killTeamLogo.image = UIImage(named: "empty")
        killTeamLogo.translatesAutoresizingMaskIntoConstraints = false
        killTeamLogo.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        killTeamLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        killTeamLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        killTeamLogo.widthAnchor.constraint(equalToConstant: 80).isActive = true
        killTeamLogo.layer.cornerRadius = 40
        killTeamLogo.backgroundColor = .orange
        killTeamLogo.layer.borderWidth = 1
    }
    
//MARK: - OLD
   /*
    lazy var killTeamNameLabel = createCurrentKillTeamLabel()
    lazy var chooseKillTeamButton = createChooseKillTeamButton()
    lazy var factionLogo = createLogoFaction()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        killTeamNameLabel.isHidden = false
        chooseKillTeamButton.isHidden = false
        factionLogo.isHidden = false
    }
    
    func createCurrentKillTeamLabel() -> UILabel {
        let label = UILabel()
        label.tintColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        label.leftAnchor.constraint(equalTo: factionLogo.rightAnchor, constant: 20).isActive = true
        return label
    }
    
    func createChooseKillTeamButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choose Kill Team", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        addSubview(button)
        button.topAnchor.constraint(equalTo: killTeamNameLabel.bottomAnchor, constant: 20).isActive = true
        button.leftAnchor.constraint(equalTo: factionLogo.rightAnchor, constant: 20).isActive = true
        return button
    }
    
    func createLogoFaction() -> UIImageView {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.backgroundColor = UIColor.gray
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }
 */
}
