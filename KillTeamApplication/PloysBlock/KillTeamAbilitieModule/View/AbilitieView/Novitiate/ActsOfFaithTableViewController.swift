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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ActsOfFaithCell.self, forCellReuseIdentifier: ActsOfFaithCell.identifier)
    }
    
    private func setColorToCell(cell: ActsOfFaithCell, indexPath: IndexPath) {
        let lightColor = ColorScheme.shared.theme.viewBackground
        let darkColor = ColorScheme.shared.theme.subViewBackground
        cell.view.backgroundColor = indexPath.row % 2 == 0 ? lightColor : darkColor
    }
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cost = actsOfFaith?[indexPath.row].cost else { return }
        print("Act of Faith point - \(cost)")
    }
}

class ActsOfFaithCell: KillTeamAbilitieTableViewCell<ActOfFateView> {
    func setupText(actOfFate: UnitAbilitieProtocol, cost: Int) {
        view.setupView(actOfFate: actOfFate, cost: cost)
    }

}
