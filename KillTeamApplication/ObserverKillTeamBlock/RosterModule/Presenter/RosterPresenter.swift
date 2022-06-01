//
//  RosterPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol RosterTableViewControllerProtocol: AnyObject {
    var presenter: RosterPresenterProtocol? { get }
}

protocol RosterPresenterDelegate: AnyObject {
    func didComplete(_ presenter: RosterPresenterProtocol)
}

protocol RosterPresenterProtocol: AnyObject {
    
    init(view: RosterTableViewControllerProtocol, store: StoreProtocol, router: KillTeamObserverRouterProtocol, userSettings: UserSettingsProtocol)
    var view: RosterTableViewControllerProtocol? { get }
    var userSettings: UserSettingsProtocol { get }
    var store: StoreProtocol { get }
    var model: RosterModel { get }
    func goToMoreInfoUnit(indexPath: IndexPath)
}

class RosterPresenter: RosterPresenterProtocol {
    
    weak var view: RosterTableViewControllerProtocol?
    
    let store: StoreProtocol
    
    let router: KillTeamObserverRouterProtocol
    
    let model = RosterModel()
    
    let userSettings: UserSettingsProtocol
    
    weak var delegate: RosterPresenterDelegate?
    
    required init(view: RosterTableViewControllerProtocol, store: StoreProtocol, router: KillTeamObserverRouterProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.store = store
        self.router = router
        self.userSettings = userSettings
        store.multicastDelegate.addDelegate(self)
    }
    
    func goToMoreInfoUnit(indexPath: IndexPath) {
        store.updateIndexObservedUnit(indexPath: indexPath)
        delegate?.didComplete(self)
    }

}


extension RosterPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        model.killTeam = killTeam
    }
}
