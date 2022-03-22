//
//  PloyMoreInfoView.swift
//  KillTeamApplication
//
//  Created by Apple on 23.02.2022.
//

import Foundation
import UIKit

class PloyMoreInfoView: UIStackView {
    
    let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        settingview()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


//MARK: - MethodsView
    
    private func settingview() {
        layer.masksToBounds = true
        layer.cornerRadius = 12
        backgroundColor = .systemGray2
        axis = .vertical
    }

     
     func addHeader(name: String, cost: String) {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.text = name
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        let coastLabel = UILabel()
        view.addSubview(coastLabel)
        coastLabel.translatesAutoresizingMaskIntoConstraints = false
        coastLabel.font = UIFont.boldSystemFont(ofSize: 20)
        coastLabel.text = cost
        coastLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        coastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        addArrangedSubview(view)
     }
     
    func addDescriptionLabel(description: String) {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = description
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        addArrangedSubview(view)
     }
    
    func addSubText(subText: [String]) {
        for text in subText {
            let view = UIView()
            view.backgroundColor = .systemGray2
            let label = UILabel()
            view.addSubview(label)
            view.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 18)
            label.numberOfLines = 0
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            label.text = text
            addArrangedSubview(view)
        }
    }
    
    func addUnitUniqueActions(action: UnitUniqueActions) {
        let view = TextView()
        view.addView()
        let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let text = NSMutableAttributedString(string: action.name, attributes: attributBold)
        let coast = NSMutableAttributedString(string: " (\(action.cost)AP)", attributes: attributBold)
        let description = NSAttributedString(string: ": \(action.description)")
        text.append(coast)
        text.append(description)
        view.label.attributedText = text
        addArrangedSubview(view)
    }
    
    func addPassiveAbilitie(abilitie: UnitAbilities) {
        let view = TextView()
        view.addView()
        let attributBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let text = NSMutableAttributedString(string: abilitie.name, attributes: attributBold)
        let description = NSAttributedString(string: ": \(abilitie.description)")
        text.append(description)
        view.label.attributedText = text
        addArrangedSubview(view)
    }
    
    func setupButton() {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.addSubview(button)
        view.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .orange
        button.setTitle("Done", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addArrangedSubview(view)
    }
    
    func setupTextPloy(ploy: Ploy, view: PloyMoreInfoView) {
        let cost = "\(ploy.cost)CP"
        view.addHeader(name: ploy.name, cost: cost)
        view.addDescriptionLabel(description: ploy.description)
        if let subText = ploy.subText {
            view.addSubText(subText: subText)
        }
        
        if let uniqueAction = ploy.abilities {
            view.addUnitUniqueActions(action: uniqueAction)
        }
        
        if let passiveAbilitie = ploy.passiveAbilities {
            view.addPassiveAbilitie(abilitie: passiveAbilitie)
        }
        view.setupButton()
    }

}
