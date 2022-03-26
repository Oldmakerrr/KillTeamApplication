//
//  PloysPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

protocol PloysViewControllerProtocol: AnyObject {
    var presenter: PloysPresenterProtocol? { get }
}

protocol PloysPresenterProtocol: AnyObject {
    init(view: PloysViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: PloysRouterProtocol)
    var view: PloysViewControllerProtocol? { get }
    var gameStore: GameStoreProtocol { get }
    var store: StoreProtocol { get }
    var model: PloysModel { get }
    var router: PloysRouterProtocol { get }
}

class PloysPresenter: PloysPresenterProtocol {
    
    weak var view: PloysViewControllerProtocol?
    
    var store: StoreProtocol
    
    var gameStore: GameStoreProtocol
    
    let model = PloysModel()
   
    var router: PloysRouterProtocol
    
    required init(view: PloysViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: PloysRouterProtocol) {
        self.view = view
        self.store = store
        self.gameStore = gameStore
        self.router = router
        gameStore.multicastDelegate.addDelegate(self)
        store.multicastDelegate.addDelegate(self)
       // model.tacticalPloy.append(model.reRoll)
    }
}

extension PloysPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        model.strategicPloy = []
        model.tacticalPloy = []
        killTeam.ploys.forEach({ ploy in
            switch ploy.type {
            case "strategic":
                model.strategicPloy.append(ploy)
            case "tactical":
                model.tacticalPloy.append(ploy)
            default:
                break
            }
        })
        //model.tacticalPloy.append(model.reRoll)
    }
}

extension PloysPresenter: GameStoreDelegate {
    func didUpdate(_ gameStore: GameStore, gameData: GameData?) {
        if let gameData = gameData {
            model.gameData = gameData
        }
    }
}
