//
//  KillTeamAbilitieViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 27.04.2022.
//

import UIKit

class KillTeamAbilitieViewController: UIViewController, KillTeamAbilitieViewControllerProtocol {
    
    var presenter: KillTeamAbilitiePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupAbilitie()
    }
    
    private func setupAbilitie() {
        guard let abilitie = presenter?.model.abilitie else { return }
        var contentView = UIStackView()
        
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
        setupContentView(contentView: contentView)
    }
    
//MARK: - methodsSetupFactionAbilitieView
    
    private func setupNovitiateAbilitie(abilitie: NovitiateAbilitie) -> UIStackView {
        let view = NovitiateAbilitieView()
        let image = UIImage(named: "killTeamViewController")
        view.setupAbilitie(abilitie: abilitie, viewController: self)
        view.addRightBurButtonItem(navigationItem: navigationItem,
                                   image: image)
        return view
    }
    
    private func setupHunterCladeAbilitie(abilitie: HunterCladeAbilitie) -> UIStackView {
        let view = HunterCladeAbilitieView()
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
        view.setupAbilitie(abilitie: abilitie, viewController: self)
        let image = UIImage(named: "killTeamViewController")
        view.addRightBurButtonItem(navigationItem: navigationItem,
                                   image: image)
        return view
    }
    
    private func setupWyrmbladeAbilitie(abilitie: WyrmbladeAbilitie) -> UIStackView {
        let view = WyrmbladeAbilitieView()
        view.setupAbilitie(abilitie: abilitie)
        return view
    }
    
    private func setupHunterCadreAbilitie(abilitie: HunterCadreAbilitie) -> UIStackView {
        let view = HunterCadreAbilitieView()
        view.setupAbilitie(abilitie: abilitie)
        return view
    
    }
    
//MARK: - setupContentView
    
    private func setupContentView(contentView: UIStackView) {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

