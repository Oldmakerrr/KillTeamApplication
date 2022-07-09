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
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.clearNavigationBar()
        coachMarksController.stop(immediately: true)
    }
    
    private func configure() {
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.register(AddFireTeamCell.self, forCellReuseIdentifier: AddFireTeamCell.identifier)
        setupViewsOnNavigationBar()
        tableView.delegate = presenter as? UITableViewDelegate
        tableView.dataSource = presenter as? UITableViewDataSource
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self

    }
    
    private func setupViewsOnNavigationBar() {
        maxCountFIreTeamLabel.textColor = .white
        maxCountFIreTeamLabel.text = "Max FT: \(presenter?.model.killTeam?.countOfFireTeam ?? 0)"
        setupRightNavigationView(view: maxCountFIreTeamLabel)
    }
    
    private func showCoachMarks() {
        if !isCoachMarkShowed() {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }

    
}
