//
//  KillTeamObserverRouter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol KillTeamObserverRouterProtocol {
    var observerKillTeamNavigationController: KillTeamObserverNavigationController? { get }
    
}

class KillTeamObserverRouter: KillTeamObserverRouterProtocol {
    
    var builder: BuilderProtocol

    var observerKillTeamNavigationController: KillTeamObserverNavigationController?
    
    init(builder: BuilderProtocol) {
        self.builder = builder
    }
    
    func showMoreUnitInfoController() {
        let view = builder.createMoreInfooUnitModule(router: self)
        observerKillTeamNavigationController?.pushViewController(view as! UIViewController, animated: true)
    }
}

extension KillTeamObserverRouter: RosterPresenterDelegate {
    func didComplete(_ presenter: RosterPresenterProtocol) {
        showMoreUnitInfoController()
    }
}
