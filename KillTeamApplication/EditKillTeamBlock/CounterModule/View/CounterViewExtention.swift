//
//  CounterViewExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

extension CounterViewController {
    
//MARK: - SetupViewMethods
    
    func configure() {
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupSubView() {
        setupCurrentKillTeamView()
        setupLabels()
        setupButtons()
        
    }
    
    func setupLabels() {
        setupTurningPointLabel()
        setupCommandPointLabel()
        setupVictoryPointLabel()
    }
    
    func setupButtons() {
        setupCommandPointAndVictoryPointButtons()
        setupChangeTurnButtons()
        setupAddButton()
    }
    
    func setupCurrentKillTeamView() {
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
    
    func setupTurningPointLabel() {
        turningPointLabel.text = "Turning Point = 0"
        view.addSubview(turningPointLabel)
        NSLayoutConstraint.activate([
            turningPointLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.screenWidth * 0.025),
            turningPointLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.025),
            turningPointLabel.topAnchor.constraint(equalTo: currentKillTeamView.bottomAnchor, constant: Constant.Size.screenHeight * 0.055),
            turningPointLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
    }
    
    func setupCommandPointLabel() {
        commandPointLabel.text = "Command Point = 0"
        view.addSubview(commandPointLabel)
        NSLayoutConstraint.activate([
            commandPointLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.screenWidth * 0.025),
            commandPointLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.025),
            commandPointLabel.topAnchor.constraint(equalTo: turningPointLabel.bottomAnchor, constant: Constant.Size.screenHeight * 0.055),
            commandPointLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
    }
    
    func setupVictoryPointLabel() {
        victoryPointLabel.text = "Victory Point = 0"
        view.addSubview(victoryPointLabel)
        NSLayoutConstraint.activate([
            victoryPointLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.screenWidth * 0.025),
            victoryPointLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.025),
            victoryPointLabel.topAnchor.constraint(equalTo: commandPointLabel.bottomAnchor, constant: Constant.Size.screenHeight * 0.055),
            victoryPointLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
    }
    
    func setupPlusAndMinusButtons(minusButton: ChangePointButton, plusButton: ChangePointButton, to view: UIView) {
        self.view.addSubview(plusButton)
        self.view.addSubview(minusButton)
        plusButton.setupImage(imageName: "plus")
        plusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        minusButton.setupImage(imageName: "minus")
        minusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.1),
            plusButton.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor),
            plusButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.3),
            plusButton.widthAnchor.constraint(equalTo: plusButton.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            minusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            minusButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constant.Size.screenWidth * 0.1),
            minusButton.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor),
            minusButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.3),
            minusButton.widthAnchor.constraint(equalTo: minusButton.heightAnchor)
        ])
        plusButton.layer.applyCornerRadiusRound(view: plusButton)
        minusButton.layer.applyCornerRadiusRound(view: minusButton)
    }
    
    func setupCommandPointAndVictoryPointButtons() {
        setupPlusAndMinusButtons(minusButton: minusCommandPoint, plusButton: plusCommandPoint, to: commandPointLabel)
        setupPlusAndMinusButtons(minusButton: minusVictoryPoint, plusButton: plusVictoryPoint, to: victoryPointLabel)
    }
    
    func setupChangeTurnButtons() {
        view.addSubview(nextTurnButton)
        view.addSubview(endGameButton)
        nextTurnButton.setTitle("Start Game", for: .normal)
        endGameButton.setTitle("End Game", for: .normal)
        nextTurnButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        endGameButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            endGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.Size.screenHeight * 0.1),
            endGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endGameButton.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.4),
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
    
    func setupAddButton() {
        view.addSubview(addKillTeamButton)
        addKillTeamButton.addTarget(self, action: #selector(addKillTeam), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addKillTeamButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.Size.screenHeight * 0.04),
            addKillTeamButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.screenWidth * 0.085),
            addKillTeamButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            addKillTeamButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            addKillTeamButton.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.145),
            addKillTeamButton.heightAnchor.constraint(equalTo: addKillTeamButton.widthAnchor)
        ])
        addKillTeamButton.layer.applyCornerRadiusRound(view: addKillTeamButton)
    }
    
//MARK: - NeedChange
  
    
    func setupCurrentStrategicPloyLabel() {
        view.addSubview(currentStrategicPloyLabel)
        currentStrategicPloyLabel.translatesAutoresizingMaskIntoConstraints = false
        currentStrategicPloyLabel.font = UIFont.systemFont(ofSize: 20)
        currentStrategicPloyLabel.topAnchor.constraint(equalTo: victoryPointLabel.bottomAnchor, constant: 60).isActive = true
        currentStrategicPloyLabel.leadingAnchor.constraint(equalTo: minusCommandPoint.leadingAnchor).isActive = true
    }
    
    func setupCurrentStrategicPloyButton() {
        view.addSubview(currentStrategicPloyButton)
        currentStrategicPloyButton.translatesAutoresizingMaskIntoConstraints = false
        currentStrategicPloyButton.centerYAnchor.constraint(equalTo: currentStrategicPloyLabel.centerYAnchor).isActive = true
        currentStrategicPloyButton.leadingAnchor.constraint(equalTo: currentStrategicPloyLabel.trailingAnchor, constant: 10).isActive = true
        currentStrategicPloyButton.addTarget(self, action: #selector(pressCurrentStrategicPloyButton), for: .touchUpInside)
        currentStrategicPloyButton.setTitleColor(.black, for: .normal)
    }
}

extension CounterViewController: PloyViewDelegate {
    func didComplete(_ view: PloyView) {
        dismissAlert()
    }
}
