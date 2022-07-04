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
    func removeMyKillTeam(indexPath: IndexPath, uid: String)
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
        self.model.loadedKillTeam = storage.loadSavedKillTeam()
//            storage.loadSavedKillTeam { killTeams in
//                self.model.loadedKillTeam = killTeams
//            }
       // model.loadedKillTeam = storage.loadedKillTeam
    }
    
    func chooseKillTeam(killTeam: KillTeam) {
        var killTeam = killTeam
        killTeam.updateCurrentWounds()
        delegate?.didComplete(self)
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
    
    func removeMyKillTeam(indexPath: IndexPath, uid: String) {
        model.loadedKillTeam.remove(at: indexPath.row)
        storage.removeKillTeam(indexPath: indexPath, uid: uid)
    }
        
}
