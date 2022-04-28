//
//  ChaosBlessingTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class ChaosBlessingTableViewController: UITableViewController {
    
    var chaosBlessing: [LegionaryAbilitie.ChaosBlessing]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ChaosBlessingTableViewCell.self, forCellReuseIdentifier: ChaosBlessingTableViewCell.identifier)
    }
    
    private func setColorToCell(cell: ChaosBlessingTableViewCell, indexPath: IndexPath) {
        let lightColor = ColorScheme.shared.theme.viewBackground
        let darkColor = ColorScheme.shared.theme.subViewBackground
        cell.view.backgroundColor = indexPath.row % 2 == 0 ? lightColor : darkColor
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chaosBlessing = chaosBlessing?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ChaosBlessingTableViewCell.identifier, for: indexPath) as! ChaosBlessingTableViewCell
        cell.updateCell()
        setColorToCell(cell: cell, indexPath: indexPath)
        cell.setupText(chaosBlessing: chaosBlessing)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chaosBlessing?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cost = chaosBlessing?[indexPath.row] else { return }
        print("chaosBlessing - \(cost.name)")
    }
}

class ChaosBlessingTableViewCell: KillTeamAbilitieTableViewCell<AbilitieView> {
    
    func setupText(chaosBlessing: LegionaryAbilitie.ChaosBlessing) {
        view.setupText(abilitie: chaosBlessing)
    }
    
}
