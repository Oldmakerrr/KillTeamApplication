//
//  AllegoryTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

protocol AllegoryTableViewControllerDelegate: AnyObject {
    func didComplete(_ allegoryTableViewController: AllegoryTableViewController)
}

class AllegoryTableViewController: UITableViewController {
    
    weak var delegate:AllegoryTableViewControllerDelegate?
    
    var allegory: [VoidDancerTroupeAbility.Allegory]?
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
        tableView.register(AllegoryTableViewCell.self, forCellReuseIdentifier: AllegoryTableViewCell.identifier)
    }
    
    private func setColorToCell(cell: AllegoryTableViewCell, indexPath: IndexPath) {
        let lightColor = ColorScheme.shared.theme.viewBackground
        let darkColor = ColorScheme.shared.theme.subViewBackground
        cell.view.backgroundColor = indexPath.row % 2 == 0 ? lightColor : darkColor
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let allegory = allegory?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: AllegoryTableViewCell.identifier, for: indexPath) as! AllegoryTableViewCell
        cell.updateCell()
        setColorToCell(cell: cell, indexPath: indexPath)
        cell.setupText(allegory: allegory)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allegory?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let allegory = allegory?[indexPath.row] else { return }
        gameData.currentAbilitie = allegory.name
        gameStore.updateGameData(gameData: gameData)
        delegate?.didComplete(self)
    }
    
}

class AllegoryTableViewCell: KillTeamAbilitieTableViewCell<AllegoryView> {
    
    func setupText(allegory: VoidDancerTroupeAbility.Allegory) {
        view.setupText(allegory: allegory)
    }
    
}


