//
//  CurrentKillTeamView.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol CurrentKillTeamViewDelegate: AnyObject {
    func didComplete(_ currentKillTeamView: CurrentKillTeamView)
}

class CurrentKillTeamView: UIView {
    
    weak var delegate: CurrentKillTeamViewDelegate?
    
    let nameLabel = HeaderLabel()
    let factionNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorScheme.shared.theme.textNormal
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let killTeamLogo = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapAction() {
        delegate?.didComplete(self)
    }
    
    func setupText(killTeam: KillTeam?) {
        DispatchQueue.main.async {
            self.killTeamLogo.image = UIImage(named: killTeam?.factionLogo ?? "KILL_TEAM")
        }
        if let customName = killTeam?.userCustomName {
            nameLabel.text = customName
            factionNameLabel.text = killTeam?.killTeamName
        } else {
            nameLabel.text = killTeam?.killTeamName ?? "Choose Kill Team"
            factionNameLabel.text = killTeam?.factionName ?? ""
        }
    }
    
    private func configure() {
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.viewBackground
        layer.applySketchShadow()
        layer.applyCornerRadius()
        alpha = 0.8
    }
    
    private func setupView() {
        setupImageView()
        setupLabel()
    }
    
    private func setupLabel() {
        addSubview(nameLabel)
        addSubview(factionNameLabel)
        nameLabel.text = "Choose Kill Team"
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: killTeamLogo.trailingAnchor, constant: Constant.Size.screenWidth * 0.036),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.screenWidth * 0.036),
            nameLabel.topAnchor.constraint(equalTo: killTeamLogo.topAnchor, constant: Constant.Size.screenHeight * 0.013),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: killTeamLogo.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            factionNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            factionNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            factionNameLabel.bottomAnchor.constraint(equalTo: killTeamLogo.bottomAnchor, constant: -Constant.Size.screenHeight * 0.013),
            factionNameLabel.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor)
        ])
    }
    
    private func setupImageView() {
        addSubview(killTeamLogo)
        killTeamLogo.layer.applyBorder()
        killTeamLogo.contentMode = .scaleAspectFit
        killTeamLogo.backgroundColor = ColorScheme.shared.theme.subViewBackground
        killTeamLogo.image = UIImage(named: "KILL_TEAM")
        killTeamLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            killTeamLogo.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: Constant.Size.Otstup.normal),
            killTeamLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.Otstup.normal),
            killTeamLogo.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constant.Size.Otstup.normal),
            killTeamLogo.widthAnchor.constraint(equalTo: killTeamLogo.heightAnchor),
            killTeamLogo.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    
}
