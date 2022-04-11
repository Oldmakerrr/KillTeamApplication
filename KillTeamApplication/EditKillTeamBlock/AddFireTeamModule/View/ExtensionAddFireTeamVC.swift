//
//  ExtensionAddFireTeamVC.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

extension AddFireTeamTableVC {

    func setupMaxCountFIreTeamLabel() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        maxCountFIreTeamLabel.text = "Max count of FireTeam = \(presenter?.model.maxCountOfFireTeam ?? 0)"
        navigationBar.addSubview(maxCountFIreTeamLabel)
        NSLayoutConstraint.activate([
            maxCountFIreTeamLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            maxCountFIreTeamLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -20)
        ])
    }

}

