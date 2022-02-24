//
//  TacOpsRouter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol TacOpsRouterProtocol: Router {
    var tacOpsNavigationController: UINavigationController { get }
}

class TacOpsRouter: TacOpsRouterProtocol {
    
    var builder: BuilderProtocol
    
    lazy var tacOpsNavigationController = UINavigationController(rootViewController: tacOpsModule as! UIViewController)
    lazy var tacOpsModule = builder.createTacOpsModule(router: self)
    
    init(builder: BuilderProtocol) {
        self.builder = builder
    }
    
    func showChossenTacOpsModule() {
        let view = builder.createChoosenTacOpsModule(router: self)
        tacOpsNavigationController.pushViewController(view as! UIViewController, animated: true)
    }
}

extension TacOpsRouter: TacOpsPresenterDelegate {
    func didComplete(_ presenter: TacOpsPresenter) {
        showChossenTacOpsModule()
    }
}
