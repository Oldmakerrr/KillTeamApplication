//
//  CounterViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class CounterViewController: UIViewController, CounterViewProtocol {
    
    var customAlert: CustomAlert?

    var presenter: CounterPresenterProtocol?
    let currentKillTeamView = CurrentKillTeamView()
    let addKillTeamButton = UIButton()
    
    let currentStrategicPloyLabel = UILabel()
    let currentStrategicPloyButton = UIButton()

    lazy var turningPointLabel = createTurningPointLabel()
    lazy var commandPointLabel = createCommandPointLabel()
    lazy var victoryPointLabel = createVictoryPointLabel()
 
    lazy var plusCommandPoint = createPluseButtonCommandPoint()
    lazy var minusCommandPoint = createMinusButtonCommandPoint()
    lazy var plusVictoryPoint = createPluseButtonVictoryPoint()
    lazy var minusVictoryPoint = createMinusButtonVictoryPoint()
    lazy var nextTurnButton = createNextTurnButton()
    lazy var endGameButton = createEndGameButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        navigationController?.navigationBar.isHidden = true
        setupCurrentKillTeamView()
        setupButtonAddKillTeam()
        
        setLable()
        setupCurrentStrategicPloyLabel()
        setupCurrentStrategicPloyButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadKeys()
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupCurrentKillTeamView() {
        view.addSubview(currentKillTeamView)
        currentKillTeamView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        currentKillTeamView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        currentKillTeamView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        currentKillTeamView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        currentKillTeamView.setupView()
    }
    
    func setLable() {
        turningPointLabel.isHidden = false
        commandPointLabel.isHidden = false
        victoryPointLabel.isHidden = false
        
        plusCommandPoint.isEnabled = false
        minusCommandPoint.isEnabled = false
        plusVictoryPoint.isEnabled = false
        minusVictoryPoint.isEnabled = false
        nextTurnButton.isHidden = false
        endGameButton.isHidden = true
    }
    
    @objc func pressCurrentStrategicPloyButton() {
        if let ploy = presenter?.model.gameData.currentStrategicPloy {
            let moreInfoPloyView = PloyMoreInfoView()
            moreInfoPloyView.button.addTarget(self, action: #selector(hideAlertVew), for: .touchUpInside)
            customAlert = CustomAlert(alertView: moreInfoPloyView, targetView: self.view)
            customAlert?.showAlert()
            moreInfoPloyView.setupTextPloy(ploy: ploy, view: moreInfoPloyView)
        }
    }
    
    @objc func hideAlertVew() {
        customAlert?.dismissAlert()
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


