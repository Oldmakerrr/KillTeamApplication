//
//  PloysRouter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol PloysRouterProtocol {
    var ploysNavigationController: PloyNavigationController? { get }
}

class PloysRouter: PloysRouterProtocol {
    
    var ploysNavigationController: PloyNavigationController?
    
    var builder: BuilderProtocol
    
    
    init(builder: BuilderProtocol) {
        self.builder = builder
    }
    
    func showKillTeamAbilitieModule() {
        let view = builder.createKillTeamAbilitieModule(router: self)
        ploysNavigationController?.pushViewController(view as! UIViewController, animated: true)
    }
    
    func showPsychicPowerModule() {
        let view = builder.createPsychicPowerModule(router: self)
        ploysNavigationController?.pushViewController(view as! UIViewController, animated: true)
    }
}

extension PloysRouter: PloysPresenterDelegate {
    func didComplete(_ presenter: PloysPresenter, sender: GoFromPloysModule) {
        switch sender {
        case .psychicPowerModule:
            showPsychicPowerModule()
        case .killTeamAbilitieModule:
            showKillTeamAbilitieModule()
        }
    }
    
    
}
