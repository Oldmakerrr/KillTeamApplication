//
//  ExtensionAddFireTeamVC.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

extension AddFireTeamTableVC {

    func createBarlabel() {
        maxCountFIreTeamLabel.text = "Max count of FireTeam = \(presenter?.maxCountOfFireTeam ?? 0)"
        maxCountFIreTeamLabel.frame = CGRect(x: 200, y: 10, width: 0, height: 20)
        maxCountFIreTeamLabel.sizeToFit()
        navigationController?.navigationBar.addSubview(maxCountFIreTeamLabel)
    }

}

