//
//  NovitiateAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

//MARK: - NovitiateAbilitieView

class NovitiateAbilitieView: KillTeamAbilitieView {
    
    var actOfFaith: [NovitiateAbilitie.ActOfFaith]?
    
    @objc override func buttonAction() {
        guard let viewController = viewController else { return }
        let tableViewController = ActsOfFaithTableViewController()
        tableViewController.actsOfFaith = actOfFaith
        viewController.present(tableViewController, animated: true, completion: nil)
    }
    
    func setupAbilitie(abilitie: NovitiateAbilitie, viewController: UIViewController) {
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

