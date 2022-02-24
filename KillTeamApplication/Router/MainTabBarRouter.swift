//
//  MainTabBarRouter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol Router {
    
    var builder: BuilderProtocol { get }
}

protocol MainTabbarRouterProtocol: Router {
    
}

class MainTabbarRouter: MainTabbarRouterProtocol {
    
    let rootViewController = MainTabBarController()
    var builder: BuilderProtocol
    var window: UIWindow
    
    lazy var editKillTeamRouter = EeditKillTeamRouter(builder: builder)
    lazy var observerKillTeamRouner = KillTeamObserverRouter(builder: builder)
    lazy var ploysRouter = PloysRouter(builder: builder)
    lazy var tacOpsRouter = TacOpsRouter(builder: builder)
    
    lazy var editKillTeamNavigationController = editKillTeamRouter.editKillTeamNavigationController
    lazy var observerKillTeamNavigationController =  observerKillTeamRouner.observerKillTeamNavigationController
    lazy var ploysNavigationController = ploysRouter.ploysNavigationCOntroller
    lazy var tacOpsNavigationController = tacOpsRouter.tacOpsNavigationController
    
    init(builder: BuilderProtocol, window: UIWindow) {
        self.builder = builder
        self.window = window
        editKillTeamNavigationController.tabBarItem.title = "Counter"
        observerKillTeamNavigationController.tabBarItem.title = "Killteam"
        ploysNavigationController.tabBarItem.title = "Ploys"
        tacOpsNavigationController.tabBarItem.title = "TacOps"
        rootViewController.viewControllers = [editKillTeamNavigationController, observerKillTeamNavigationController, ploysNavigationController, tacOpsNavigationController]
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
