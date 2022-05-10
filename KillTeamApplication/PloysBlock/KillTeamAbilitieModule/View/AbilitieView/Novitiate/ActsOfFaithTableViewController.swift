//
//  ActsOfFaithTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

//MARK: - ActsOfFaithTableViewController

class ActsOfFaithTableViewController: UITableViewController {
    
    var actsOfFaith: [NovitiateAbilitie.ActOfFaith]?
    let gameStore: GameStoreProtocol
    var gameData = GameData()
    
    init(gameStore: GameStoreProtocol) {
        self.gameStore = gameStore
        super.init(style: .plain)
        gameStore.multicastDelegate.addDelegate(self)
        guard let gameData = gameStore.getGameDate() else { return }
        self.gameData = gameData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ActsOfFaithCell.self, forCellReuseIdentifier: ActsOfFaithCell.identifier)
    }
    
    private func setColorToCell(cell: ActsOfFaithCell, indexPath: IndexPath) {
        let lightColor = ColorScheme.shared.theme.viewBackground
        let darkColor = ColorScheme.shared.theme.subViewBackground
        cell.view.backgroundColor = indexPath.row % 2 == 0 ? lightColor : darkColor
    }
    
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Done", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
//MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActsOfFaithCell.identifier, for: indexPath) as! ActsOfFaithCell
        guard let actOfFaith = actsOfFaith?[indexPath.row] else { return UITableViewCell() }
        cell.updateCell()
        cell.setupText(actOfFate: actOfFaith, cost: actOfFaith.cost)
        setColorToCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actsOfFaith?.count ?? 0
    }
    
//MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cost = actsOfFaith?[indexPath.row].cost, var point = gameData.countKillTeamAbilitiePoint else { return }
        if point >= cost {
            point -= cost
            gameData.countKillTeamAbilitiePoint = point
            gameStore.updateGameData(gameData: gameData)
            showAlert(title: "Act of Faith successfully used")
        } else {
            showAlert(title: "You have not enough point")
        }
    }
    
}

//MARK: - GameStoreDelegate

extension ActsOfFaithTableViewController: GameStoreDelegate {
    
    func didUpdate(_ gameStore: GameStore, gameData: GameData?) {
        guard let gameData = gameData else { return }
        self.gameData = gameData
    }
    
}

//MARK: - Cell

class ActsOfFaithCell: KillTeamAbilitieTableViewCell<ActOfFateView> {
    
    func setupText(actOfFate: UnitAbilitieProtocol, cost: Int) {
        view.setupView(actOfFate: actOfFate, cost: cost)
    }

}


