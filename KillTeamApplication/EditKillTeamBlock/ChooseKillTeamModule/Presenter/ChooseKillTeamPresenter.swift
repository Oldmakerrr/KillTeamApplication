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
    func filterContent(searchText: String?)
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
        delegate?.didComplete(presenter: self)
        store.updateCurrentKillTeam(killTeam: killTeam)
        storage.appendNewKillTeam(killTeam: killTeam)
    }
    
    func filterContent(searchText: String?) {
        guard let searchText = searchText else { return }
        var filteredArray = [KillTeam]()
        for faction in model.allFaction {
            filteredArray += faction.killTeam.filter{ killTeam in
                let searchedFaction = killTeam.killTeamName.lowercased().contains(searchText.lowercased())
                return searchedFaction
            }
        }
        model.filteredArrayOfKillTeam = filteredArray
    }
}

