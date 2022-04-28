//
//  LegionaryAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class LegionaryAbilitieView: KillTeamAbilitieView {
    
    var chaosBlessing: [LegionaryAbilitie.ChaosBlessing]?
    
    func setupAbilitie(abilitie: LegionaryAbilitie, viewController: UIViewController) {
        chaosBlessing = abilitie.chaosBlessings
        self.viewController = viewController
        let chaosBlessingView = AbilitieView()
        chaosBlessingView.setupText(abilitie: abilitie.chaosBlessing)
        addArrangedSubview(chaosBlessingView)
        let favouredOfTheDarkGodsView = AbilitieView()
        favouredOfTheDarkGodsView.setupText(abilitie: abilitie.favouredOfTheDarkGods)
        addArrangedSubview(favouredOfTheDarkGodsView)
    }
    
    @objc override func buttonAction() {
        guard let viewController = viewController else { return }
        let tableViewController = ChaosBlessingTableViewController()
        tableViewController.chaosBlessing = chaosBlessing
        viewController.present(tableViewController, animated: true, completion: nil)
    }
}
