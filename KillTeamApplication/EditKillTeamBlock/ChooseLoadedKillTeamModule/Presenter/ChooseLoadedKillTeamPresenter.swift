//
//  ChooseLoadedKillTeamPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol ChooseLoadedKillTeamControllerProtocol: AnyObject {
    var presenter: ChooseLoadedKillTeamPresenterProtocol? { get }
}

protocol ChooseLoadedKillTeamPresenterProtocol: AnyObject {
    init(view: ChooseLoadedKillTeamControllerProtocol, store: StoreProtocol, storage: StorageProtocol)
    var view: ChooseLoadedKillTeamControllerProtocol? { get }
    var store: StoreProtocol { get }
    var model: ChooseLoadedKillTeamModel { get }
    func chooseKillTeam(killTeam: KillTeam)
    func removeMyKillTeam(indexPath: IndexPath, view: UITableViewController)
    func removeKillTeamSwipeAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction
}

protocol ChooseLoadedKillTeamPresenterDelegate: AnyObject {
    func didComplete(_ presenter: ChooseLoadedKillTeamPresenterProtocol)
}

class ChooseLoadedKillTeamPresenter: ChooseLoadedKillTeamPresenterProtocol {
    
    weak var view: ChooseLoadedKillTeamControllerProtocol?
    
    let store: StoreProtocol
    
    let model = ChooseLoadedKillTeamModel()
    
    let storage: StorageProtocol
    
    weak var delegate: ChooseLoadedKillTeamPresenterDelegate?
    
    required init(view: ChooseLoadedKillTeamControllerProtocol, store: StoreProtocol, storage: StorageProtocol) {
        self.view = view
        self.store = store
        self.storage = storage
        model.loadedKillTeam = storage.loadedKillTeam
    }
    
    func chooseKillTeam(killTeam: KillTeam) {
        var killTeam = killTeam
        killTeam.updateCurrentWounds()
        delegate?.didComplete(self)
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
    
    func removeMyKillTeam(indexPath: IndexPath, view: UITableViewController) {
        model.loadedKillTeam.remove(at: indexPath.row)
        storage.removeKillTeam(indexPath: indexPath)
        view.tableView.reloadData()
    }
    
    func removeKillTeamSwipeAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction {
        let removeSwipe = UIContextualAction(style: .destructive, title: "Remove") { _, _, completion in
            self.removeMyKillTeam(indexPath: indexPath, view: view)
            completion(true)
        }
        removeSwipe.backgroundColor = .red
        removeSwipe.image = UIImage(systemName: "minus.square.fill")
        return removeSwipe
    }
    
}
