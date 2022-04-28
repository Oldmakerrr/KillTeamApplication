//
//  AbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 23.03.2022.
//

import Foundation
import UIKit

class AbilitieView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupText(abilitie: UnitAbilitieProtocol) {
        setupAbilitie(abilitie: abilitie)
        if let subText = abilitie.subText {
            addSubTextPointView(subText: subText)
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
    }
    
    
    private func setupAbilitie(abilitie: UnitAbilitieProtocol) {
        let view = UIView()
        let label = BoldTextLabel()
        addArrangedSubview(view)
        view.addSubview(label)
        label.addText(bold: abilitie.name, normal: abilitie.description)
        addView(view: view, subView: label)
    }
}
