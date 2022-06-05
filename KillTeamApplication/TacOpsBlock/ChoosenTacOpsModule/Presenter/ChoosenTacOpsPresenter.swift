//
//  ChoosenTacOpsPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import Foundation
import UIKit

protocol ChoosenTacOpsViewControllerProtocol: AnyObject {
    var presenter: ChoosenTacOpsPresenterProtocol? { get }
    var choosenTacOpsCollectionView: UICollectionView { get }
}

protocol ChoosenTacOpsPresenterProtocol: AnyObject {
    init(view: ChoosenTacOpsViewControllerProtocol, gameStore: GameStoreProtocol, userSettings: UserSettingsProtocol)
    var userSettings: UserSettingsProtocol { get }
    var view: ChoosenTacOpsViewControllerProtocol? { get }
    var gameStore: GameStoreProtocol { get }
    var model: ChoosenTacOpsModel { get }
    
    func updateGameData()
}

class ChoosenTacOpsPresenter: ChoosenTacOpsPresenterProtocol {
    
    weak var view: ChoosenTacOpsViewControllerProtocol?
    
    var model = ChoosenTacOpsModel()
    
    var gameStore: GameStoreProtocol
    
    let userSettings: UserSettingsProtocol
    
    required init(view: ChoosenTacOpsViewControllerProtocol, gameStore: GameStoreProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.gameStore = gameStore
        self.userSettings = userSettings
        gameStore.multicastDelegate.addDelegate(self)
    }
    
    func updateGameData() {
        gameStore.updateGameData(gameData: model.gameData)
    }
}


extension ChoosenTacOpsPresenter: GameStoreDelegate {
    func didUpdate(_ gameStore: GameStore, gameData: GameData?) {
        if let gameData = gameData {
            model.gameData = gameData
        }
    }
    
    private func addVictoryPoint(isSelect: Bool, victoryPoint: Int?) {
        guard model.gameData.countTurningPoint != 0, let victoryPoint = victoryPoint else { return }
        if isSelect {
            if model.gameData.countVictoryPoint > 0 {
                model.gameData.countVictoryPoint -= victoryPoint
            }
        } else {
            model.gameData.countVictoryPoint += victoryPoint
        }
    }
    
    func changeConditionState(_ isSelect: Bool) -> Bool {
       return isSelect ?  false : true
    }
}

extension ChoosenTacOpsPresenter: ChoosenTacOpViewDelegate {
    
    func didSelectConditionView(_ tacOpView: ChoosenTacOpView, isSelect: Bool, indexPath: IndexPath?, numberOfCondition: Int) {
        
            switch indexPath?.item {
            case 0:
                model.gameData.firstTacOp?.isCompleteConditions[numberOfCondition] = changeConditionState(isSelect)
                addVictoryPoint(isSelect: isSelect, victoryPoint: model.gameData.firstTacOp?.victoryPoint[numberOfCondition])
            case 1:
                model.gameData.secondTacOp?.isCompleteConditions[numberOfCondition] = changeConditionState(isSelect)
                addVictoryPoint(isSelect: isSelect, victoryPoint: model.gameData.secondTacOp?.victoryPoint[numberOfCondition])
            case 2:
                model.gameData.thirdTacOp?.isCompleteConditions[numberOfCondition] = changeConditionState(isSelect)
                addVictoryPoint(isSelect: isSelect, victoryPoint: model.gameData.thirdTacOp?.victoryPoint[numberOfCondition])
            default:
                return
            }
        
        updateGameData()
        view?.choosenTacOpsCollectionView.reloadData()
    }
    
    
}
