//
//  MoreInfoTacOpView.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import Foundation
import UIKit

protocol MoreInfoTacOpDelegate: AnyObject {
    func didComplete(_ view: MoreInfoTacOp)
}

class MoreInfoTacOp: UIStackView {
    
    weak var delegate: MoreInfoTacOpDelegate?
    
    let backGroundView = UIStackView()
    let header = UIView()
    let descriptionView = UIView()
    let firstConditionView = UIView()
    let secondConitionView = UIView()
    let subView = UIView()
    let unitActionView = UnitUniqueAtionView()
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let firstConditionLabel = UILabel()
    let secondConitionLabel = UILabel()
    let subLabel = UILabel()
    
    let button = UIButton()
    let buttonView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray3
        axis = .vertical
        setupHeader()
        setupDescription()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hideAlertVew() {
        delegate?.didComplete(self)
    }
    
    func setupText(tacOp: TacOps) {
        nameLabel.text = tacOp.name
        descriptionLabel.text = tacOp.description
    }
    
    private func setupBackground() {
        addSubview(backGroundView)
        backGroundView.backgroundColor = .systemGray3
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backGroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backGroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backGroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    private func setupHeader() {
        addArrangedSubview(header)
        header.addSubview(nameLabel)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .orange
        header.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15).isActive = true
    }
    
    private func setupDescription() {
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -15).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 15).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -15).isActive = true
        addArrangedSubview(descriptionView)
        descriptionView.backgroundColor = .systemGray3
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConditionalView(view: UIView, label: UILabel, text: String) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        addArrangedSubview(view)
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSubView(view: UIView, label: UILabel, text: String, trailingSpace: CGFloat) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: trailingSpace).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        addArrangedSubview(view)
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupButton() {
        addArrangedSubview(buttonView)
        buttonView.addSubview(button)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .orange
        button.setTitle("Done", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 15).isActive = true
        button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -15).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(hideAlertVew), for: .touchUpInside)
    }
    
}

class UnitUniqueAtionView: UIView {
    
    let header = UIView()
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let coastLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
        setupDescriptionLabel()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(action: UnitUniqueActions) {
        nameLabel.text = action.name
        coastLabel.text = String(action.cost)
        descriptionLabel.text = action.description
        
    }
    
    private func setupHeader() {
        header.addSubview(nameLabel)
        header.addSubview(coastLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        coastLabel.translatesAutoresizingMaskIntoConstraints = false
        coastLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -15).isActive = true
        coastLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        coastLabel.font = UIFont.boldSystemFont(ofSize: 20)
        addSubview(header)
        header.backgroundColor = .orange
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: topAnchor).isActive = true
        header.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true

    }
}
