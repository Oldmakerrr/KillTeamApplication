//
//  Builder.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol BuilderProtocol {
    func createCounterModule(router: RouterProtocol) -> CounterViewProtocol
    func createChooseKillTeamModule(router: RouterProtocol) -> ChooseKillTeamViewProtocol
    func createEditKillTeamModule(router: RouterProtocol) -> EditKillTeamProtocol
    func createAddFireTeamModule(router: RouterProtocol) -> AddFireTeamTableVCProtocol
    func createEditUnitModule(router: RouterProtocol) -> EditUnitViewControllerProtocol
    func createChooseLoadedKillTeamModule(router: RouterProtocol) -> ChooseLoadedKillTeamControllerProtocol
    
    func createRosterModule(router: RouterProtocol) -> RosterTableViewControllerProtocol
    func createMoreInfooUnitModule(router: RouterProtocol) -> MoreInfoUnitViewControllerProtocol
    
    func createPloysModule(router: RouterProtocol) -> PloysViewControllerProtocol
    func createPsychicPowerModule(router: RouterProtocol) -> PsychicPowerViewControllerProtocol
    func createKillTeamAbilitieModule(router: RouterProtocol) -> KillTeamAbilitieViewControllerProtocol
    
    func createTacOpsModule(router: RouterProtocol) -> TacOpsViewControllerProtocol
    func createChoosenTacOpsModule(router: RouterProtocol) -> ChoosenTacOpsViewControllerProtocol
    
    func createKillTeamImperativesList(router: RouterProtocol, delegate: ImperativeTableViewControllerDelegate) -> ImperativeTableViewController?
    func createKillTeamAllegoryList(router: RouterProtocol, delegate: AllegoryTableViewControllerDelegate) -> AllegoryTableViewController?
    func createChaosBlessingList(router: RouterProtocol, delegate: ChaosBlessingTableViewControllerDelegate) -> ChaosBlessingTableViewController?
    func createBoonOfTzeenchTableViewController(router: RouterProtocol, delegate: BoonOfTzeenchTableViewControllerDelegate) -> BoonOfTzeenchTableViewController? 
}

class ModuleBuilder: BuilderProtocol {
    
    let store: StoreProtocol
    let gameStore: GameStoreProtocol
    let storage: StorageProtocol
    let userSettings: UserSettingsProtocol
    
    init (store: StoreProtocol, gameStore: GameStoreProtocol, storage: StorageProtocol, userSettings: UserSettingsProtocol) {
        self.store = store
        self.gameStore = gameStore
        self.storage = storage
        self.userSettings = userSettings
    }
    
//MARK: - EditKillTeam
    
    func createCounterModule(router: RouterProtocol) -> CounterViewProtocol{
        let view = CounterViewController()
        let presenter = CounterPresenter(view: view, router: router as! EditKillTeamRouterProtocol, store: store, gameStore: gameStore, storage: storage, userSettings: userSettings)
        view.presenter = presenter
        presenter.delegate = router as? CounterPresenterDelegate
        return view
    }
    
    func createChooseKillTeamModule(router: RouterProtocol) -> ChooseKillTeamViewProtocol {
        let view = ChooseKillTeamTableViewController()
        let presenter = ChooseKillTeamPresenter(view: view, store: store, storage: storage)
        view.presenter = presenter
        presenter.delegate = router as? ChooseKillTeamPresenterDelegate
        return view
    }
    
    func createEditKillTeamModule(router: RouterProtocol) -> EditKillTeamProtocol {
        let view = EditKillTeamTableViewController()
        let presenter = EditKillTeamPresenter(view: view, store: store, userSettings: userSettings)
        view.presenter = presenter
        presenter.delegate = router as? EditKillTeamPresenterDelegate
        return view
    }
    
    func createAddFireTeamModule(router: RouterProtocol) -> AddFireTeamTableVCProtocol {
        let view = AddFireTeamViewController()
        let presenter = AddFireTeamPresenter(view: view, store: store, userSettings: userSettings)
        view.presenter = presenter
        return view
    }
    
    func createEditUnitModule(router: RouterProtocol) -> EditUnitViewControllerProtocol {
        let view = EditUnitViewController()
        let presenter = EditUnitPresenter(view: view, store: store, userSettings: userSettings)
        presenter.delegate = router as? EditUnitPresenterDelegate
        view.presenter = presenter
        return view
        
    }
    
    func createChooseLoadedKillTeamModule(router: RouterProtocol) -> ChooseLoadedKillTeamControllerProtocol {
        let view = ChooseLoadedKillTeamController()
        let presenter = ChooseLoadedKillTeamPresenter(view: view, store: store, storage: storage)
        view.presenter = presenter
        presenter.delegate = router as? ChooseLoadedKillTeamPresenterDelegate
        return view
    }

//MARK: - ObserverKillTeam

    func createRosterModule(router: RouterProtocol) -> RosterTableViewControllerProtocol {
        let view = RosterTableViewController()
        let presenter = RosterPresenter(view: view, store: store, router: router as! KillTeamObserverRouterProtocol, userSettings: userSettings)
        view.presenter = presenter
        presenter.delegate = router as? RosterPresenterDelegate
        return view
    }
    
    func createMoreInfooUnitModule(router: RouterProtocol) -> MoreInfoUnitViewControllerProtocol {
        let view = MoreInfoUnitViewController()
        let presenter = MoreUnitInfoPresenter(view: view, store: store, userSettings: userSettings)
        view.presenter = presenter
        return view
    }
    
//MARK: - Ploys
    
    func createPloysModule(router: RouterProtocol) -> PloysViewControllerProtocol {
        let view = PloysViewController()
        let presenter = PloysPresenter(view: view, store: store, gameStore: gameStore, router: router as! PloysRouterProtocol, userSettings: userSettings)
        presenter.delegate = router as? PloysPresenterDelegate
        view.presenter = presenter
        return view
    }
    
    func createPsychicPowerModule(router: RouterProtocol) -> PsychicPowerViewControllerProtocol {
        let view = PsychicPowerViewController()
        let presenter = PsychicPowerPresenter(view: view, store: store)
        view.presenter = presenter
        return view
    }
    
    func createKillTeamAbilitieModule(router: RouterProtocol) -> KillTeamAbilitieViewControllerProtocol {
        let view = KillTeamAbilitieViewController()
        let presenter = KillTeamAbilitiePresenter(view: view, store: store, gameStore: gameStore)
        view.presenter = presenter
        return view
    }


//MARK: - TacOps
    
    func createTacOpsModule(router: RouterProtocol) -> TacOpsViewControllerProtocol {
        let view = TacOpsViewController()
        let presenter = TacOpsPresenter(view: view, store: store, gameStore: gameStore, router: router as! TacOpsRouterProtocol, userSettings: userSettings)
        view.presenter = presenter
        presenter.delegate = router as? TacOpsPresenterDelegate
        return view
    }

    func createChoosenTacOpsModule(router: RouterProtocol) -> ChoosenTacOpsViewControllerProtocol {
        let view = ChoosenTacOpsViewController()
        let presenter = ChoosenTacOpsPresenter(view: view, gameStore: gameStore, userSettings: userSettings)
        view.presenter = presenter
        return view
    }
    
//MARK: - AbilitieList

    func createKillTeamImperativesList(router: RouterProtocol, delegate: ImperativeTableViewControllerDelegate) -> ImperativeTableViewController? {
        guard let killTeam = store.getKillTeam(),
              let abilitie = killTeam.abilityOfKillTeam as? HunterCladeAbilitie  else { return nil }
        let view = ImperativeTableViewController(gameStore: gameStore)
        view.imperative = abilitie.imperatives
        view.delegate = delegate
        return view
    }

    func createKillTeamAllegoryList(router: RouterProtocol, delegate: AllegoryTableViewControllerDelegate) -> AllegoryTableViewController? {
        guard let killTeam = store.getKillTeam(),
              let abilitie = killTeam.abilityOfKillTeam as? VoidDancerTroupeAbilitie else { return nil }
        let view = AllegoryTableViewController(gameStore: gameStore)
        view.delegate = delegate
        view.allegory = abilitie.allegory
        return view
    }
    
    func createChaosBlessingList(router: RouterProtocol, delegate: ChaosBlessingTableViewControllerDelegate) -> ChaosBlessingTableViewController? {
        guard let killTeam = store.getKillTeam(),
              let abilitie = killTeam.abilityOfKillTeam as? LegionaryAbilitie else { return nil }
        let view = ChaosBlessingTableViewController()
        view.chaosBlessing = abilitie.chaosBlessings
        view.delegate = delegate
        return view
    }
    
    func createBoonOfTzeenchTableViewController(router: RouterProtocol, delegate: BoonOfTzeenchTableViewControllerDelegate) -> BoonOfTzeenchTableViewController? {
        guard let killTeam = store.getKillTeam(),
              let abilitie = killTeam.abilityOfKillTeam as? WarpcovenAbilitie else { return nil }
        let view = BoonOfTzeenchTableViewController()
        view.addBoonOfTzeench(abilitie: abilitie)
        view.delegate = delegate
        return view
    }

}
