//
//  AddFireTeamTableVC.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Instructions

class AddFireTeamViewController: UITableViewController, AddFireTeamTableVCProtocol {
    
    let coachMarksController = CoachMarksController()
    
    var presenter: AddFireTeamPresenterProtocol?
    
    var maxCountFIreTeamLabel = BoldLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.register(AddFireTeamCell.self, forCellReuseIdentifier: AddFireTeamCell.identifier)
        setupRightNavigationLabel(label: maxCountFIreTeamLabel)
        maxCountFIreTeamLabel.text = "Max FT: \(presenter?.model.killTeam?.countOfFireTeam ?? 0)"
        
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        maxCountFIreTeamLabel.removeFromSuperview()
        coachMarksController.stop(immediately: true)
    }
    
    private func showCoachMarks() {
        if !isCoachMarkShowed() {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.killTeam?.fireTeam.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddFireTeamCell.identifier, for: indexPath) as! AddFireTeamCell
        guard let fireTeam = presenter?.model.killTeam?.fireTeam[indexPath.row],
              let fireTeamCount = presenter?.model.counterFireteam[fireTeam.name] else { return UITableViewCell() }
        cell.countFireTeam = fireTeamCount
        cell.textLabel?.text = fireTeam.name
        cell.delegate = presenter as? AddFireTeamCellDelegate
        cell.fireTeam = fireTeam
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Size.cellHeight
    }
}
