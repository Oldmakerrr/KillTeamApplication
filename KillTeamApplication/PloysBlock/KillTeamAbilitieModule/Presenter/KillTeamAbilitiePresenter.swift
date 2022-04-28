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
    var store: StoreProtocol { get }
    init(view: KillTeamAbilitieViewControllerProtocol, store: StoreProtocol)
}

class KillTeamAbilitiePresenter: KillTeamAbilitiePresenterProtocol {
   
    weak var view: KillTeamAbilitieViewControllerProtocol?
    let model = KillTeamAbilitieModel()
    let store: StoreProtocol
    
    required init(view: KillTeamAbilitieViewControllerProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        store.multicastDelegate.addDelegate(self)
        
    }
    
}

extension KillTeamAbilitiePresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let abilitiesOfKillTeam = killTeam?.abilitiesOfKillTeam else { return }
        model.abilitie = abilitiesOfKillTeam
    }
    
    
}
