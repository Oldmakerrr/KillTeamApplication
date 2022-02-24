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
    var selectedKillTeam: KillTeam? {get set}
    func goToEditKillTeamViewController(killTeam: KillTeam)
}

protocol ChooseKillTeamPresenterDelegate: AnyObject {
    func didComplete(presenter: ChooseKillTeamPresenterProtocol, sender: String)
}

class ChooseKillTeamPresenter: ChooseKillTeamPresenterProtocol {
    
    var store: StoreProtocol
    weak var view: ChooseKillTeamViewProtocol?
    weak var delegate: ChooseKillTeamPresenterDelegate?
    var model = AllKillTeam()
    var selectedKillTeam: KillTeam?
    private var keysForKillTeam: [String] = []
    
    
    required init(view: ChooseKillTeamViewProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        self.store.multicastDelegate.addDelegate(self)
       // if let keys = KeySaver.getKey() {
       //     keysForKillTeam = keys
       // }
       // for key in keysForKillTeam {
       //     if let killTeam = loadMyKillTeam(key: key) {
       //         model.loadedKillTeam.append(killTeam)
       //     }
       // }
    }
    
    
    func loadMyKillTeam(key: String) -> KillTeam? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            return try? PropertyListDecoder().decode(KillTeam.self, from: data)
        } else { return nil }
    }
    
    
    
    
    func goToEditKillTeamViewController(killTeam: KillTeam) {
        let sender = "forward"
        delegate?.didComplete(presenter: self, sender: sender)
        store.addKillTeam(killTeam: killTeam)
    }
}

extension ChooseKillTeamPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
    }
}
