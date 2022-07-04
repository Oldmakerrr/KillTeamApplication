//
//  CounterPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol CounterViewProtocol: AnyObject {
    
    var currentKillTeamView: CurrentKillTeamView { get }
    
    var commandPoint: CounterPointView { get }
    var victoryPoint: CounterPointView { get }
    var killTeamAbilitiePoint: CounterPointView? { get }
    
    var turningPointLabel: CounterLabel { get }
    var currentAbilitieButton: ChangeTurnButton { get }
    
    var nextTurnButton: ChangeTurnButton { get }
    var endGameButton: ChangeTurnButton { get }
    
    func makeButtonEnable()
    func currentPloysViewState()
    func showAddButtonAndCurrentKillTeamView(complition: ((Bool) -> Void)?)
}

protocol CounterPresenterProtocol: AnyObject {
    init (view: CounterViewProtocol, router: EditKillTeamRouterProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, storage: StorageProtocol, userSettings: UserSettingsProtocol)
    var model: CounterModel {get set}
    var store: StoreProtocol {get}
    var gameStore: GameStoreProtocol { get }
    var userSettings: UserSettingsProtocol { get set }
    
    func showKillTeamAbilitieViewController()
    func buttonAction(sender: UIButton)
    func addKillTeam()
    
}

protocol CounterPresenterDelegate: AnyObject {
    func didComplete(_ presenter: CounterPresenterProtocol, sender: NavigationFromCounterModule)
}

class CounterPresenter: CounterPresenterProtocol {
    
    let router: EditKillTeamRouterProtocol
    
    let store: StoreProtocol
    
    let storage: StorageProtocol
    
    let gameStore: GameStoreProtocol
    
    var userSettings: UserSettingsProtocol
    
    weak var view: CounterViewProtocol?
    
    weak var delegate: CounterPresenterDelegate?
    
    var model = CounterModel() {
        didSet {
            updateTextLabel()
        }
    }
    
    required init(view: CounterViewProtocol, router: EditKillTeamRouterProtocol, store: StoreProtocol, gameStore: GameStoreProtocol, storage: StorageProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.router = router
        self.store = store
        self.storage = storage
        self.gameStore = gameStore
        self.userSettings = userSettings
        self.gameStore.multicastDelegate.addDelegate(self)
        self.store.multicastDelegate.addDelegate(self)
        self.storage.parseJson.parseJson(store: store, storage: storage) {
            self.storage.loadLastUsedKillTeam { killTeam in
                if let killTeam = killTeam {
                    store.updateCurrentKillTeam(killTeam: killTeam)
                    view.currentKillTeamView.setupText(killTeam: killTeam)
                }
                view.showAddButtonAndCurrentKillTeamView { _ in
                    view.currentKillTeamView.addTapGesture()
                    view.makeButtonEnable()
                }
                
            }
        }
    }
    
    @objc func showChooseKillTeamTableViewController() {
        delegate?.didComplete(self, sender: .createNewKillTeam)
     }
    
    @objc func showChooseLoadedKillTeamTableViewController() {
        delegate?.didComplete(self, sender: .loadKillTeam)
     }
    
    func showKillTeamAbilitieViewController() {
        delegate?.didComplete(self, sender: .killTeamAbilitie)
    }
    
    private func createTitleForAbilitieView() -> String {
        var title = String()
        if model.killTeam?.abilityOfKillTeam is HunterCladeAbility {
            title = ""
        }
        if model.killTeam?.abilityOfKillTeam is VoidDancerTroupeAbility {
            title = "Selected Allegory:"
        }
        return title
    }
    
    func updateTextLabel() {
        view?.turningPointLabel.text = "Turning point \(model.gameData.countTurningPoint)"
        view?.commandPoint.label.text = "Command Point = \(model.gameData.countCommandPoint)"
        view?.victoryPoint.label.text = "Victory Point = \(model.gameData.countVictoryPoint)"
        view?.killTeamAbilitiePoint?.label.text = "\(view?.killTeamAbilitiePoint?.title ?? "") = \(model.gameData.countKillTeamAbilitiePoint ?? 0)"
        if let abilitieName = model.gameData.currentAbilitie {
            view?.currentAbilitieButton.setTitle("\(createTitleForAbilitieView()) \(abilitieName)", for: .normal)
        }
        if model.gameData.countTurningPoint > 0 {
            view?.endGameButton.isHidden = false
            view?.commandPoint.minusButton.isEnabled = true
            view?.commandPoint.plusButton.isEnabled = true
            view?.victoryPoint.minusButton.isEnabled = true
            view?.victoryPoint.plusButton.isEnabled = true
            view?.killTeamAbilitiePoint?.plusButton.isEnabled = true
            view?.killTeamAbilitiePoint?.minusButton.isEnabled = true
        } else {
            view?.endGameButton.isHidden = true
            view?.commandPoint.minusButton.isEnabled = false
            view?.commandPoint.plusButton.isEnabled = false
            view?.victoryPoint.minusButton.isEnabled = false
            view?.victoryPoint.plusButton.isEnabled = false
            view?.killTeamAbilitiePoint?.plusButton.isEnabled = false
            view?.killTeamAbilitiePoint?.minusButton.isEnabled = false
        }
        
        if model.gameData.countTurningPoint == 0 {
            view?.nextTurnButton.setTitle("Start Game", for: .normal)
        } else {
            view?.nextTurnButton.setTitle("Next Turn", for: .normal)
        }
    }
    
    private func plusActOfFaithPointPerTurn() {
        guard var point = model.gameData.countKillTeamAbilitiePoint else { return }
        point += 3
        model.gameData.countKillTeamAbilitiePoint = point
    }
    
    private func actOfFaithPointEndGame() {
        guard var point = model.gameData.countKillTeamAbilitiePoint else { return }
        point = 0
        model.gameData.countKillTeamAbilitiePoint = point
    }
    
    func addKillTeam(){
        if !storage.isKeysEmpty() {
            let addKillTeamAlertController = UIAlertController(title: "Add Kill Team", message: "Create a new Kill Team or choose existed", preferredStyle: .actionSheet)
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
            view.present(addKillTeamAlertController, animated: true)
        } else {
            showChooseKillTeamTableViewController()
        }
    }
    
//MARK: - TurningPointButtonAction
    
    func buttonAction(sender: UIButton) {
        guard let view = view else { return }
        switch sender {
        case view.nextTurnButton:
            nextTurnButtonAction(view: view)
        case view.endGameButton:
            endGameButtonAction(view: view)
        default:
            return
        }
        gameStore.updateGameData(gameData: model.gameData)
    }
    
    private func nextTurnButtonAction(view: CounterViewProtocol) {
        if model.gameData.countTurningPoint == 0 {
            plusActOfFaithPointPerTurn()
            if var killTeam = model.killTeam {
                killTeam.updateCurrentWounds()
                store.updateCurrentKillTeam(killTeam: killTeam)
            }
            model.gameData.countTurningPoint += 1
            model.gameData.countCommandPoint += 3
        } else {
            plusActOfFaithPointPerTurn()
            model.gameData.currentStrategicPloys = []
            view.currentPloysViewState()
            model.gameData.countTurningPoint += 1
            model.gameData.countCommandPoint += 1
        }
    }
    
    private func endGameButtonAction(view: CounterViewProtocol) {
        if var killTeam = model.killTeam {
            killTeam.updateCurrentWounds()
            store.updateCurrentKillTeam(killTeam: killTeam)
        }
        actOfFaithPointEndGame()
        model.gameData.countCommandPoint = 0
        model.gameData.countTurningPoint = 0
        model.gameData.countVictoryPoint = 0
        model.gameData.currentStrategicPloys = []
        model.gameData.firstTacOp = nil
        model.gameData.secondTacOp = nil
        model.gameData.thirdTacOp = nil
        gameStore.updateGameData(gameData: model.gameData)
        view.currentPloysViewState()
    }
    
    private func isExistKillTeamAbilitie(killTeam: KillTeam?) {
        guard let abilitie = killTeam?.abilityOfKillTeam else {
            model.gameData.countKillTeamAbilitiePoint = nil
            return }
        novitiateAbilitie(abilite: abilitie)
        gameStore.updateGameData(gameData: model.gameData)
    }
    
    private func novitiateAbilitie(abilite: KillTeamAbility) {
        guard abilite is NovitiateAbility else { return }
        if model.gameData.countKillTeamAbilitiePoint == nil {
            model.gameData.countKillTeamAbilitiePoint = 0
        }
    }
    
}

extension CounterPresenter: CounterPointViewDelegate {
    func didComplete(_ counterPointView: CounterPointView, sender: UIButton) {
        switch counterPointView {
        case view?.commandPoint:
            switch sender {
            case counterPointView.plusButton:
                model.gameData.countCommandPoint += 1
            case counterPointView.minusButton:
                model.gameData.countCommandPoint = model.gameData.countCommandPoint > 0 ? model.gameData.countCommandPoint - 1 : 0
            default:
                break
            }
        case view?.victoryPoint:
            switch sender {
            case counterPointView.plusButton:
                model.gameData.countVictoryPoint += 1
            case counterPointView.minusButton:
                model.gameData.countVictoryPoint = model.gameData.countVictoryPoint > 0 ? model.gameData.countVictoryPoint - 1 : 0
            default:
                break
            }
        case view?.killTeamAbilitiePoint:
            guard var abilitiePoint = model.gameData.countKillTeamAbilitiePoint else { return }
            switch sender {
            case counterPointView.plusButton:
                abilitiePoint += 1
            case counterPointView.minusButton:
                abilitiePoint = abilitiePoint > 0 ? abilitiePoint - 1 : 0
            default:
                break
            }
            model.gameData.countKillTeamAbilitiePoint = abilitiePoint
        default:
            break
        }
        gameStore.updateGameData(gameData: model.gameData)
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
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        if killTeam?.killTeamName != model.killTeam?.killTeamName {
            model.gameData.currentAbilitie = nil
            model.gameData.currentStrategicPloys = []
            gameStore.updateGameData(gameData: model.gameData)
        }
        model.killTeam = killTeam
        isExistKillTeamAbilitie(killTeam: killTeam)
        view?.currentKillTeamView.setupText(killTeam: killTeam)
       
    }
}

extension CounterPresenter: CurrentKillTeamViewDelegate {
    func didComplete(_ currentKillTeamView: CurrentKillTeamView) {
        guard let killTeam = model.killTeam else {
            addKillTeam()
            return
        }
        delegate?.didComplete(self, sender: .editCurrentKillTeam)
        store.updateCurrentKillTeam(killTeam: killTeam)
    } 

    
}


extension CounterPresenter: AllegoryTableViewControllerDelegate {
    
    func didComplete(_ allegoryTableViewController: AllegoryTableViewController) {
        guard let view = view as? UIViewController else { return }
        allegoryTableViewController.dismiss(animated: true)
        view.showToast(message: "Allegory successfuly selected")
    }
    
}

extension CounterPresenter: ImperativeTableViewControllerDelegate {
    
    func didComplete(_ imperativeTableViewController: ImperativeTableViewController) {
        guard let view = view as? UIViewController else { return }
        imperativeTableViewController.dismiss(animated: true)
        view.showToast(message: "Imperative successfuly selected")
    }
    
}
