//
//  ChosenTacOpsPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import Foundation
import UIKit

protocol ChosenTacOpsViewControllerProtocol: AnyObject {
    var presenter: ChosenTacOpsPresenterProtocol? { get }
    var choosenTacOpsCollectionView: UICollectionView { get }
}

protocol ChosenTacOpsPresenterProtocol: AnyObject {
    init(view: ChosenTacOpsViewControllerProtocol, gameStore: GameStoreProtocol, userSettings: UserSettingsProtocol)
    var userSettings: UserSettingsProtocol { get }
    var view: ChosenTacOpsViewControllerProtocol? { get }
    var gameStore: GameStoreProtocol { get }
    var model: ChosenTacOpsModel { get }
    
    func updateGameData()
}

class ChosenTacOpsPresenter: ChosenTacOpsPresenterProtocol {
    
    weak var view: ChosenTacOpsViewControllerProtocol?
    
    var model = ChosenTacOpsModel()
    
    var gameStore: GameStoreProtocol
    
    let userSettings: UserSettingsProtocol
    
    required init(view: ChosenTacOpsViewControllerProtocol, gameStore: GameStoreProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.gameStore = gameStore
        self.userSettings = userSettings
        gameStore.multicastDelegate.addDelegate(self)
    }
    
    func updateGameData() {
        gameStore.updateGameData(gameData: model.gameData)
    }
}


extension ChosenTacOpsPresenter: GameStoreDelegate {
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

extension ChosenTacOpsPresenter: ChosenTacOpViewDelegate {
    
    func didSelectConditionView(_ tacOpView: ChosenTacOpView, isSelect: Bool, indexPath: IndexPath?, numberOfCondition: Int) {
        switch indexPath?.item {
        case 0:
            model.gameData.firstTacOp?.isCompletedConditions[numberOfCondition] = changeConditionState(isSelect)
            addVictoryPoint(isSelect: isSelect, victoryPoint: model.gameData.firstTacOp?.victoryPoint[numberOfCondition])
        case 1:
            model.gameData.secondTacOp?.isCompletedConditions[numberOfCondition] = changeConditionState(isSelect)
            addVictoryPoint(isSelect: isSelect, victoryPoint: model.gameData.secondTacOp?.victoryPoint[numberOfCondition])
        case 2:
            model.gameData.thirdTacOp?.isCompletedConditions[numberOfCondition] = changeConditionState(isSelect)
            addVictoryPoint(isSelect: isSelect, victoryPoint: model.gameData.thirdTacOp?.victoryPoint[numberOfCondition])
        default:
            return
        }
        updateGameData()
        view?.choosenTacOpsCollectionView.reloadData()
    }
    
}
