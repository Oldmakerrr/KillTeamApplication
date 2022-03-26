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
    var goToChoosenTacOpsButton: UIBarButtonItem { get }
    var tacOpsCollection: UICollectionView { get }
}

protocol TacOpsPresenterProtocol: AnyObject {
    init(view: TacOpsViewControllerProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, router: TacOpsRouterProtocol)
    var view: TacOpsViewControllerProtocol? { get }
    var store: StoreProtocol { get }
    var gameStore: GameStoreProtocol { get }
    var router: TacOpsRouterProtocol { get }
    var model: TacOpsModel { get }
    func pickTacOps(sender: TypeOfTacOps)
    func mixDeck()
    func mixDeckWithSpecialTacOps()
    func selectTacOp(tacOp: TacOps, indexPath: IndexPath)
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
    
    var model = TacOpsModel() {
        didSet {
            if model.gameData.firstTacOp != nil && model.gameData.secondTacOp != nil && model.gameData.thirdTacOp != nil {
                view?.goToChoosenTacOpsButton.isEnabled = true
            }
        }
    }
    
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
    
    private func enableButton() {
        if model.gameData.firstTacOp != nil && model.gameData.secondTacOp != nil && model.gameData.thirdTacOp != nil {
            view?.goToChoosenTacOpsButton.isEnabled = true
        }
    }
    
    func mixDeck() {
        var currentDeck = model.customTacOps
        var newDeck: [TacOps] = []
        for tacOp in model.customTacOps {
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
        for j in 0..<6 {
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
    
    
    func selectTacOp(tacOp: TacOps, indexPath: IndexPath) {
        switch indexPath.item {
        case 0,1:
            model.gameData.firstTacOp = tacOp
            selectedTacOp = tacOp
        case 2,3:
            model.gameData.secondTacOp = tacOp
            selectedTacOp = tacOp
        case 4,5:
            model.gameData.thirdTacOp = tacOp
            selectedTacOp = tacOp
        default:
            return
        }
        gameStore.updateGameData(gameData: model.gameData)
    }
}

extension TacOpsPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        if let tacOps = killTeam.tacOps {
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
        guard let indexCell = cell.index, let tacOpCell = cell.tacOp, let anotherCell = view?.tacOpsCollection else { return }
        switch indexCell{
        case 0:
            if tacOpCell == model.gameData.firstTacOp {
                cell.contentView.backgroundColor = .orange
                anotherCell.visibleCells[1].contentView.backgroundColor = .systemGray2
            }
        case 1:
            if tacOpCell == model.gameData.firstTacOp {
                cell.contentView.backgroundColor = .orange
                anotherCell.visibleCells[0].contentView.backgroundColor = .systemGray2
            }
        case 2:
            if tacOpCell == model.gameData.secondTacOp {
                cell.contentView.backgroundColor = .orange
                anotherCell.visibleCells[3].contentView.backgroundColor = .systemGray2
            }
        case 3:
            if tacOpCell == model.gameData.secondTacOp {
                cell.contentView.backgroundColor = .orange
                anotherCell.visibleCells[2].contentView.backgroundColor = .systemGray2
            }
        case 4:
            if tacOpCell == model.gameData.thirdTacOp {
                cell.contentView.backgroundColor = .orange
                anotherCell.visibleCells[5].contentView.backgroundColor = .systemGray2
            }
        case 5:
            if tacOpCell == model.gameData.thirdTacOp {
                cell.contentView.backgroundColor = .orange
                anotherCell.visibleCells[4].contentView.backgroundColor = .systemGray2
            } 
        default:
            break
        }
    }
}
