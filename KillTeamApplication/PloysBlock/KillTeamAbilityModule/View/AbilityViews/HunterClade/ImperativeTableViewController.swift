//
//  ImperativeTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

protocol ImperativeTableViewControllerDelegate: AnyObject {
    func didComplete(_ imperativeTableViewController: ImperativeTableViewController)
}

class ImperativeTableViewController: UITableViewController {
    
    weak var delegate: ImperativeTableViewControllerDelegate?
    
    var imperative: [HunterCladeAbility.Imperative]?
    let gameStore: GameStoreProtocol
    var gameData = GameData()
    
    init(gameStore: GameStoreProtocol) {
        self.gameStore = gameStore
        super.init(style: .plain)
        guard let gameData = gameStore.getGameDate() else { return }
        self.gameData = gameData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ImperativeTableViewCell.self, forCellReuseIdentifier: ImperativeTableViewCell.identifier)
    }
    
    private func setColorToCell(cell: ImperativeTableViewCell, indexPath: IndexPath) {
        let lightColor = ColorScheme.shared.theme.viewBackground
        let darkColor = ColorScheme.shared.theme.subViewBackground
        cell.view.backgroundColor = indexPath.row % 2 == 0 ? lightColor : darkColor
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imperative = imperative?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ImperativeTableViewCell.identifier, for: indexPath) as! ImperativeTableViewCell
        cell.updateCell()
        cell.setupText(imperative: imperative)
        setColorToCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imperative?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let imperative = imperative?[indexPath.row] else { return }
        gameData.currentAbilitie = imperative.name
        gameStore.updateGameData(gameData: gameData)
        delegate?.didComplete(self)
    }
    
}

//MARK: - ImperativeCell

class ImperativeTableViewCell: KillTeamAbilitieTableViewCell<ImperativeView> {
    
    func setupText(imperative: HunterCladeAbility.Imperative) {
        view.setupImerative(imperative: imperative)
    }
    
}


