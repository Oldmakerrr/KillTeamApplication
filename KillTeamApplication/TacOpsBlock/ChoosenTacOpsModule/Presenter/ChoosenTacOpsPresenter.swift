//
//  ChoosenTacOpsPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 22.02.2022.
//

import Foundation

protocol ChoosenTacOpsViewControllerProtocol: AnyObject {
    var presenter: ChoosenTacOpsPresenterProtocol? { get }
}

protocol ChoosenTacOpsPresenterProtocol: AnyObject {
    init(view: ChoosenTacOpsViewControllerProtocol, gameStore: GameStoreProtocol)
    var view: ChoosenTacOpsViewControllerProtocol? { get }
    var gameStore: GameStoreProtocol { get }
    var model: ChoosenTacOpsModel { get }
    
    func updateGameData()
}

class ChoosenTacOpsPresenter: ChoosenTacOpsPresenterProtocol {
    weak var view: ChoosenTacOpsViewControllerProtocol?
    var model = ChoosenTacOpsModel()
    var gameStore: GameStoreProtocol
    
    required init(view: ChoosenTacOpsViewControllerProtocol, gameStore: GameStoreProtocol) {
        self.view = view
        self.gameStore = gameStore
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
    
    
}
