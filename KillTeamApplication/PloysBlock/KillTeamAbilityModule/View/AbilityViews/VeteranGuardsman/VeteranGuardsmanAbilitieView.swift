//
//  VeteranGuardsmanAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class VeteranGuardsmanAbilitieView: KillTeamAbilitieView {
    
    var tacticalAssets: [VeteranGuardsmanAbility.TacticalAssets]?
    
    @objc override func buttonAction() {
        guard let viewController = viewController else { return }
        let tableViewController = TacticalAssetsTableViewController()
        tableViewController.tacticalAssets = tacticalAssets
        viewController.present(tableViewController, animated: true, completion: nil)
    }
    
    func setupAbilitie(abilitie: VeteranGuardsmanAbility, viewController: UIViewController) {
        self.viewController = viewController
        tacticalAssets = abilitie.tacticalAssets
        setupHeader(title: abilitie.name)
        setupTextView(text: abilitie.description)
        abilitie.ancillarySupport.forEach { ancillarySupport in
            setupAncillarySupport(ancillarySupport: ancillarySupport)
        }
        
    }
    
    private func setupAncillarySupport(ancillarySupport: VeteranGuardsmanAbility.AncillarySupport) {
        setupHeader(title: ancillarySupport.name)
        setupTextView(text: ancillarySupport.description)
        if let listOfTacticalAssets = ancillarySupport.listOfTacticalAssets {
            addSubTextPointView(subText: listOfTacticalAssets)
        }
        if let postText = ancillarySupport.postText {
            setupTextView(text: postText)
        }
    }

}
