//
//  ExtensionAddFireTeamVC.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

extension AddFireTeamViewController {

    func setupMaxCountFIreTeamLabel() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        maxCountFIreTeamLabel.text = "Max FT: \(presenter?.model.killTeam?.countOfFireTeam ?? 0)"
        maxCountFIreTeamLabel.textColor = .white
        navigationBar.addSubview(maxCountFIreTeamLabel)
        NSLayoutConstraint.activate([
            maxCountFIreTeamLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            maxCountFIreTeamLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -Constant.Size.Otstup.large)
        ])
    }

}

