//
//  HunterCladeAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class HunterCladeAbilitieView: KillTeamAbilitieView {
    
    var imperative: [HunterCladeAbilitie.Imperative]?
    
    @objc override func buttonAction() {
        guard let viewController = viewController else { return }
        let tableViewController = ImperativeTableViewController()
        tableViewController.imperative = imperative
        viewController.present(tableViewController, animated: true, completion: nil)
    }
    
    func setupAbilitie(abilitie: HunterCladeAbilitie, viewController: UIViewController) {
        self.viewController = viewController
        imperative = abilitie.imperatives
        setupHeader(title: abilitie.name)
        abilitie.description.forEach { text in
            setupTextView(text: text)
        }
    }
}
