//
//  ExtentionCounter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

extension CounterViewController {
        
//MARK: - ConfigureAbilitieView
    
    func setupTextToAbilitieView() {
        guard let abilitie = presenter?.model.killTeam?.abilitiesOfKillTeam else {
            currentAbilitieView.isHidden = true
            return }
        configureAbilitieView()
        
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
        currentAbilitieView.isHidden = true
    }
    
    private func configureAbilitieView() {
        currentAbilitieView.layer.applyCornerRadius()
        currentAbilitieView.backgroundColor = ColorScheme.shared.theme.viewBackground
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(abilitieViewAction))
        gesture.numberOfTouchesRequired = 1
        currentAbilitieView.addGestureRecognizer(gesture)
    }
    
    private func setupTextToAbilitieView(title: String) {
        currentAbilitieView.isHidden = false
        currentAbilitieView.setupText(text: title)
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
        currentPloysCollectionView.dataSource = self
        currentPloysCollectionView.selectCellDelegate = self
        currentKillTeamView.delegate = presenter as? CurrentKillTeamViewProtocol
        commandPoint.delegate = presenter as? CounterPointViewDelegate
        victoryPoint.delegate = presenter as? CounterPointViewDelegate
    }
    
    func fillCounterStackView() {
        if presenter?.model.killTeam?.abilitiesOfKillTeam is NovitiateAbilitie {
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
        setupAbilitieView()
        setupChangeTurnButtons()
        setupCollectionView()
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
            counterLabelsStackView.topAnchor.constraint(equalTo: currentKillTeamView.bottomAnchor, constant: 30),
            counterLabelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.screenWidth * 0.1),
            counterLabelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.1),
            counterLabelsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.Size.screenHeight/2 - 20)
        ])
    }
    
    private func setupAbilitieView() {
        view.addSubview(currentAbilitieView)
        NSLayoutConstraint.activate([
            currentAbilitieView.topAnchor.constraint(equalTo: counterLabelsStackView.bottomAnchor, constant: 20),
            currentAbilitieView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            currentAbilitieView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            currentAbilitieView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            currentAbilitieView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
    
    private func setupCollectionView() {
        view.addSubview(currentPloysCollectionView)
        NSLayoutConstraint.activate([
            currentPloysCollectionView.topAnchor.constraint(equalTo: currentAbilitieView.bottomAnchor, constant: Constant.Size.screenHeight * 0.025),
            currentPloysCollectionView.bottomAnchor.constraint(equalTo: nextTurnButton.topAnchor, constant: -Constant.Size.screenHeight * 0.025),
            currentPloysCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.025),
            currentPloysCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.screenWidth * 0.025)
        ])
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


