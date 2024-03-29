//
//  MainTabBarController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol RouterProtocol { }

class MainRouter: RouterProtocol {
    
    let editKillTeamRouter: EditKillTeamRouter
    let killTeamObserverRouter: KillTeamObserverRouter
    let ploysRouter: PloysRouter
    let tacOpsRouter: TacOpsRouter
    
    init(builder: BuilderProtocol) {
        self.editKillTeamRouter = EditKillTeamRouter(builder: builder)
        self.killTeamObserverRouter = KillTeamObserverRouter(builder: builder)
        self.ploysRouter = PloysRouter(builder: builder)
        self.tacOpsRouter = TacOpsRouter(builder: builder)
    }
}



class MainTabBarController: UITabBarController {
    
    let editKillTeamNavigationController: EditKillTeamNavigationController
    let killTeamObserverNavigationController: KillTeamObserverNavigationController
    let ploysNavigationController: PloyNavigationController
    let tacOpsNavigationController: TacOpsNavigationController
    
    init(mainRouter: MainRouter, builder: BuilderProtocol) {
        
        let counterRootViewController = builder.createCounterModule(router: mainRouter.editKillTeamRouter)
        self.editKillTeamNavigationController = EditKillTeamNavigationController(rootViewController: counterRootViewController as! UIViewController)
        mainRouter.editKillTeamRouter.editKillTeamNavigationController = editKillTeamNavigationController
        
        let killTeamObserverRootViewController = builder.createRosterModule(router: mainRouter.killTeamObserverRouter)
        self.killTeamObserverNavigationController = KillTeamObserverNavigationController(rootViewController: killTeamObserverRootViewController as! UIViewController)
        mainRouter.killTeamObserverRouter.observerKillTeamNavigationController = killTeamObserverNavigationController
        
        let ploysRootViewController = builder.createPloysModule(router: mainRouter.ploysRouter)
        self.ploysNavigationController = PloyNavigationController(rootViewController: ploysRootViewController as! UIViewController)
        mainRouter.ploysRouter.ploysNavigationController = ploysNavigationController
        
        let tacOpsRootViewController = builder.createTacOpsModule(router: mainRouter.tacOpsRouter)
        self.tacOpsNavigationController = TacOpsNavigationController(rootViewController: tacOpsRootViewController as! UIViewController)
        mainRouter.tacOpsRouter.tacOpsNavigationController = tacOpsNavigationController
        
        super.init(nibName: nil, bundle: nil)
        viewControllers = [editKillTeamNavigationController, killTeamObserverNavigationController, ploysNavigationController, tacOpsNavigationController]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barStyle = .black
        self.delegate = self
        tabBar.tintColor = ColorScheme.shared.theme.selectedView
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController else { return }
        let selectedIndex = tabBarController.selectedIndex
        switch selectedIndex {
        case 0:
            if navigationController.viewControllers.count > 2 {
                if let editKillTeamVC = navigationController.viewControllers.first(where: {$0 is EditKillTeamTableViewController}) {
                    navigationController.popToViewController(editKillTeamVC, animated: true)
                }
            }
        case 2:
            navigationController.popToRootViewController(animated: true)
        default:
            return
        }
    }
}


//MARK: - EditKillTeamNavigationController

class EditKillTeamNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.image = UIImage(named: "counterViewController")
        tabBarItem.title = "Counter"
    }
   
}

//MARK: - KillTeamObserverNavigationController

class KillTeamObserverNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.image = UIImage(named: "killTeamViewController")
        tabBarItem.title = "Kill Team"
    }
    
}

//MARK: - PloyNavigationController

class PloyNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.image = UIImage(named: "ployViewController")
        tabBarItem.title = "Ploys"
    }
    
}

//MARK: - PloyNavigationController

class TacOpsNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.image = UIImage(named: "tacOpsViewController")
        tabBarItem.title = "TacOps"
    }
    
}
