//
//  VoidDancerTroupeAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class VoidDancerTroupeAbilitieView: KillTeamAbilitieView {
    
    var allegory: [VoidDancerTroupeAbilitie.Allegory]?
    
    func setupAbilitie(abilitie: VoidDancerTroupeAbilitie, viewController: UIViewController) {
        allegory = abilitie.allegory
        self.viewController = viewController
        setupHeader(title: abilitie.name)
        setupDescription(text: abilitie.description)
        abilitie.text.forEach { text in
            setupRuleView(rule: text)
        }
    }
    
    private func setupRuleView(rule: VoidDancerTroupeAbilitie.MainText) {
        addTextView(text: rule.mainText)
        addTextView(text: rule.postText)
        addSubTextPointView(subText: rule.subText)
    }
    
    @objc override func buttonAction() {
        guard let viewController = viewController else { return }
        let tableViewController = AllegoryTableViewController()
        tableViewController.allegory = allegory
        viewController.present(tableViewController, animated: true, completion: nil)
    }
    
}

