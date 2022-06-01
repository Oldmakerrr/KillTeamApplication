//
//  PloysPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol PloysViewControllerProtocol: AnyObject {
    var presenter: PloysPresenterProtocol? { get }
}

protocol PloysPresenterProtocol: AnyObject {
    init(view: PloysViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: PloysRouterProtocol, userSettings: UserSettingsProtocol)
    var view: PloysViewControllerProtocol? { get }
    var gameStore: GameStoreProtocol { get }
    var store: StoreProtocol { get }
    var userSettings: UserSettingsProtocol { get }
    var model: PloysModel { get }
    var router: PloysRouterProtocol { get }
    
    func addPloy(ploy: Ploy)
    func goToPsychicPowerViewController()
    func goToKillTeamAbilitieViewController() 
}

protocol PloysPresenterDelegate: AnyObject {
    func didComplete(_ presenter: PloysPresenter, sender: GoFromPloysModule)
}

enum GoFromPloysModule {
    case psychicPowerModule
    case killTeamAbilitieModule
}

class PloysPresenter: PloysPresenterProtocol {
    
    weak var delegate: PloysPresenterDelegate?
    
    weak var view: PloysViewControllerProtocol?
    
    let store: StoreProtocol
    
    let gameStore: GameStoreProtocol
    
    let model = PloysModel()
   
    let router: PloysRouterProtocol
    
    let userSettings: UserSettingsProtocol
    
    required init(view: PloysViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: PloysRouterProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.store = store
        self.gameStore = gameStore
        self.router = router
        self.userSettings = userSettings
        gameStore.multicastDelegate.addDelegate(self)
        store.multicastDelegate.addDelegate(self)
        //model.tacticalPloy.append(model.reRoll)
    }
    
    func addPloy(ploy: Ploy) {
        model.gameData.currentStrategicPloys.append(ploy)
        gameStore.updateGameData(gameData: model.gameData)
    }
    
    func goToPsychicPowerViewController() {
        guard let killTeam = model.killTeam else { return }
        delegate?.didComplete(self, sender: .psychicPowerModule)
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
    
    func goToKillTeamAbilitieViewController() {
        guard let killTeam = model.killTeam else { return }
        delegate?.didComplete(self, sender: .killTeamAbilitieModule)
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
}

extension PloysPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        model.strategicPloy = []
        model.tacticalPloy = []
        guard let killTeam = killTeam else { return }
        model.killTeam = killTeam
        killTeam.ploys.forEach({ ploy in
            switch ploy.type {
            case .strategic:
                model.strategicPloy.append(ploy)
            case .tactical:
                model.tacticalPloy.append(ploy)
            }
        })
    }
}

extension PloysPresenter: GameStoreDelegate {
    func didUpdate(_ gameStore: GameStore, gameData: GameData?) {
        if let gameData = gameData {
            model.gameData = gameData
        }
    }
}
