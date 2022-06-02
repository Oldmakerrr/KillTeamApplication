//
//  TacOpsPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol TacOpsViewControllerProtocol: AnyObject {
    var goToChoosenTacOpsButton: UIButton { get }
    var presenter: TacOpsPresenterProtocol? { get }
    var tacOpsCollection: UICollectionView { get }
}

protocol TacOpsPresenterProtocol: AnyObject {
    init(view: TacOpsViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: TacOpsRouterProtocol, userSettings: UserSettingsProtocol)
    var view: TacOpsViewControllerProtocol? { get }
    var model: TacOpsModel { get }
    var userSettings: UserSettingsProtocol { get }
    
    func pickTacOps(sender: TypeOfTacOp, collectionView: UICollectionView)
    func mixDeck()
    func mixDeckWithSpecialTacOps()
    func goToChoosenTacOps()
    func checkSelectTacOp() -> Bool
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
    
    let userSettings: UserSettingsProtocol
    
    private var selectedTacOp: TacOp?
    
    required init(view: TacOpsViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: TacOpsRouterProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.store = store
        self.gameStore = gameStore
        self.router = router
        self.userSettings = userSettings
        gameStore.multicastDelegate.addDelegate(self)
        store.multicastDelegate.addDelegate(self)
        loadTacOps(tacOps: gameStore.tacOps)
        model.currentDeck = model.seekAndDestroyDeck
    }
    
//MARK: - AddTacOpsFromStore
   
    func loadTacOps(tacOps: [TacOp]) {
        tacOps.forEach { tacOp in
            switch tacOp.type {
            case .seekAndDestroy:
                model.seekAndDestroyDeck.append(tacOp)
            case .security:
                model.securityDeck.append(tacOp)
            case .infiltration:
                model.infiltrationDeck.append(tacOp)
            case .recon:
                model.reconDeck.append(tacOp)
            case .factionTacOp:
                return
            }
        }
    }
    
//MARK: - Methods work with deck
    
    private func prepareTacOp(tacOp: TacOp) -> TacOp {
        var tacOp = tacOp
        tacOp.isCompleteSubConditions = []
        tacOp.isCompleteSubConditions?.append(false)
        if tacOp.secondCondition != nil {
            tacOp.isCompleteSubConditions?.append(false)
        }
        if let subCondition = tacOp.subCondition {
            subCondition.forEach({ _ in
                tacOp.isCompleteSubConditions?.append(false)
            })
        }
        return tacOp
    }
    
    func mixDeck() {
        clearCurrentDeck()
        var currentDeck = model.currentDeck
        var newDeck: [TacOp] = []
        for _ in model.currentDeck {
            let i = Int.random(in: 0..<currentDeck.count)
            let random = currentDeck[i]
            newDeck.append(random)
            currentDeck.remove(at: i)
        }
        clearChoosenTacOps()
        model.currentDeck = newDeck
    }
    
    func mixDeckWithSpecialTacOps() {
        clearCurrentDeck()
        var currentDeck = model.currentDeck
        if let killTeamTacOps = model.factionDeck {
            killTeamTacOps.forEach { tacOp in
                currentDeck.append(tacOp)
            }
        }
        var newDeck: [TacOp] = []
        for _ in 0..<6 {
            let i = Int.random(in: 0..<currentDeck.count)
            let random = currentDeck[i]
            newDeck.append(random)
            currentDeck.remove(at: i)
        }
        clearChoosenTacOps()
        model.currentDeck = newDeck
    }
    
    func pickTacOps(sender: TypeOfTacOp, collectionView: UICollectionView) {
        switch sender {
        case .seekAndDestroy:
            model.currentDeck = model.seekAndDestroyDeck
            model.currentTypeDeck = .seekAndDestroy
        case .security:
            model.currentDeck = model.securityDeck
            model.currentTypeDeck = .security
        case .recon:
            model.currentDeck = model.reconDeck
            model.currentTypeDeck = .recon
        case .infiltration:
            model.currentDeck = model.infiltrationDeck
            model.currentTypeDeck = .infiltration
        case .factionTacOp:
            return
        }
        clearChoosenTacOps()
        collectionView.reloadData()
    }
    
    func checkSelectTacOp() -> Bool {
        if  model.gameData.firstTacOp != nil &&
            model.gameData.secondTacOp != nil &&
            model.gameData.thirdTacOp != nil {
            return true
        } else {
            return false
        }
    }
    
//MARK: - Update Deck state
    
    private func clearCurrentDeck() {
        switch model.currentTypeDeck {
        case .seekAndDestroy:
            model.currentDeck = model.seekAndDestroyDeck
        case .security:
            model.currentDeck = model.securityDeck
        case .recon:
            model.currentDeck = model.reconDeck
        case .infiltration:
            model.currentDeck = model.infiltrationDeck
        case .factionTacOp:
            return
        }
    }
    
    private func clearChoosenTacOps() {
        model.gameData.firstTacOp = nil
        model.gameData.secondTacOp = nil
        model.gameData.thirdTacOp = nil
        view?.goToChoosenTacOpsButton.isEnabled = checkSelectTacOp()
    }
    
    private func setupDefaultDeck(_ viewController: UIViewController) {
        model.currentDeck = model.seekAndDestroyDeck
        model.currentTypeDeck = .seekAndDestroy
        view?.tacOpsCollection.reloadData()
        viewController.navigationItem.title = "Seek & Destroy"
    }
    
//MARK: - NavigationMethod
    
    func goToChoosenTacOps() {
        delegate?.didComplete(self)
        gameStore.updateGameData(gameData: model.gameData)
    }
    
}

//MARK: - Extension

extension TacOpsPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let viewController = view as? UIViewController else { return }
        model.killTeam = killTeam
        if let tacOps = killTeam?.tacOps {
            model.factionDeck = tacOps
            if killTeam?.killTeamName != model.killTeam?.killTeamName {
                clearChoosenTacOps()
                setupDefaultDeck(viewController)
            }
        } else {
            model.factionDeck = nil
            clearChoosenTacOps()
            setupDefaultDeck(viewController)
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
        guard let tacOp = cell.tacOp else { return }
        switch cell.index {
        case 0, 1:
            model.gameData.firstTacOp = prepareTacOp(tacOp: tacOp)
        case 2, 3:
            model.gameData.secondTacOp = prepareTacOp(tacOp: tacOp)
        case 4, 5:
            model.gameData.thirdTacOp = prepareTacOp(tacOp: tacOp)
        default:
            return
        }
        gameStore.updateGameData(gameData: model.gameData)
        view?.tacOpsCollection.reloadData()
        view?.goToChoosenTacOpsButton.isEnabled = checkSelectTacOp()
    }
}
