//
//  AdditionalVIew.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

//MARK: - TextView

class TextView: UIStackView {
    
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
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        subView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: subView.topAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -10).isActive = true
    }
}

//MARK: - CharacteristicsView

class CharacteristicsView: UIView {
    
    private let firstSubView = UIView()
    private let secondSubView = UIView()
    
    private let movementLabel = UILabel()
    private let actionPointLimit = UILabel()
    private let groupActivation = UILabel()
    private let defence = UILabel()
    private let save = UILabel()
    private let wounds = UILabel()
    
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
    
    func setupText(unit: Unit) {
        movementLabel.text = "M = \(unit.movement)"
        actionPointLimit.text = "APL = \(unit.actionPointLimit)"
        groupActivation.text = "GA = \(unit.groupActivation)"
        defence.text = "D = \(unit.defense)"
        save.text = "Sv = \(unit.save)+"
        wounds.text = "W = \(unit.wounds)"
    }
    
    private func addView() {
        setupSubView(view: firstSubView, to: self)
        setupSubView(view: secondSubView, to: firstSubView)
    }
    
    private func addLabel() {
        setupLabel(label: movementLabel, to: firstSubView, size: 20)
        setupLabel(label: actionPointLimit, to: firstSubView, size: 20)
        setupLabel(label: groupActivation, to: firstSubView, size: 20)
        setupLabel(label: defence, to: secondSubView, size: 20)
        setupLabel(label: save, to: secondSubView, size: 20)
        setupLabel(label: wounds, to: secondSubView, size: 20)
        
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
    
    private func setupSubView(view: UIView, to equalView: UIView) {
        addSubview(view)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = ColorScheme.shared.theme.subViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupLabel(label: UILabel, to view: UIView, size: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.numberOfLines = 0
        view.addSubview(label)
    }
    
    private func settingsView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ColorScheme.shared.theme.viewBackground
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
}
