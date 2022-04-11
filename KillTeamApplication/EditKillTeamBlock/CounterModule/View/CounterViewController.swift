//
//  CounterViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class CounterViewController: UIViewController, CounterViewProtocol {
    
    var presenter: CounterPresenterProtocol?
    
    let customAlert = CustomAlert()
    let currentKillTeamView = CurrentKillTeamView()
    
    let addKillTeamButton = AddButton()
    let currentStrategicPloyLabel = UILabel()
    let currentStrategicPloyButton = UIButton()

    let turningPointLabel = CounterLabel()
    let commandPointLabel = CounterLabel()
    let victoryPointLabel = CounterLabel()
    
    let plusCommandPoint = ChangePointButton()
    let minusCommandPoint = ChangePointButton()
    let plusVictoryPoint = ChangePointButton()
    let minusVictoryPoint = ChangePointButton()
    
    let nextTurnButton = ChangeTurnButton()
    let endGameButton = ChangeTurnButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupSubView()
        
        setupCurrentStrategicPloyLabel()
        setupCurrentStrategicPloyButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        if let killTeam = presenter?.model.killTeam {
            currentKillTeamView.setupText(killTeam: killTeam)
        }
    }
    
    @objc func pressCurrentStrategicPloyButton() {
        guard let ploy = presenter?.model.gameData.currentStrategicPloy else { return }
        let view = PloyView()
        view.setupPloy(ploy: ploy)
        view.setupButton(delegate: self)
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
        customAlert.showAlert(alertView: view, targetView: self)
    }
    
    @objc func dismissAlert() {
        customAlert.dismissAlert()
    }
    
    @objc func addKillTeam() {
        presenter?.addKillTeam()
    }
    
    @objc func buttonAction(sender: UIButton) {
        if let presenter = presenter {
            presenter.buttonAction(sender: sender)
        }
    }
    
    @objc func showChooseKillTeamTableViewController() {
        presenter?.showChooseKillTeamTableViewController()
    }
    
}


