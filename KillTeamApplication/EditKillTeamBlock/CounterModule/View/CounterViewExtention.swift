//
//  CounterViewExtention.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

extension CounterViewController {
    
//MARK: - Label
    
    func createLabel (size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = 0
        view.addSubview(label)
        return label
    }
    
    func createTurningPointLabel() -> UILabel {
        let label = createLabel(size: 20)
        label.topAnchor.constraint(equalTo: currentKillTeamView.bottomAnchor, constant: 50).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.text = "Turning Point = 0"
        return label
    }
    
    func createCommandPointLabel() -> UILabel {
        let label = createLabel(size: 20)
        label.topAnchor.constraint(equalTo: turningPointLabel.bottomAnchor, constant: 50).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.text = "Command Point = 0"
        return label
    }
    
    func createVictoryPointLabel() -> UILabel {
        let label = createLabel(size: 20)
        label.topAnchor.constraint(equalTo: commandPointLabel.bottomAnchor, constant: 50).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.text = "Victory Point = 0"
        return label
    }
    
//MARK: - Button
    
    func createButton(image: String) -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = UIColor.orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setImage(UIImage(systemName: image), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
        return button
    }
    
    func createPluseButtonCommandPoint() -> UIButton {
        let button = createButton(image: "plus")
        button.topAnchor.constraint(equalTo: commandPointLabel.topAnchor, constant: 0).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        return button
    }
    
    func createMinusButtonCommandPoint() -> UIButton {
        let button = createButton(image: "minus")
        button.topAnchor.constraint(equalTo: commandPointLabel.topAnchor, constant: 0).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        return button
    }
    
    func createPluseButtonVictoryPoint() -> UIButton {
        let button = createButton(image: "plus")
        button.topAnchor.constraint(equalTo: victoryPointLabel.topAnchor, constant: 0).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        return button
    }
    
    func createMinusButtonVictoryPoint() -> UIButton {
        let button = createButton(image: "minus")
        button.topAnchor.constraint(equalTo: victoryPointLabel.topAnchor, constant: 0).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        return button
    }
    
    func createBigButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }
    
    func createNextTurnButton () -> UIButton {
        let button = createBigButton()
        button.topAnchor.constraint(equalTo: victoryPointLabel.bottomAnchor, constant: 120).isActive = true
        button.setTitle("Start Game", for: .normal)
        return button
    }
    
    func createEndGameButton() -> UIButton {
        let button = createBigButton()
        button.topAnchor.constraint(equalTo: self.nextTurnButton.bottomAnchor, constant: 50).isActive = true
        button.setTitle("End Game", for: .normal)
        return button
    }
    
    func addButton() {
        view.addSubview(addKillTeamButton)
        addKillTeamButton.backgroundColor = .orange
        addKillTeamButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addKillTeamButton.imageView?.tintColor = .black
        addKillTeamButton.layer.masksToBounds = true
        addKillTeamButton.layer.cornerRadius = 30
        addKillTeamButton.layer.borderWidth = 1
        addKillTeamButton.addTarget(self, action: #selector(addKillTeam), for: .touchUpInside)
        addKillTeamButton.translatesAutoresizingMaskIntoConstraints = false
        addKillTeamButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addKillTeamButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        addKillTeamButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.size.height/8).isActive = true
        addKillTeamButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
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
   
    func setupTextPloy(ploy: Ploy) {
        moreInfoPloyView.nameLabel.text = ploy.name
        moreInfoPloyView.descriptionLabel.text = ploy.description
        moreInfoPloyView.coastLabel.text = "\(ploy.cost)CP"
    }
}
