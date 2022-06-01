//
//  CounterViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Instructions

class CounterViewController: UIViewController, CounterViewProtocol {
    
    let coachMarkController = CoachMarksController()
    
    var presenter: CounterPresenterProtocol?
    
    let customAlert = CustomScrollAlert()
    
    let currentKillTeamView = CurrentKillTeamView()
    
    let addKillTeamButton = AddButton()

    let turningPointLabel = CounterLabel()
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    let currentAbilitieButton: ChangeTurnButton = {
        let button = ChangeTurnButton()
        button.backgroundColor = #colorLiteral(red: 0.293800056, green: 0.2970282733, blue: 0.3509224057, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.5959115028, green: 0.5955135226, blue: 0.6286229491, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.502659142, blue: 0, alpha: 1), for: .highlighted)
        button.layer.applyCornerRadius()
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    
    let currentStrategicPloysButton: ChangeTurnButton = {
        let button = ChangeTurnButton()
        button.backgroundColor = #colorLiteral(red: 0.293800056, green: 0.2970282733, blue: 0.3509224057, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.5959115028, green: 0.5955135226, blue: 0.6286229491, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.502659142, blue: 0, alpha: 1), for: .highlighted)
        button.layer.applyCornerRadius()
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    
    let counterLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    let commandPoint = CounterPointView(title: "Command Point")
    let victoryPoint = CounterPointView(title: "Victory Point")
    var killTeamAbilitiePoint: CounterPointView?
    
    let nextTurnButton = ChangeTurnButton()
    let endGameButton = ChangeTurnButton()
    
    lazy var nextTurnButtonView = ButtonView(button: nextTurnButton, width: 100, height: 30)
    lazy var endGameButtonView = ButtonView(button: endGameButton, width: 100, height: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBackgroundImage()
        setupSubView()
        setupDelegates()
        
        coachMarkController.dataSource = self
        coachMarkController.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let presenter = presenter else { return }
        if presenter.userSettings.firstTimeLaunch {
            coachMarkController.start(in: .window(over: self))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        setupAddButton()
        fillCounterStackView()
        setupTextToAbilitieView()
        currentPloysViewState()
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addKillTeamButton.removeFromSuperview()
    }
    
    func showAlert(ploy: Ploy) {
        let view = PloyView()
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
        customAlert.showAlert(alertView: view, targetViewController: self)
        view.setupPloy(ploy: ploy, delegate: self, viewWidth: view.weaponView.getViewWidth())
        view.setupButton(delegate: self)
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
    
}

extension CounterViewController: WeaponRuleButtonDelegate {
    
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
    
}

