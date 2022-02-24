//
//  AdditionalVIew.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

//MARK: - EquipmentView

class AbilitiesView: UIStackView {
    
    private let subView = UIView()
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.cornerRadius = 12
        backgroundColor = .systemGray2
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        addArrangedSubview(subView)
        subView.backgroundColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        subView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 15).isActive = true
        label.topAnchor.constraint(equalTo: subView.topAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -15).isActive = true
        label.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -15).isActive = true
    }
}

//MARK: - EquipmentView

class EquipmentView: UIStackView {
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let bodyLabel = UILabel()
    let uniqueActionDescriptionLabel = UILabel()
    
    let headerView = UIView()
    let descriptionView = UIView()
    let bodyView = UIView()
    let uniqueActionView = UIView()
    let weaponView = WeaponView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingView()
        setupHeader()
        setupDescription()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupuniqueAction() {
        uniqueActionView.addSubview(uniqueActionDescriptionLabel)
        uniqueActionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        uniqueActionDescriptionLabel.textColor = UIColor.black
        uniqueActionDescriptionLabel.font = UIFont.systemFont(ofSize: 18)
        uniqueActionDescriptionLabel.numberOfLines = 0
        uniqueActionDescriptionLabel.leadingAnchor.constraint(equalTo: uniqueActionView.leadingAnchor, constant: 25).isActive = true
        uniqueActionDescriptionLabel.topAnchor.constraint(equalTo: uniqueActionView.topAnchor).isActive = true
        uniqueActionDescriptionLabel.trailingAnchor.constraint(equalTo: uniqueActionView.trailingAnchor, constant: -15).isActive = true
        uniqueActionDescriptionLabel.bottomAnchor.constraint(equalTo: uniqueActionView.bottomAnchor, constant: -15).isActive = true
        addArrangedSubview(uniqueActionView)
        uniqueActionView.translatesAutoresizingMaskIntoConstraints = false
        uniqueActionView.backgroundColor = .systemGray2
    }
    
    func setupBody() {
        bodyView.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.textColor = UIColor.black
        bodyLabel.font = UIFont.systemFont(ofSize: 18)
        bodyLabel.numberOfLines = 0
        bodyLabel.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 25).isActive = true
        bodyLabel.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 15).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -15).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -15).isActive = true
        addArrangedSubview(bodyView)
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.backgroundColor = .systemGray2
    }
    
    private func setupDescription() {
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -15).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -15).isActive = true
        addArrangedSubview(descriptionView)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.backgroundColor = .systemGray2
    }
    
    private func setupHeader() {
        addArrangedSubview(headerView)
        headerView.backgroundColor = .orange
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        headerView.addSubview(nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15).isActive = true
    }
    
    private func settingView() {
        layer.masksToBounds = true
        layer.cornerRadius = 12
        axis = .vertical
    }
    
}

//MARK: - WeaponView

class WeaponView: UIStackView {
    
    let firstSubView = UIView()
    let secondSubView = UIView()
    let thirdSubView = UIView()
    
    let nameLabel = UILabel()
    let attackLabel = UILabel()
    let ballisticSkillsLabel = UILabel()
    let damageLabel = UILabel()
    let specialRuleLabel = UILabel()
    let criticalHitspecialRuleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        settingView()
        setupView(view: firstSubView)
        addLabel()
        firstSubView.backgroundColor = .systemGray4
        nameLabel.font = UIFont .boldSystemFont(ofSize: 20)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel() {
        setupLabel(label: nameLabel, to: firstSubView, text: "Wepon name", size: 20)
        nameLabel.leadingAnchor.constraint(equalTo: firstSubView.leadingAnchor, constant: 15).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: firstSubView.centerYAnchor).isActive = true
        
        setupLabel(label: attackLabel, to: firstSubView, text: "A = 4", size: 20)
        attackLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20).isActive = true
        attackLabel.centerYAnchor.constraint(equalTo: firstSubView.centerYAnchor).isActive = true
        
        setupLabel(label: ballisticSkillsLabel, to: firstSubView, text: "BS = 3", size: 20)
        ballisticSkillsLabel.leadingAnchor.constraint(equalTo: attackLabel.trailingAnchor, constant: 20).isActive = true
        ballisticSkillsLabel.centerYAnchor.constraint(equalTo: firstSubView.centerYAnchor).isActive = true
        
        setupLabel(label: damageLabel, to: firstSubView, text: "D = 4", size: 20)
        damageLabel.leadingAnchor.constraint(equalTo: ballisticSkillsLabel.trailingAnchor, constant: 20).isActive = true
        damageLabel.centerYAnchor.constraint(equalTo: firstSubView.centerYAnchor).isActive = true
        
        setupLabel(label: specialRuleLabel, to: secondSubView, text: "", size: 18)
        specialRuleLabel.leadingAnchor.constraint(equalTo: secondSubView.leadingAnchor, constant: 15).isActive = true
        specialRuleLabel.centerYAnchor.constraint(equalTo: secondSubView.centerYAnchor).isActive = true
        
        setupLabel(label: criticalHitspecialRuleLabel, to: thirdSubView, text: "", size: 18)
        criticalHitspecialRuleLabel.leadingAnchor.constraint(equalTo: thirdSubView.leadingAnchor, constant: 15).isActive = true
        criticalHitspecialRuleLabel.centerYAnchor.constraint(equalTo: thirdSubView.centerYAnchor).isActive = true
    }
    
    func setupView(view: UIView) {
        addArrangedSubview(view)
        view.backgroundColor = .systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func settingView() {
        layer.masksToBounds = true
        layer.cornerRadius = 12
        backgroundColor = .black
        axis = .vertical
        spacing = 2
    }
    
    func setupLabel(label: UILabel, to view: UIView, text: String, size: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = 0
        label.text = text
        view.addSubview(label)
    }
}

//MARK: - CharacteristicsView

class CharacteristicsView: UIView {
    
    var firstSubView = UIView()
    var secondSubView = UIView()
    
    let movementLabel = UILabel()
    let actionPointLimit = UILabel()
    let groupActivation = UILabel()
    let defence = UILabel()
    let save = UILabel()
    let wounds = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingsView()
        addView()
        addLabel()
        firstSubView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        secondSubView.topAnchor.constraint(equalTo: firstSubView.bottomAnchor, constant: 10).isActive = true
        secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        setupSubView(view: firstSubView, to: self)
        setupSubView(view: secondSubView, to: firstSubView)
    }
    
    func addLabel() {
        setupLabel(label: movementLabel, to: firstSubView, text: "M = 3", size: 20)
        setupLabel(label: actionPointLimit, to: firstSubView, text: "APL = 2", size: 20)
        setupLabel(label: groupActivation, to: firstSubView, text: "GA = 1", size: 20)
        setupLabel(label: defence, to: secondSubView, text: "D = 3", size: 20)
        setupLabel(label: save, to: secondSubView, text: "Sv = +5", size: 20)
        setupLabel(label: wounds, to: secondSubView, text: "W = 8", size: 20)
        
        movementLabel.centerYAnchor.constraint(equalTo: firstSubView.centerYAnchor).isActive = true
        movementLabel.leadingAnchor.constraint(equalTo: firstSubView.leadingAnchor, constant: 55).isActive = true
        
        actionPointLimit.centerYAnchor.constraint(equalTo: firstSubView.centerYAnchor).isActive = true
        actionPointLimit.centerXAnchor.constraint(equalTo: firstSubView.centerXAnchor).isActive = true
        
        groupActivation.centerYAnchor.constraint(equalTo: firstSubView.centerYAnchor).isActive = true
        groupActivation.trailingAnchor.constraint(equalTo: firstSubView.trailingAnchor, constant: -55).isActive = true
        
        defence.centerYAnchor.constraint(equalTo: secondSubView.centerYAnchor).isActive = true
        defence.leadingAnchor.constraint(equalTo: secondSubView.leadingAnchor, constant: 55).isActive = true
        
        save.centerYAnchor.constraint(equalTo: secondSubView.centerYAnchor).isActive = true
        save.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor).isActive = true
        
        wounds.centerYAnchor.constraint(equalTo: secondSubView.centerYAnchor).isActive = true
        wounds.trailingAnchor.constraint(equalTo: secondSubView.trailingAnchor, constant: -55).isActive = true
    }
    
    func setupSubView(view: UIView, to equalView: UIView) {
        addSubview(view)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupLabel(label: UILabel, to view: UIView, text: String, size: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = 0
        label.text = text
        view.addSubview(label)
    }
    
    func settingsView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray2
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
}
