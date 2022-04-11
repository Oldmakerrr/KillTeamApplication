//
//  CounterPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol CounterViewProtocol: AnyObject {
    
    var currentKillTeamView: CurrentKillTeamView { get }
    
    var turningPointLabel: CounterLabel { get }
    var commandPointLabel: CounterLabel { get }
    var victoryPointLabel: CounterLabel { get }

    var plusCommandPoint: ChangePointButton { get }
    var minusCommandPoint: ChangePointButton { get }
    var plusVictoryPoint: ChangePointButton { get }
    var minusVictoryPoint: ChangePointButton { get }
    var nextTurnButton: ChangeTurnButton { get }
    var endGameButton: ChangeTurnButton { get }
    
    var currentStrategicPloyLabel: UILabel { get }
    var currentStrategicPloyButton: UIButton { get }
    
}

protocol CounterPresenterProtocol: AnyObject {
    init (view: CounterViewProtocol, router: EditKillTeamRouterProtocol, store: StoreProtocol, gameStore: GameStoreProtocol)
    var model: CounterModel {get set}
    var store: StoreProtocol {get}
    var gameStore: GameStoreProtocol { get }
    func showChooseKillTeamTableViewController()
    func showChooseLoadedKillTeamTableViewController()
    func buttonAction(sender: UIButton)
    func addKillTeam()
}

protocol CounterPresenterDelegate: AnyObject {
    func didComplete(_ presenter: CounterPresenterProtocol, sender: String)
}

class CounterPresenter: CounterPresenterProtocol {
    
    var router: EditKillTeamRouterProtocol
    
    var store: StoreProtocol
    
    var gameStore: GameStoreProtocol
    
    weak var view: CounterViewProtocol?
    
    weak var delegate: CounterPresenterDelegate?
    
    var model = CounterModel() {
        didSet {
            updateTextLabel()
        }
    }
    
    required init(view: CounterViewProtocol, router: EditKillTeamRouterProtocol, store: StoreProtocol, gameStore: GameStoreProtocol) {
        self.view = view
        self.router = router
        self.store = store
        self.gameStore = gameStore
        self.gameStore.multicastDelegate.addDelegate(self)
        self.store.multicastDelegate.addDelegate(self)
    }
    
    @objc func showChooseKillTeamTableViewController() {
        delegate?.didComplete(self, sender: "new")
     }
    
    @objc func showChooseLoadedKillTeamTableViewController() {
        delegate?.didComplete(self, sender: "loaded")
     }
    
    func updateTextLabel() {
        view?.commandPointLabel.text = "Command Point = \(model.gameData.countCommandPoint)"
        view?.victoryPointLabel.text = "Victory Point = \(model.gameData.countVictoryPoint)"
        view?.turningPointLabel.text = "Turning Point = \(model.gameData.countTurningPoint)"
        if model.gameData.countTurningPoint > 0 {
            view?.endGameButton.isHidden = false
        } else {
            view?.endGameButton.isHidden = true
        }
        
        if model.gameData.countTurningPoint == 0 {
            view?.nextTurnButton.setTitle("Start Game", for: .normal)
            view?.plusCommandPoint.isEnabled = false
            view?.plusVictoryPoint.isEnabled = false
            view?.minusCommandPoint.isEnabled = false
            view?.minusVictoryPoint.isEnabled = false
        } else {
            view?.nextTurnButton.setTitle("Next Turn", for: .normal)
            view?.plusCommandPoint.isEnabled = true
            view?.plusVictoryPoint.isEnabled = true
            view?.minusCommandPoint.isEnabled = true
            view?.minusVictoryPoint.isEnabled = true
        }
        
        if let ploy = model.gameData.currentStrategicPloy {
            view?.currentStrategicPloyLabel.text = "Strategic Ploy:"
            view?.currentStrategicPloyButton.setTitle("\(ploy.name)", for: .normal)
        } else {
            view?.currentStrategicPloyLabel.text = ""
            view?.currentStrategicPloyButton.setTitle("", for: .normal)
        }
    }
    
    func addKillTeam() {
        if !store.loadedKillTeam.isEmpty {
            let addKillTeamAlertController = UIAlertController(title: "Add Kill Team", message: "Create a new Kill Team or choose an existing.", preferredStyle: .actionSheet)
            let addNewKillTeamAlert = UIAlertAction(title: "Create", style: .default) { _ in
                self.showChooseKillTeamTableViewController()
            }
            let chooseKillTeamAlert = UIAlertAction(title: "Choose", style: .default) { _ in
                self.showChooseLoadedKillTeamTableViewController()
            }
            let cancleAlert = UIAlertAction(title: "Cancel", style: .cancel)
            addKillTeamAlertController.addAction(addNewKillTeamAlert)
            addKillTeamAlertController.addAction(chooseKillTeamAlert)
            addKillTeamAlertController.addAction(cancleAlert)
            let view = view as! UIViewController
            view.present(addKillTeamAlertController, animated: true) {
            }
        } else {
            showChooseKillTeamTableViewController()
        }
    }
    
    func buttonAction(sender: UIButton) {
        if let view = view {
            switch sender {
            case view.plusCommandPoint:
                model.gameData.countCommandPoint += 1
            case view.minusCommandPoint:
                if model.gameData.countCommandPoint > 0 {
                    model.gameData.countCommandPoint -= 1
                }
            case view.plusVictoryPoint:
                model.gameData.countVictoryPoint += 1
            case view.minusVictoryPoint:
                if model.gameData.countVictoryPoint > 0 {
                    model.gameData.countVictoryPoint -= 1
                }
            case view.nextTurnButton:
                if model.gameData.countTurningPoint == 0 {
                    model.gameData.countTurningPoint += 1
                    model.gameData.countCommandPoint += 3
                } else {
                    model.gameData.currentStrategicPloy = nil
                    model.gameData.countTurningPoint += 1
                    model.gameData.countCommandPoint += 1
                }
            case view.endGameButton:
                model.gameData.countCommandPoint = 0
                model.gameData.countTurningPoint = 0
                model.gameData.countVictoryPoint = 0
                model.gameData.currentStrategicPloy = nil
                model.gameData.firstTacOp = nil
                model.gameData.secondTacOp = nil
                model.gameData.thirdTacOp = nil
                gameStore.updateGameData(gameData: model.gameData)
            default:
                return
            }
            gameStore.updateGameData(gameData: model.gameData)
        }
    }
}

extension CounterPresenter: GameStoreDelegate {
    func didUpdate(_ gameStore: GameStore, gameData: GameData?) {
        if let gameData = gameData {
            model.gameData = gameData
        }
    }
}

extension CounterPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        model.killTeam = killTeam
    }
}
