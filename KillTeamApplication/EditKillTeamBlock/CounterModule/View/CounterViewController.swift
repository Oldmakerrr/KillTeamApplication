//
//  CounterViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class CounterViewController: UIViewController, CounterViewProtocol {
    
    let moreInfoPloyView = PloyMoreInfoView()
   lazy var customAlert = CustomAlert(alertView: moreInfoPloyView, targetView: view.self)

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
        setupView()
        addButton()
        moreInfoPloyView.button.addTarget(self, action: #selector(hideAlertVew), for: .touchUpInside)
        plusCommandPoint.isEnabled = false
        minusCommandPoint.isEnabled = false
        plusVictoryPoint.isEnabled = false
        minusVictoryPoint.isEnabled = false
        nextTurnButton.isHidden = false
        endGameButton.isHidden = true
        setLable()
        //setView()
        
        setupCurrentStrategicPloyLabel()
        setupCurrentStrategicPloyButton()
    }
    
    func setupView() {
        view.addSubview(currentKillTeamView)
        currentKillTeamView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        currentKillTeamView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        currentKillTeamView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        currentKillTeamView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        currentKillTeamView.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        presenter?.loadKeys()
    }
    
    func setLable() {
        turningPointLabel.isHidden = false
        commandPointLabel.isHidden = false
        victoryPointLabel.isHidden = false
    }
    
    @objc func pressCurrentStrategicPloyButton() {
        if let ploy = presenter?.model.gameData.currentStrategicPloy {
            customAlert.showAlert()
            setupTextPloy(ploy: ploy)
        }
    }
    
    @objc func hideAlertVew() {
        customAlert.dismissAlert()
    }
    
    @objc func addKillTeam() {
        if !presenter!.keysForKillTeam.isEmpty {
            let addKillTeamAlertController = UIAlertController(title: "Add Kill Team", message: "Create a new Kill Team or choose an existing.", preferredStyle: .actionSheet)
            let addNewKillTeamAlert = UIAlertAction(title: "Create", style: .default) { _ in
                self.presenter?.showChooseKillTeamTableViewController()
            }
            let chooseKillTeamAlert = UIAlertAction(title: "Choose", style: .default) { _IOLBF in
                self.presenter?.showChooseLoadedKillTeamTableViewController()
            }
            let cancleAlert = UIAlertAction(title: "Cancle", style: .cancel) { _IOLBF in
                
            }
            addKillTeamAlertController.addAction(addNewKillTeamAlert)
            addKillTeamAlertController.addAction(chooseKillTeamAlert)
            addKillTeamAlertController.addAction(cancleAlert)
            present(addKillTeamAlertController, animated: true) {
            }
        } else {
            presenter?.showChooseKillTeamTableViewController()
        }
    }
    
    /*
    func setView() {
        self.view.addSubview(currentKillTeamView)
        currentKillTeamView.chooseKillTeamButton.addTarget(self, action: #selector(showChooseKillTeamTableViewController), for: .touchUpInside)
        currentKillTeamView.killTeamNameLabel.text = "Choose your Kill Team"
        currentKillTeamView.factionLogo.image = UIImage(named: presenter?.model.killTeam?.factionLogo ?? "empty")
        currentKillTeamView.translatesAutoresizingMaskIntoConstraints = false
        currentKillTeamView.backgroundColor = UIColor.systemGray3
        currentKillTeamView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        currentKillTeamView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentKillTeamView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        currentKillTeamView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    */
    @objc func buttonAction(sender: UIButton) {
        if let presenter = presenter {
            presenter.buttonAction(sender: sender)
        }
    }
    
    @objc func showChooseKillTeamTableViewController() {
        presenter?.showChooseKillTeamTableViewController()
    }
    
}


