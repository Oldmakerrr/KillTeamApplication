//
//  EditKillTeamTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Instructions

class EditKillTeamTableViewController: UITableViewController, EditKillTeamProtocol {
    
    let coachMarksController = CoachMarksController()
    
    var presenter: EditKillTeamPresenterProtocol?
    
    let addUnitOrFireTeamButton = AddButton()
    let customTitleView = LabelWithImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        checkTableViewState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        addUnitOrFireTeamButton.removeFromSuperview()
        coachMarksController.stop(immediately: true)
    }
    
    private func configure() {
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        navigationController?.navigationBar.isHidden = false
        tableView.register(EditKillTeamCell.self, forCellReuseIdentifier: EditKillTeamCell.identifier)
        setupTitleView(name: presenter?.model.killTeam?.userCustomName ?? presenter?.model.killTeam?.killTeamName)
        addGestureToTitleView()
        tableView.delegate = presenter as? UITableViewDelegate
        tableView.dataSource = presenter as? UITableViewDataSource
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }

}
