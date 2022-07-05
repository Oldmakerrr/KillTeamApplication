//
//  KillTeamAbilitiePresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import Foundation

protocol KillTeamAbilitieViewControllerProtocol: AnyObject {
    var presenter: KillTeamAbilitiePresenterProtocol? { get }
}

protocol KillTeamAbilitiePresenterProtocol: AnyObject {
    var view: KillTeamAbilitieViewControllerProtocol? { get }
    var model: KillTeamAbilitieModel { get }
    var gameStore: GameStoreProtocol { get }
    var store: StoreProtocol { get }
    init(view: KillTeamAbilitieViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol)
}

class KillTeamAbilitiePresenter: KillTeamAbilitiePresenterProtocol {
   
    weak var view: KillTeamAbilitieViewControllerProtocol?
    let model = KillTeamAbilitieModel()
    let store: StoreProtocol
    let gameStore: GameStoreProtocol
    
    required init(view: KillTeamAbilitieViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol) {
        self.view = view
        self.store = store
        self.gameStore = gameStore
        store.multicastDelegate.addDelegate(self)
        
    }
    
}

extension KillTeamAbilitiePresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let abilitiesOfKillTeam = killTeam?.abilityOfKillTeam else { return }
        model.abilitie = abilitiesOfKillTeam
    }
    
    
}
