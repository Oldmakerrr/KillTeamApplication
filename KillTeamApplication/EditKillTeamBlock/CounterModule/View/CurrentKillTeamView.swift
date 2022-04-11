//
//  CurrentKillTeamView.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class CurrentKillTeamView: UIView {
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(killTeam: KillTeam) {
        DispatchQueue.main.async {
            self.killTeamLogo.image = UIImage(named: killTeam.factionLogo)
        }
        if let customName = killTeam.userCustomName {
            nameLabel.text = customName
            factionNameLabel.text = killTeam.killTeamName            
        } else {
            nameLabel.text = killTeam.killTeamName
            factionNameLabel.text = killTeam.factionName
        }
    }
    
    private func configure() {
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.viewBackground
        layer.applySketchShadow()
        layer.applyCornerRadius()
        
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
            nameLabel.topAnchor.constraint(equalTo: killTeamLogo.topAnchor, constant: Constant.Size.screenHeight * 0.012),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: killTeamLogo.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            factionNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            factionNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            factionNameLabel.bottomAnchor.constraint(equalTo: killTeamLogo.bottomAnchor, constant: -Constant.Size.screenHeight * 0.012),
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
            killTeamLogo.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 15),
            killTeamLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            killTeamLogo.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -15),
            killTeamLogo.widthAnchor.constraint(equalTo: killTeamLogo.heightAnchor),
            killTeamLogo.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    
}

extension CALayer {
    
    func applyBorder(widht: CGFloat = Constant.Size.borderWidht,
                     color: CGColor = ColorScheme.shared.theme.cellBorder.cgColor) {
        
        borderWidth = widht
        borderColor = color
    }
    
    func applyCornerRadius(radius: CGFloat = Constant.Size.cornerRadius) {
        masksToBounds = false
        cornerRadius = radius
    }
    
    func applyCornerRadiusRound(view: UIView) {
        layoutIfNeeded()
        let widthView = view.frame.size.width
        masksToBounds = false
        cornerRadius = widthView/2
    }
    
    func applySketchShadow(
        color: UIColor = ColorScheme.shared.theme.shadow,
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = 1,
        blur: CGFloat = 4
    )
    {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        // if spread == 0 {
        //   shadowPath = nil
        // } else {
        //   let dx = -spread
        //   let rect = bounds.insetBy(dx: dx, dy: dx)
        //   shadowPath = UIBezierPath(rect: rect).cgPath
        // }
    }
}
