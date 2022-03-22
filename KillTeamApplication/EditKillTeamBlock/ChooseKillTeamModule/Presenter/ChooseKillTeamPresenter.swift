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
        model.allFaction += killTeamFromJson()
    }
    
    func killTeamFromJson() -> [Faction] {
        let path = Bundle.main.path(forResource: "AllFactionV1 ", ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        return try! JSONDecoder().decode([Faction].self, from: jsonData! as Data)
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
