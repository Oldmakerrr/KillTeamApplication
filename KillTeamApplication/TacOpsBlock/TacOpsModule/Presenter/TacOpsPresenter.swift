//
//  TacOpsPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol TacOpsViewControllerProtocol: AnyObject {
    var presenter: TacOpsPresenterProtocol? { get }
    var tacOpsCollection: UICollectionView { get }
}

protocol TacOpsPresenterProtocol: AnyObject {
    init(view: TacOpsViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: TacOpsRouterProtocol)
    var view: TacOpsViewControllerProtocol? { get }
    var model: TacOpsModel { get }
    
    func pickTacOps(sender: TypeOfTacOps)
    func mixDeck()
    func mixDeckWithSpecialTacOps()
    func goToChoosenTacOps()
}

protocol TacOpsPresenterDelegate: AnyObject {
    func didComplete(_ presenter: TacOpsPresenter)
}

class TacOpsPresenter: TacOpsPresenterProtocol {
    
    weak var view: TacOpsViewControllerProtocol?
    
    weak var delegate: TacOpsPresenterDelegate?
    
    var gameStore: GameStoreProtocol
    
    var store: StoreProtocol
    
    var router: TacOpsRouterProtocol
    
    var model = TacOpsModel()
    
    private var selectedTacOp: TacOps?
    
    required init(view: TacOpsViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: TacOpsRouterProtocol) {
        self.view = view
        self.store = store
        self.gameStore = gameStore
        self.router = router
        gameStore.multicastDelegate.addDelegate(self)
        store.multicastDelegate.addDelegate(self)
        model.customTacOps = model.seekAndDestroy
    }
   
    
    func mixDeck() {
        var currentDeck = model.customTacOps
        var newDeck: [TacOps] = []
        for _ in model.customTacOps {
            let i = Int.random(in: 0..<currentDeck.count)
            let random = currentDeck[i]
            newDeck.append(random)
            currentDeck.remove(at: i)
        }
        model.customTacOps = newDeck
    }
    
    func goToChoosenTacOps() {
        delegate?.didComplete(self)
        gameStore.updateGameData(gameData: model.gameData)
    }
    
    func mixDeckWithSpecialTacOps() {
        var currentDeck = model.customTacOps
        if let killTeamTacOps = model.tacOpsKillTeam {
            killTeamTacOps.forEach { tacOp in
                currentDeck.append(tacOp)
            }
        }
        var newDeck: [TacOps] = []
        for _ in 0..<6 {
            let i = Int.random(in: 0..<currentDeck.count)
            let random = currentDeck[i]
            newDeck.append(random)
            currentDeck.remove(at: i)
        }
        model.customTacOps = newDeck
    }
   
    func pickTacOps(sender: TypeOfTacOps) {
        switch sender {
        case .seekandDestroy:
            model.customTacOps = model.seekAndDestroy
        case .security:
            model.customTacOps = model.security
        case .recon:
            model.customTacOps = model.recon
        case .infiltration:
            model.customTacOps = model.infiltration
        case .special:
            return
        }
        
    }
}

extension TacOpsPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        if let tacOps = killTeam?.tacOps {
            model.tacOpsKillTeam = tacOps
        }
    }
}

extension TacOpsPresenter: GameStoreDelegate {
    func didUpdate(_ gameStore: GameStore, gameData: GameData?) {
        if let gameData = gameData {
            model.gameData = gameData
        }
    }
}

extension TacOpsPresenter: TacOpsCollectionCellDelegate {
    
    func didSelect(_ cell: TacOpsCollectionCell) {
        
        switch cell.index {
        case 0, 1:
            model.gameData.firstTacOp = cell.tacOp
        case 2, 3:
            model.gameData.secondTacOp = cell.tacOp
        case 4, 5:
            model.gameData.thirdTacOp = cell.tacOp
        default:
            return
        }
        gameStore.updateGameData(gameData: model.gameData)
        view?.tacOpsCollection.reloadData()
    }
}
