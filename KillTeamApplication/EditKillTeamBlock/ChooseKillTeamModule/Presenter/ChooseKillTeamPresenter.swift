//
//  ChooseKillTeamPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol ChooseKillTeamViewProtocol: AnyObject {
        
}

protocol ChooseKillTeamPresenterProtocol: AnyObject {
    init(view: ChooseKillTeamViewProtocol, store: StoreProtocol, storage: StorageProtocol)
    var model: AllKillTeam { get }
    var store: StoreProtocol { get }
    func goToEditKillTeamViewController(killTeam: KillTeam)
}

protocol ChooseKillTeamPresenterDelegate: AnyObject {
    func didComplete(presenter: ChooseKillTeamPresenterProtocol)
}

class ChooseKillTeamPresenter: ChooseKillTeamPresenterProtocol {
    
    let store: StoreProtocol
    weak var view: ChooseKillTeamViewProtocol?
    weak var delegate: ChooseKillTeamPresenterDelegate?
    let model = AllKillTeam()
    let storage: StorageProtocol
    
    
    required init(view: ChooseKillTeamViewProtocol, store: StoreProtocol, storage: StorageProtocol) {
        self.view = view
        self.store = store
        model.allFaction = store.allFaction
        self.storage = storage
    }
    
    func goToEditKillTeamViewController(killTeam: KillTeam) {
        //guard let key = killTeam.id else { return }
        delegate?.didComplete(presenter: self)
        store.updateCurrentKillTeam(killTeam: killTeam)
        storage.appendNewKillTeam(killTeam: killTeam)
        //store.appendNewKillTeam(killTeam: killTeam)
        //store.appendNewKey(key: key)
        //KeySaver.saveKey(key: store.keysForKillTeam)
    }
}
