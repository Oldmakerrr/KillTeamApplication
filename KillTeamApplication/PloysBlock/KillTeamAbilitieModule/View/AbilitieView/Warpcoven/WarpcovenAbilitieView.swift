//
//  WarpcovenAbilitieView.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class WarpcovenAbilitieView: KillTeamAbilitieView {
    
    var boonsOfTzeentch = [[WarpcovenAbilitie.BoonsOfTzeentch]]()
    
    @objc override func buttonAction() {
        guard let viewController = viewController else { return }
        let tableViewController = BoonOfTzeenchTableViewController()
        tableViewController.boonsOfTzeentch = boonsOfTzeentch
        viewController.present(tableViewController, animated: true, completion: nil)
    }
    
    func setupAbilitie(abilitie: WarpcovenAbilitie, viewController: UIViewController) {
        self.viewController = viewController
        addBoonOfTzeench(abilitie: abilitie)
        setupHeader(title: abilitie.name)
        abilitie.description.forEach { text in
            setupTextView(text: text)
        }
        
    }
    
    private func addBoonOfTzeench(abilitie: WarpcovenAbilitie) {
        var mutation = [WarpcovenAbilitie.BoonsOfTzeentch]()
        var fate = [WarpcovenAbilitie.BoonsOfTzeentch]()
        var aetheric = [WarpcovenAbilitie.BoonsOfTzeentch]()
        abilitie.mutation.forEach { boonOfTzeentch in
            switch boonOfTzeentch.type {
            case .mutation:
                mutation.append(boonOfTzeentch)
            case .fate:
                fate.append(boonOfTzeentch)
            case .aetheric:
                aetheric.append(boonOfTzeentch)
            }
        }
        boonsOfTzeentch.append(mutation)
        boonsOfTzeentch.append(fate)
        boonsOfTzeentch.append(aetheric)
    }
}
