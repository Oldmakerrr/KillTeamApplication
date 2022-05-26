//
//  EditKillTeamRouter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol EditKillTeamRouterProtocol: RouterProtocol {
    var editKillTeamNavigationController: EditKillTeamNavigationController? { get }

}

class EeditKillTeamRouter: EditKillTeamRouterProtocol {
    
    var builder: BuilderProtocol
    
    var editKillTeamNavigationController: EditKillTeamNavigationController?
    var editUnitPresenter: EditUnitPresenter?
    
    init (builder: BuilderProtocol) {
        self.builder = builder
    }
    
    
    func showChooseKillTeamTableViewController() {
        let chooseKillTeamTableViewController = builder.createChooseKillTeamModule(router: self)
        editKillTeamNavigationController?.present(chooseKillTeamTableViewController as! UIViewController, animated: true, completion: nil)
        
    }
    
    func showEditKillTeamController() {
        let editKillTeamTableViewController = builder.createEditKillTeamModule(router: self)
        editKillTeamNavigationController?.pushViewController(editKillTeamTableViewController as! UITableViewController, animated: true)
    }
    
    func showKillTeamAbilitie() {
        if let imperativeTableViewController = builder.createKillTeamImperativesList(router: self) {
            editKillTeamNavigationController?.present(imperativeTableViewController, animated: true)
        }
        if let allegoryTableViewController = builder.createKillTeamAllegoryList(router: self) {
            editKillTeamNavigationController?.present(allegoryTableViewController, animated: true)
        }
        if let editUnitPresenter = editUnitPresenter,
           let chaosBlessingTableViewController = builder.createChaosBlessingList(router: self, delegate: editUnitPresenter) {
            editKillTeamNavigationController?.present(chaosBlessingTableViewController, animated: true)
        }
        if let editUnitPresenter = editUnitPresenter,
           let boonOfTzeenchTableViewController = builder.createBoonOfTzeenchTableViewController(router: self, delegate: editUnitPresenter) {
            editKillTeamNavigationController?.present(boonOfTzeenchTableViewController, animated: true)
        }
    }
    
    func showAddFireTeamController() {
        let addFireTeamVC = builder.createAddFireTeamModule(router: self)
        editKillTeamNavigationController?.pushViewController(addFireTeamVC as! UIViewController, animated: true)
    }
    
    func showEditUnitController() {
        let editUnitVC = builder.createEditUnitModule(router: self)
        self.editUnitPresenter = editUnitVC.presenter as? EditUnitPresenter
        editKillTeamNavigationController?.pushViewController(editUnitVC as! UIViewController, animated: true)
    }
    
    func showChooseLoadedKillTeamController() {
        let view = builder.createChooseLoadedKillTeamModule(router: self)
        editKillTeamNavigationController?.present(view as! UIViewController, animated: true, completion: nil)
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
        case .killTeamAbilitie:
            showKillTeamAbilitie()
        }
    }
}

enum NavigationFromCounterModule {
    case createNewKillTeam
    case loadKillTeam
    case editCurrentKillTeam
    case killTeamAbilitie
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

extension EeditKillTeamRouter: EditUnitPresenterDelegate {
    func didComplete(_ editUnitPresenter: EditUnitPresenter) {
        showKillTeamAbilitie()
    }
    
    
}

extension EeditKillTeamRouter: RosterPresenterDelegate {
    func didComplete(_ presenter: RosterPresenterProtocol) {
        showChooseKillTeamTableViewController()
    }
    
    
}
