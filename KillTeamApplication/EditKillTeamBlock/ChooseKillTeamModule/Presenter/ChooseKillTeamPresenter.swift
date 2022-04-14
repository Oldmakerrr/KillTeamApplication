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
    init(view: ChooseKillTeamViewProtocol, store: StoreProtocol)
    var model: AllKillTeam {get set}
    var store: StoreProtocol {get}
    func goToEditKillTeamViewController(killTeam: KillTeam)
}

protocol ChooseKillTeamPresenterDelegate: AnyObject {
    func didComplete(presenter: ChooseKillTeamPresenterProtocol)
}

class ChooseKillTeamPresenter: ChooseKillTeamPresenterProtocol {
    
    var store: StoreProtocol
    weak var view: ChooseKillTeamViewProtocol?
    weak var delegate: ChooseKillTeamPresenterDelegate?
    var model = AllKillTeam()
    
    
    required init(view: ChooseKillTeamViewProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        model.allFaction += store.allFaction
    }
    
    func goToEditKillTeamViewController(killTeam: KillTeam) {
        guard let key = killTeam.id else { return }
        delegate?.didComplete(presenter: self)
        store.updateCurrentKillTeam(killTeam: killTeam)
        store.appendNewKillTeam(killTeam: killTeam)
        store.appendNewKey(key: key)
        KeySaver.saveKey(key: store.keysForKillTeam)
    }
}
