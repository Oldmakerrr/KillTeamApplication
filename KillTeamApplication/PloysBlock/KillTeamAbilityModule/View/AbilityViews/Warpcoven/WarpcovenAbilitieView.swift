//
//  WarpcovenAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class WarpcovenAbilitieView: KillTeamAbilitieView {
    
    var abilitie: WarpcovenAbility?
    
    @objc override func buttonAction() {
        guard let viewController = viewController, let abilitie = abilitie else { return }
        let tableViewController = BoonOfTzeenchTableViewController()
        tableViewController.addBoonOfTzeench(abilitie: abilitie)
        viewController.present(tableViewController, animated: true, completion: nil)
    }
    
    func setupAbilitie(abilitie: WarpcovenAbility, viewController: UIViewController) {
        self.viewController = viewController
        self.abilitie = abilitie
        setupHeader(title: abilitie.name)
        abilitie.description.forEach { text in
            setupTextView(text: text)
        }
        
    }
    
}
