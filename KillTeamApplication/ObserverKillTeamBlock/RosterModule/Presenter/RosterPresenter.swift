//
//  RosterPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

protocol RosterTableViewControllerProtocol: AnyObject {
    var presenter: RosterPresenterProtocol? { get }
}

protocol RosterPresenterDelegate: AnyObject {
    func didComplete(_ presenter: RosterPresenterProtocol)
}

protocol RosterPresenterProtocol: AnyObject {
    
    init(view: RosterTableViewControllerProtocol, store: StoreProtocol, router: KillTeamObserverRouterProtocol)
    var view: RosterTableViewControllerProtocol? { get }
    var store: StoreProtocol { get }
    var model: RosterModel { get }
    func goToMoreInfoUnit(indexPath: IndexPath)
}

class RosterPresenter: RosterPresenterProtocol {
    
    weak var view: RosterTableViewControllerProtocol?
    
    var store: StoreProtocol
    
    var router: KillTeamObserverRouterProtocol
    
    let model = RosterModel()
    
    weak var delegate: RosterPresenterDelegate?
    
    required init(view: RosterTableViewControllerProtocol, store: StoreProtocol, router: KillTeamObserverRouterProtocol) {
        self.view = view
        self.store = store
        self.router = router
        store.multicastDelegate.addDelegate(self)
    }
    
    func goToMoreInfoUnit(indexPath: IndexPath) {
        delegate?.didComplete(self)
       // store.updateChoosenUnit(unit: unit)
        store.addIndexOfChoosenUnit(index: indexPath)
    }

}


extension RosterPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        model.killTeam = killTeam
    }
}
