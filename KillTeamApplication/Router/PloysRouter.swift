//
//  PloysRouter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol PloysRouterProtocol: Router {
    var ploysNavigationCOntroller: UINavigationController { get }
}

class PloysRouter: PloysRouterProtocol {
    
    lazy var ploysNavigationCOntroller = UINavigationController(rootViewController: ploysModule as! UIViewController)
    lazy var ploysModule = builder.createPloysModule(router: self)
    var builder: BuilderProtocol
    
    
    init(builder: BuilderProtocol) {
        self.builder = builder
    }
}
