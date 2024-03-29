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
    
    let nameLabel: HeaderLabel = {
        let label = HeaderLabel()
        label.text = "Choose a Kill Team"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: Constant.Size.screenHeight * 0.03)
        label.numberOfLines = 1
        return label
    }()
    
    let factionNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorScheme.shared.theme.textNormal
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constant.Size.screenHeight * 0.03)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let killTeamLogo = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction() {
        animateSelectView(scale: 0.98, completion: { _ in
            self.delegate?.didComplete(self)
        })
    }
    
    func setupText(killTeam: KillTeam?) {
        DispatchQueue.main.async {
            self.killTeamLogo.image = UIImage(named: killTeam?.factionLogo ?? "KILL_TEAM")
        }
        if let customName = killTeam?.userCustomName {
            nameLabel.text = customName
            factionNameLabel.text = killTeam?.killTeamName
        } else {
            nameLabel.text = killTeam?.killTeamName ?? "Choose a Kill Team"
            factionNameLabel.text = killTeam?.factionName ?? ""
        }
    }
    
    private func configure() {
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.viewBackground
        layer.applySketchShadow()
        layer.applyCornerRadius()
        alpha = 0.1
    }
    
    private func setupView() {
        setupImageView()
        setupLabel()
    }
    
    private func setupLabel() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, factionNameLabel])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: killTeamLogo.trailingAnchor, constant: Constant.Size.screenWidth * 0.036),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Size.screenWidth * 0.036),
            stackView.topAnchor.constraint(equalTo: killTeamLogo.topAnchor, constant: Constant.Size.screenHeight * 0.0075),
            stackView.bottomAnchor.constraint(equalTo: killTeamLogo.bottomAnchor, constant: -Constant.Size.screenHeight * 0.0075)
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
            killTeamLogo.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: Constant.Size.EdgeInsets.normal),
            killTeamLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Size.EdgeInsets.normal),
            killTeamLogo.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constant.Size.EdgeInsets.normal),
            killTeamLogo.widthAnchor.constraint(equalTo: killTeamLogo.heightAnchor),
            killTeamLogo.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
