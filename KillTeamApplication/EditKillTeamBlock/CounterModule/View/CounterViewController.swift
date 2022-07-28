//
//  CounterViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Instructions

class CounterViewController: UIViewController, CounterViewProtocol {
    
    let coachMarksController = CoachMarksController()
    
    var presenter: CounterPresenterProtocol?
    
    let customAlert = CustomScrollAlert()
    
    let currentKillTeamView = CurrentKillTeamView()
    
    let addKillTeamButton = AddButton()

    let turningPointLabel = CounterLabel()
    
    let currentAbilitieButton: ChangeTurnButton = {
        let button = ChangeTurnButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    
    let currentStrategicPloysButton: ChangeTurnButton = {
        let button = ChangeTurnButton()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBackgroundImage()
        setupSubView()
        setupDelegates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
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
        coachMarksController.stop(immediately: true)
    }
    
    func showAlert(ploy: Ploy) {
        addKillTeamButton.isEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.addKillTeamButton.alpha = 0.3
        }
        let view = PloyView()
        view.layer.applyCornerRadius()
        view.layer.masksToBounds = true
        customAlert.showAlert(alertView: view, targetViewController: self)
        view.setupPloy(ploy: ploy, delegate: self, viewWidth: view.weaponView.getViewWidth())
        view.setupButton(delegate: self)
    }
    
    @objc func dismissAlert() {
        addKillTeamButton.isEnabled = true
        UIView.animate(withDuration: 0.4) {
            self.addKillTeamButton.alpha = 1
        }
        customAlert.dismissAlert()
    }
    
    @objc func addKillTeam() {
        addKillTeamButton.animateSelectView(scale: 0.9) { _ in
            self.presenter?.addKillTeam()
        }
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

extension CounterViewController: CustomScrollAlertDelegate {
    func didComplete(_ customScrollAlert: CustomScrollAlert) {
        dismissAlert()
    }
}
