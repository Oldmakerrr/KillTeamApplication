//
//  ExtentionCounter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

extension CounterViewController {
    
    func showCoachMarks() {
        if !isCoachMarkShowed() {
            coachMarksController.start(in: .window(over: self))
            setCoachMarkStateToShowed()
        }
    }
    
    func currentPloysViewState() {
        guard let ploys = presenter?.model.gameData.currentStrategicPloys else { return }
        if ploys.isEmpty {
            currentStrategicPloysButton.isHidden = true
        } else {
            currentStrategicPloysButton.isHidden = false
        }
        if ploys.count == 1 {
            currentStrategicPloysButton.setTitle(ploys.first?.name ?? "Current Strategic Ploys", for: .normal)

        } else {
            currentStrategicPloysButton.setTitle("Current Strategic Ploys", for: .normal)
        }
    }
    
    func alertCurrentPloys(ploys: [Ploy]) {
        let alert = UIAlertController(title: "Current Strategic Ploys",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        ploys.forEach { ploy in
            let action = UIAlertAction(title: ploy.name, style: .default) { _ in
                self.showAlert(ploy: ploy)
            }
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
        
//MARK: - ConfigureAbilitieView
    
    func setupTextToAbilitieView() {
        guard let abilitie = presenter?.model.killTeam?.abilityOfKillTeam else {
            currentAbilitieButton.isHidden = true
            return }
        
        if abilitie is HunterCladeAbilitie {
            if let currentAbilitie = presenter?.model.gameData.currentAbilitie {
                setupTextToAbilitieView(title: currentAbilitie)
                return
            } else {
                setupTextToAbilitieView(title: "Choose Imperative")
                return
            }
        }
        
        if abilitie is VoidDancerTroupeAbilitie {
            if let currentAbilitie = presenter?.model.gameData.currentAbilitie {
                let title = "Choosen Allegory: \(currentAbilitie)"
                setupTextToAbilitieView(title: title)
                return
            } else {
                setupTextToAbilitieView(title: "Choose Allegory")
                return
            }
        }
        currentAbilitieButton.isHidden = true
    }
    
    private func setupTextToAbilitieView(title: String) {
        currentAbilitieButton.isHidden = false
        currentAbilitieButton.setTitle(title, for: .normal)
    }
    
    @objc private func abilitieViewAction() {
        presenter?.showKillTeamAbilitieViewController()
    }
    
//MARK: - PrepareViewController
    
    func setupBackgroundImage() {
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.alpha = 0.15
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "mainBackgroundView")
    }
    
    func setupDelegates() {
        currentKillTeamView.delegate = presenter as? CurrentKillTeamViewDelegate
        commandPoint.delegate = presenter as? CounterPointViewDelegate
        victoryPoint.delegate = presenter as? CounterPointViewDelegate
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }
    
    func fillCounterStackView() {
        if presenter?.model.killTeam?.abilityOfKillTeam is NovitiateAbilitie {
            guard killTeamAbilitiePoint == nil else { return }
            killTeamAbilitiePoint = CounterPointView(title: "Act of Faith")
            if presenter?.model.gameData.countTurningPoint == 0 {
                killTeamAbilitiePoint?.minusButton.isEnabled = false
                killTeamAbilitiePoint?.plusButton.isEnabled = false
            }
            killTeamAbilitiePoint?.delegate = presenter as? CounterPointViewDelegate
            if let actOfFaithPoint = killTeamAbilitiePoint {
                counterLabelsStackView.addArrangedSubview(actOfFaithPoint)
            }
        } else {
            if let actOfFaithPoint = killTeamAbilitiePoint {
                actOfFaithPoint.removeFromSuperview()
                killTeamAbilitiePoint = nil
            }
        }
        let count = CGFloat(counterLabelsStackView.arrangedSubviews.count)
        counterLabelsStackView.spacing = Constant.Size.screenHeight * 0.1 / count
    }
    
    func configure() {
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        navigationController?.navigationBar.isHidden = true
    }
    
//MARK: SetupSubView
    
    func setupSubView() {
        setupCurrentKillTeamView()
        setupStackView()
        setupAbilitieButton()
        setupChangeTurnButtons()
        setupCurrentPloysButton()
    }
    
    private func setupCurrentKillTeamView() {
        view.addSubview(currentKillTeamView)
        NSLayoutConstraint.activate([
            currentKillTeamView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.Size.screenWidth*0.025),
            currentKillTeamView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.screenWidth*0.05),
            currentKillTeamView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth*0.05),
            currentKillTeamView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13),
            currentKillTeamView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
        
        currentKillTeamView.killTeamLogo.layer.applyCornerRadiusRound(view: currentKillTeamView.killTeamLogo)
        currentKillTeamView.killTeamLogo.layer.masksToBounds = true
    }
    
    private func setupStackView() {
        counterLabelsStackView.addArrangedSubview(turningPointLabel)
        turningPointLabel.text = "Turning point 0"
        counterLabelsStackView.addArrangedSubview(commandPoint)
        counterLabelsStackView.addArrangedSubview(victoryPoint)
        view.addSubview(counterLabelsStackView)
        NSLayoutConstraint.activate([
            counterLabelsStackView.topAnchor.constraint(equalTo: currentKillTeamView.bottomAnchor, constant: Constant.Size.screenHeight * 0.025),
            counterLabelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.screenWidth * 0.1),
            counterLabelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.1),
            counterLabelsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.screenHeight/2 - 20)
        ])
    }
    
    private func setupAbilitieButton() {
        view.addSubview(currentAbilitieButton)
        currentAbilitieButton.addTarget(self, action: #selector(abilitieViewAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            currentAbilitieButton.topAnchor.constraint(equalTo: counterLabelsStackView.bottomAnchor, constant: Constant.Size.screenHeight * 0.025),
            currentAbilitieButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            currentAbilitieButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            currentAbilitieButton.heightAnchor.constraint(equalToConstant: Constant.Size.screenHeight * 0.06),
            currentAbilitieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupCurrentPloysButton() {
        view.addSubview(currentStrategicPloysButton)
        currentStrategicPloysButton.addTarget(self, action: #selector(moreInfoCurrentPloys), for: .touchUpInside)
        NSLayoutConstraint.activate([
            currentStrategicPloysButton.topAnchor.constraint(equalTo: currentAbilitieButton.bottomAnchor, constant: Constant.Size.screenHeight * 0.025),
            currentStrategicPloysButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentStrategicPloysButton.heightAnchor.constraint(equalToConstant: Constant.Size.screenHeight * 0.06)
        ])
    }
    
    
    private func setupChangeTurnButtons() {
        view.addSubview(nextTurnButton)
        view.addSubview(endGameButton)
        nextTurnButton.setTitle("Start Game", for: .normal)
        endGameButton.setTitle("End Game", for: .normal)
        nextTurnButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        endGameButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            endGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.Size.screenHeight * 0.05),
            endGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endGameButton.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.3),
            endGameButton.heightAnchor.constraint(equalTo: endGameButton.widthAnchor, multiplier: 0.3),
            endGameButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            
            nextTurnButton.bottomAnchor.constraint(equalTo: endGameButton.bottomAnchor, constant: -Constant.Size.screenHeight * 0.1),
            nextTurnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextTurnButton.widthAnchor.constraint(equalTo: endGameButton.widthAnchor),
            nextTurnButton.heightAnchor.constraint(equalTo: endGameButton.heightAnchor),
            nextTurnButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor)
        ])
        endGameButton.isHidden = true
    }
    
    @objc private func moreInfoCurrentPloys() {
        guard let currentPloys = presenter?.model.gameData.currentStrategicPloys else { return }
        if currentPloys.count == 1 {
            if let ploy = currentPloys.first {
                showAlert(ploy: ploy)
            }
        } else {
            alertCurrentPloys(ploys: currentPloys)
        }
    }
    
    
//MARK: ButtonConfigure
    
    func setupAddButton() {
        guard let tabBarController = tabBarController, let tabBarView = tabBarController.view  else { return }
        addKillTeamButton.setupButton(tabBarController: tabBarController, tabBarView: tabBarView)
        addKillTeamButton.addTarget(self, action: #selector(addKillTeam), for: .touchUpInside)
    }
    
}

extension CounterViewController: PloyViewDelegate {
    func didComplete(_ view: PloyView) {
        dismissAlert()
    }
}


