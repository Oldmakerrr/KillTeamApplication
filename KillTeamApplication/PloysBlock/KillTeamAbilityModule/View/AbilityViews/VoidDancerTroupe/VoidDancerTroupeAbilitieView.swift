//
//  VoidDancerTroupeAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

protocol VoidDancerTroupeAbilitieViewDelegate: AnyObject {
    func didComplete(_ voidDancerTroupeAbilitieView: VoidDancerTroupeAbilitieView)
}

class VoidDancerTroupeAbilitieView: KillTeamAbilitieView {
    
    weak var delegate: VoidDancerTroupeAbilitieViewDelegate?
    
    var allegory: [VoidDancerTroupeAbility.Allegory]?
    
    func setupAbilitie(abilitie: VoidDancerTroupeAbility, viewController: UIViewController) {
        allegory = abilitie.allegory
        self.viewController = viewController
        setupHeader(title: abilitie.name)
        setupDescription(text: abilitie.description)
        abilitie.text.forEach { text in
            setupRuleView(rule: text)
        }
    }
    
    private func setupRuleView(rule: VoidDancerTroupeAbility.MainText) {
        addTextView(text: rule.mainText)
        addTextView(text: rule.postText)
        addSubTextPointView(subText: rule.subText)
    }
    
    @objc override func buttonAction() {
        delegate?.didComplete(self)
    }
    
}

