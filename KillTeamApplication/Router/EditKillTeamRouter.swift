//
//  EditKillTeamRouter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol EditKillTeamRouterProtocol: Router {
    var editKillTeamNavigationController: UINavigationController { get }

}

class EeditKillTeamRouter: EditKillTeamRouterProtocol {
    
    var builder: BuilderProtocol
    
    lazy var editKillTeamNavigationController = UINavigationController(rootViewController: counterModule as! UIViewController)
    lazy var counterModule = builder.createCounterModule(router: self)
    
    
    init (builder: BuilderProtocol) {
        self.builder = builder
    }
    
    
    func showChooseKillTeamTableViewController() {
        let chooseKillTeamTableViewController = builder.createChooseKillTeamModule(router: self)
        editKillTeamNavigationController.present(chooseKillTeamTableViewController as! UIViewController, animated: true, completion: nil)
        
    }
    
    func showEditKillTeamController() {
         let editKillTeamTableViewController = builder.createEditKillTeamModule(router: self)
            editKillTeamNavigationController.pushViewController(editKillTeamTableViewController as! UITableViewController, animated: true)
            //switch sender {
            //case "forward":
            //    editKillTeamNavigationController.pushViewController(editKillTeamTableViewController as! UITableViewController, animated: true)
            //case "back":
               // editKillTeamNavigationController.popViewController(animated: true)
            //default :
            //    return
            //}
    }
    
    func showAddFireTeamController() {
        let addFireTeamVC = builder.createAddFireTeamModule(router: self)
        editKillTeamNavigationController.pushViewController(addFireTeamVC as! UIViewController, animated: true)
    }
    
    func showEditUnitController() {
         let editUnitVC = builder.createEditUnitModule(router: self)
        editKillTeamNavigationController.pushViewController(editUnitVC as! UIViewController, animated: true)
    }
    
    func showChooseLoadedKillTeamController() {
        let view = builder.createChooseLoadedKillTeamModule(router: self)
        editKillTeamNavigationController.present(view as! UIViewController, animated: true, completion: nil)
    }
}


extension EeditKillTeamRouter: CounterPresenterDelegate {
    func didComplete(_ presenter: CounterPresenterProtocol, sender: NavigationFromCounterModule) {
        switch sender {
        case .createNewKillTeam:
            showChooseKillTeamTableViewController()
        case .loadKillTeam:
            showChooseLoadedKillTeamController()
        case .editCurrentKillTeam:
            showEditKillTeamController()
        }
    }
}

enum NavigationFromCounterModule {
    case createNewKillTeam
    case loadKillTeam
    case editCurrentKillTeam
}

extension EeditKillTeamRouter: ChooseKillTeamPresenterDelegate {
    func didComplete(presenter: ChooseKillTeamPresenterProtocol) {
        showEditKillTeamController()
    }
}

extension EeditKillTeamRouter: EditKillTeamPresenterDelegate {
    func didComplete(_presenter: EditKillTeamPresenterProtocol, sender: GoFromEditKillTeam) {
        switch sender {
        case .addFireTeam:
            showAddFireTeamController()
        case .editUnit:
            showEditUnitController()
        }
    }
}

extension EeditKillTeamRouter: ChooseLoadedKillTeamPresenterDelegate {
    func didComplete(_ presenter: ChooseLoadedKillTeamPresenterProtocol) {
        showEditKillTeamController()
    }
}
