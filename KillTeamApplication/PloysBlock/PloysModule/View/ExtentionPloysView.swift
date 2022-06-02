//
//  ExtentionPloysView.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

extension PloysViewController {
    
    func showCoachMarks() {
        guard let killTeam = presenter?.model.killTeam else { return }
        if !isCoachMarkShowed() && !killTeam.choosenFireTeam.isEmpty {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PloysTableViewCell.self, forCellReuseIdentifier: PloysTableViewCell.identifier)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
