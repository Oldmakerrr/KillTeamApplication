//
//  RosterTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Instructions

class RosterTableViewController: UITableViewController, RosterTableViewControllerProtocol {
    
    var presenter: RosterPresenterProtocol?
    
    let coachMarksController = CoachMarksController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.register(RosterTableViewCell.self, forCellReuseIdentifier: RosterTableViewCell.identifier)
        
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        checkEmptyStateTableView()
        navigationItem.title = presenter?.model.killTeam?.userCustomName ?? presenter?.model.killTeam?.factionName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coachMarksController.stop(immediately: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
    }
    
    
    private func showCoachMarks() {
        guard let killTeam = presenter?.model.killTeam else { return }
        if !isCoachMarkShowed() && !killTeam.choosenFireTeam.isEmpty {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }
    
    
    private func checkEmptyStateTableView() {
        restore()
        guard let killTeam = presenter?.model.killTeam else {
            setEmptyState(title: "No Kill Team",
                          message: "Please create new Kill Team or choose existed on the main screen")
            return
        }
        if killTeam.choosenFireTeam.count == 0 {
            setEmptyState(title: "No Fire Team",
                          message: "Please add and edit Fire Team on the Edit Kill Team screen")
        } 
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        view.label.text = presenter?.model.killTeam?.choosenFireTeam[section].name
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Size.headerHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam[section].currentDataslates.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RosterTableViewCell.identifier, for: indexPath) as! RosterTableViewCell
        guard let unit = presenter?.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]  else { return UITableViewCell() }
        cell.updateCell()
        cell.setupText(unit: unit)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToMoreInfoUnit(indexPath: indexPath)
        
    }
}

