//
//  KillTeamAbilitieViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import UIKit

class KillTeamAbilitieViewController: UIViewController, KillTeamAbilitieViewControllerProtocol {
    
    var presenter: KillTeamAbilitiePresenterProtocol?
    var menuBar: MenuBar?
    var contentView = UIStackView()
    var funcArray: [(KillTeamAbilitie)->(UIStackView)]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewBackground
        title = "Abilitie"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupAbilitie()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        funcArray = nil
        menuBar = nil
        view.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        navigationController?.navigationBar.clearNavigationBar()
    }
    
    deinit {
        print("VIEWCONTROLLER = NULL")
    }
    
    private func setupAbilitie() {
        guard let abilitie = presenter?.model.abilitie else { return }
        if let novitiateAbilitie = abilitie as? NovitiateAbilitie {
            contentView = setupNovitiateAbilitie(abilitie: novitiateAbilitie)
        }
        
        if let hunterCladeAbilitie = abilitie as? HunterCladeAbilitie {
            contentView = setupHunterCladeAbilitie(abilitie: hunterCladeAbilitie)
        }
        
        if let veteranGuardsmanAbilitie = abilitie as? VeteranGuardsmanAbilitie {
            contentView = setupVeteranGuardsmanAbilitie(abilitie: veteranGuardsmanAbilitie)
        }
        
        if let legionaryAbilitie = abilitie as? LegionaryAbilitie {
            contentView = setupLegionaryAbilitie(abilitie: legionaryAbilitie)
        }
        
        if let warpcovenAbilitie = abilitie as? WarpcovenAbilitie {
            contentView = setupWarpcovenAbilitie(abilitie: warpcovenAbilitie)
        }
        
        if let voidDancerTroupeAbilitie = abilitie as? VoidDancerTroupeAbilitie {
            contentView = setupVoidDancerTroupeAbilitie(abilitie: voidDancerTroupeAbilitie)
        }
        if let wyrmbladeAbilitie = abilitie as? WyrmbladeAbilitie {
            contentView = setupWyrmbladeAbilitie(abilitie: wyrmbladeAbilitie)
        }
        if let hunterCadreAbilitie = abilitie as? HunterCadreAbilitie {
            contentView = setupHunterCadreAbilitie(abilitie: hunterCadreAbilitie)
        }
        if let pathfinderAbilitie = abilitie as? PathfinderAbilitie {
            contentView = setupPathfinderAbilitie(abilitie: pathfinderAbilitie)
        }
        setupContentView(contentView: contentView)
    }
    
//MARK: - methodsSetupFactionAbilitieView
    
    private func setupNovitiateAbilitie(abilitie: NovitiateAbilitie) -> UIStackView {
        let view = NovitiateAbilitieView()
        view.delegate = self
        let image = UIImage(named: "killTeamViewController")
        view.setupAbilitie(abilitie: abilitie, viewController: self)
        view.addRightBurButtonItem(navigationItem: navigationItem,
                                   image: image)
        return view
    }
    
    private func setupHunterCladeAbilitie(abilitie: HunterCladeAbilitie) -> UIStackView {
        let view = HunterCladeAbilitieView()
        view.delegate = self
        let image = UIImage(named: "killTeamViewController")
        view.setupAbilitie(abilitie: abilitie, viewController: self)
        view.addRightBurButtonItem(navigationItem: navigationItem,
                                   image: image)
        return view
    }
    
    private func setupVeteranGuardsmanAbilitie(abilitie: VeteranGuardsmanAbilitie) -> UIStackView {
        let view = VeteranGuardsmanAbilitieView()
        view.setupAbilitie(abilitie: abilitie, viewController: self)
        let image = UIImage(named: "killTeamViewController")
        view.addRightBurButtonItem(navigationItem: navigationItem,
                                   image: image)
        return view
    }
    
    private func setupLegionaryAbilitie(abilitie: LegionaryAbilitie) -> UIStackView {
        let view = LegionaryAbilitieView()
        view.setupAbilitie(abilitie: abilitie, viewController: self)
        let image = UIImage(named: "killTeamViewController")
        view.addRightBurButtonItem(navigationItem: navigationItem,
                                   image: image)
        return view
    }
    
    private func setupWarpcovenAbilitie(abilitie: WarpcovenAbilitie) -> UIStackView {
        let view = WarpcovenAbilitieView()
        view.setupAbilitie(abilitie: abilitie, viewController: self)
        let image = UIImage(named: "killTeamViewController")
        view.addRightBurButtonItem(navigationItem: navigationItem,
                                   image: image)
        return view
    }
    
    private func setupVoidDancerTroupeAbilitie(abilitie: VoidDancerTroupeAbilitie) -> UIStackView {
        let view = VoidDancerTroupeAbilitieView()
        view.delegate = self
        view.setupAbilitie(abilitie: abilitie, viewController: self)
        let image = UIImage(named: "killTeamViewController")
        view.addRightBurButtonItem(navigationItem: navigationItem,
                                   image: image)
        return view
    }
    
    private func setupWyrmbladeAbilitie(abilitie: WyrmbladeAbilitie) -> UIStackView {
        let view = WyrmbladeAbilitieView()
        let namesOfCell = ["Cult Ambush", "Preternatural Assassin"]
        funcArray = []
        funcArray?.removeAll()
        funcArray?.append(setupWyrmbladeFirstAbilitie)
        funcArray?.append(setupWyrmbladeSecondAbilitie)
        menuBar = MenuBar(namesOfCell: namesOfCell)
        menuBar?.delegate = self
        setupMenuBar()
        view.setupFirstRule(abilitie: abilitie)
        return view
    }
    
    private func setupHunterCadreAbilitie(abilitie: HunterCadreAbilitie) -> UIStackView {
        let view = HunterCadreAbilitieView()
        let namesOfCell = ["Drones", "Markerlight", "Artificial Intelligence", "Saviour Protocols"]
        funcArray = []
        funcArray?.append(setupHunterCadreDroneAbilitie)
        funcArray?.append(setupHunterCadreMarkerlightAbilitie)
        funcArray?.append(setupHunterCadreArtificialIntelligenceAbilitie)
        funcArray?.append(setupHunterCadreSaviourProtocolsAbilitie)
        menuBar = MenuBar(namesOfCell: namesOfCell)
        menuBar?.delegate = self
        setupMenuBar()
        view.setupDroneRule(abilitie: abilitie)
        return view
    
    }
    
    private func setupPathfinderAbilitie(abilitie: PathfinderAbilitie) -> UIStackView {
        let view = PathfinderAbilitieView()
        view.setupAbilitieText(abilitie: abilitie.artificialIntelligence)
        let namesOfCell = ["Artificial Intelligence", "Markerlight", "Saviour Protocols", "Pulse Weapon", "Art of War"]
        funcArray = []
        funcArray?.append(setupPathfinderArtificialIntelligenceAbilitie)
        funcArray?.append(setupPathfinderMarkerlightAbilitie)
        funcArray?.append(setupPathfinderSaviourProtocolsAbilitie)
        funcArray?.append(setupPathfinderPulseWeaponAbilitie)
        funcArray?.append(setupPathfinderArtOfWarAbilitie)
        menuBar = MenuBar(namesOfCell: namesOfCell)
        menuBar?.delegate = self
        setupMenuBar()
        return view
    }
    
   
    
//MARK: - setupContentView
    
    private func setupContentView(contentView: UIStackView) {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        if let menuBar = menuBar {
            scrollView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        } else {
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
           
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupMenuBar() {
        guard let menuBar = menuBar else { return }
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension KillTeamAbilitieViewController: WeaponRuleButtonDelegate {
    
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
    
}

//MARK: - MenuBarDelegate

extension KillTeamAbilitieViewController: MenuBarDelegate {
    func didSelect(_ menuBar: MenuBar, indexPath: IndexPath) {
        guard let abilitie = presenter?.model.abilitie,
              let function = funcArray?[indexPath.item] else { return }
        contentView.removeFromSuperview()
        if let pathfinderAbilitie = abilitie as? PathfinderAbilitie {
            contentView = function(pathfinderAbilitie)
        }
        if let wyrmbladeAbilitie = abilitie as? WyrmbladeAbilitie {
            contentView = function(wyrmbladeAbilitie)
        }
        if let hunterCadreAbilitie = abilitie as? HunterCadreAbilitie {
            contentView = function(hunterCadreAbilitie)
        }
        setupContentView(contentView: contentView)
    }
    
    
}

//MARK: AbilitieViewDelegate

extension KillTeamAbilitieViewController: NovitiateAbilitieViewDelegate {
    
    func didComplete(_ novitiateAbilitieView: NovitiateAbilitieView) {
        guard let abilitie = presenter?.model.abilitie as? NovitiateAbilitie,
              let gameStore = presenter?.gameStore else { return }
        let tableViewController = ActsOfFaithTableViewController(gameStore: gameStore)
        tableViewController.actsOfFaith = abilitie.actsOfFaith
        present(tableViewController, animated: true, completion: nil)
    }
    
}

extension KillTeamAbilitieViewController: HunterCladeAbilitieViewDelegate {
    
    func didComplete(_ hunterCladeAbilitieView: HunterCladeAbilitieView) {
        guard let abilitie = presenter?.model.abilitie as? HunterCladeAbilitie,
              let gameStore = presenter?.gameStore else { return }
        let tableViewController = ImperativeTableViewController(gameStore: gameStore)
        tableViewController.imperative = abilitie.imperatives
        present(tableViewController, animated: true, completion: nil)
    }
    
}

extension KillTeamAbilitieViewController: VoidDancerTroupeAbilitieViewDelegate {
    
    func didComplete(_ voidDancerTroupeAbilitieView: VoidDancerTroupeAbilitieView) {
        guard let abilitie = presenter?.model.abilitie as? VoidDancerTroupeAbilitie,
              let gameStore = presenter?.gameStore else { return }
        let tableViewController = AllegoryTableViewController(gameStore: gameStore)
        tableViewController.allegory = abilitie.allegory
        present(tableViewController, animated: true, completion: nil)
    }
    
}
