//
//  ActOfFateView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

protocol KillTeamAbilitieViewProtocol {}

class ActOfFateView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(actOfFate: UnitAbilitieProtocol, cost: Int) {
        let text = cost == 1 ? "Faith point" : "Faith points"
        addCostCellView(text: "\(cost) \(text)")
        let view = AbilitieView()
        view.setupText(abilitie: actOfFate)
        addArrangedSubview(view)
        
    }
    
    private func addCostCellView(text: String) {
        let view = UIView()
        let label = NormalLabel()
        label.text = text
        label.textAlignment = .center
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        addArrangedSubview(view)
    }
    
}
