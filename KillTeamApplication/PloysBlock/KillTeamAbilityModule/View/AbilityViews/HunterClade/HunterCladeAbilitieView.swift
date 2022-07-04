//
//  HunterCladeAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

protocol HunterCladeAbilitieViewDelegate: AnyObject {
    func didComplete(_ hunterCladeAbilitieView: HunterCladeAbilitieView)
}

class HunterCladeAbilitieView: KillTeamAbilitieView {
    
    weak var delegate: HunterCladeAbilitieViewDelegate?
    
    var imperative: [HunterCladeAbility.Imperative]?
    
    @objc override func buttonAction() {
        delegate?.didComplete(self)
    }
    
    func setupAbilitie(abilitie: HunterCladeAbility, viewController: UIViewController) {
        self.viewController = viewController
        imperative = abilitie.imperatives
        setupHeader(title: abilitie.name)
        abilitie.description.forEach { text in
            setupTextView(text: text)
        }
    }
}
