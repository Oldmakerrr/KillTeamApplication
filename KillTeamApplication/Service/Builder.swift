//
//  Builder.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol BuilderProtocol {
    func createCounterModule(router: EditKillTeamRouterProtocol) -> CounterViewProtocol
    func createChooseKillTeamModule(router: EditKillTeamRouterProtocol) -> ChooseKillTeamViewProtocol
    func createEditKillTeamModule(router: EditKillTeamRouterProtocol) -> EditKillTeamProtocol
    func createAddFireTeamModule(router: EditKillTeamRouterProtocol) -> AddFireTeamTableVCProtocol
    func createEditUnitModule(router: EditKillTeamRouterProtocol) -> EditUnitViewControllerProtocol
    func createChooseLoadedKillTeamModule(router: EditKillTeamRouterProtocol) -> ChooseLoadedKillTeamControllerProtocol
    
    func createRosterModule(router: KillTeamObserverRouterProtocol) -> RosterTableViewControllerProtocol
    func createMoreInfooUnitModule(router: KillTeamObserverRouterProtocol) -> MoreInfoUnitViewControllerProtocol
    
    func createPloysModule(router: PloysRouterProtocol) -> PloysViewControllerProtocol
    
    func createTacOpsModule(router: TacOpsRouterProtocol) -> TacOpsViewControllerProtocol
    func createChoosenTacOpsModule(router: TacOpsRouterProtocol) -> ChoosenTacOpsViewControllerProtocol
}

class ModuleBuilder: BuilderProtocol {
    
    let store: StoreProtocol
    let gameStore: GameStoreProtocol
    
    init (store: StoreProtocol, gameStore: GameStoreProtocol) {
        self.store = store
        self.gameStore = gameStore
    }
    
//MARK: - EditKillTeam
    
    func createCounterModule(router: EditKillTeamRouterProtocol) -> CounterViewProtocol{
        let view = CounterViewController()
        let presenter = CounterPresenter(view: view, router: router, store: store, gameStore: gameStore)
        view.presenter = presenter
        presenter.delegate = router as? CounterPresenterDelegate
        return view
    }
    
    func createChooseKillTeamModule(router: EditKillTeamRouterProtocol) -> ChooseKillTeamViewProtocol {
        let view = ChooseKillTeamTableViewController()
        let presenter = ChooseKillTeamPresenter(view: view, store: store)
        view.presenter = presenter
        presenter.delegate = router as? ChooseKillTeamPresenterDelegate
        return view
    }
    
    func createEditKillTeamModule(router: EditKillTeamRouterProtocol) -> EditKillTeamProtocol {
        let view = EditKillTeamTableViewController()
        let presenter = EditKillTeamPresenter(view: view, store: store)
        view.presenter = presenter
        presenter.delegate = router as? EditKillTeamPresenterDelegate
        return view
    }
    
    func createAddFireTeamModule(router: EditKillTeamRouterProtocol) -> AddFireTeamTableVCProtocol {
        let view = AddFireTeamViewController()
        let presenter = AddFireTeamPresenter(view: view, store: store)
        view.presenter = presenter
        return view
    }
    
    func createEditUnitModule(router: EditKillTeamRouterProtocol) -> EditUnitViewControllerProtocol {
        let view = EditUnitViewController()
        let presenter = EditUnitPresenter(view: view, store: store)
        view.presenter = presenter
        return view
        
    }
    
    func createChooseLoadedKillTeamModule(router: EditKillTeamRouterProtocol) -> ChooseLoadedKillTeamControllerProtocol {
        let view = ChooseLoadedKillTeamController()
        let presenter = ChooseLoadedKillTeamPresenter(view: view, store: store)
        view.presenter = presenter
        presenter.delegate = router as? ChooseLoadedKillTeamPresenterDelegate
        return view
    }

//MARK: - ObserverKillTeam

    func createRosterModule(router: KillTeamObserverRouterProtocol) -> RosterTableViewControllerProtocol {
        let view = RosterTableViewController()
        let presenter = RosterPresenter(view: view, store: store, router: router)
        view.presenter = presenter
        presenter.delegate = router as? RosterPresenterDelegate
        return view
    }
    
    func createMoreInfooUnitModule(router: KillTeamObserverRouterProtocol) -> MoreInfoUnitViewControllerProtocol {
        let view = MoreInfoUnitViewController()
        let presenter = MoreUnitInfoPresenter(view: view, store: store)
        view.presenter = presenter
        return view
    }
    
//MARK: - Ploys
    
    func createPloysModule(router: PloysRouterProtocol) -> PloysViewControllerProtocol {
        let view = PloysViewController()
        let presenter = PloysPresenter(view: view, store: store, gameStore: gameStore, router: router)
        view.presenter = presenter
        return view
    }


//MARK: - TacOps
    
    func createTacOpsModule(router: TacOpsRouterProtocol) -> TacOpsViewControllerProtocol {
        let view = TacOpsViewController()
        let presenter = TacOpsPresenter(view: view, store: store, gameStore: gameStore, router: router)
        view.presenter = presenter
        presenter.delegate = router as? TacOpsPresenterDelegate
        return view
    }

    func createChoosenTacOpsModule(router: TacOpsRouterProtocol) -> ChoosenTacOpsViewControllerProtocol {
        let view = ChoosenTacOpsViewController()
        let presenter = ChoosenTacOpsPresenter(view: view, gameStore: gameStore)
        view.presenter = presenter
        return view
    }
}
