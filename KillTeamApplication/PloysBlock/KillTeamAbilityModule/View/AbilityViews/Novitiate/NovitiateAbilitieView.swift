//
//  NovitiateAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

//MARK: - NovitiateAbilitieView

protocol NovitiateAbilitieViewDelegate: AnyObject {
    func didComplete(_ novitiateAbilitieView: NovitiateAbilitieView)
}

class NovitiateAbilitieView: KillTeamAbilitieView {
    
    var actOfFaith: [NovitiateAbility.ActOfFaith]?
    
    weak var delegate: NovitiateAbilitieViewDelegate?
    
    @objc override func buttonAction() {
        delegate?.didComplete(self)
    }
    
    func setupAbilitie(abilitie: NovitiateAbility, viewController: UIViewController) {
        self.viewController = viewController
        actOfFaith = abilitie.actsOfFaith
        setupHeader(title: abilitie.name)
        setupTextView(text: abilitie.description)
        addSubTextPointView(subText: abilitie.subText)
        abilitie.postText.forEach { text in
            setupTextView(text: text)
        }
    }
}

