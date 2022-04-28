//
//  BoonOfTzeenchTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class BoonOfTzeenchTableViewController: UITableViewController {
    
    var boonsOfTzeentch: [[WarpcovenAbilitie.BoonsOfTzeentch]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BoonOfTzeenchTableViewCell.self, forCellReuseIdentifier: BoonOfTzeenchTableViewCell.identifier)
    }
    
    private func setColorToCell(cell: BoonOfTzeenchTableViewCell, indexPath: IndexPath) {
        let lightColor = ColorScheme.shared.theme.viewBackground
        let darkColor = ColorScheme.shared.theme.subViewBackground
        cell.view.backgroundColor = indexPath.row % 2 == 0 ? lightColor : darkColor
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let boonOfTzeentch = boonsOfTzeentch?[indexPath.section][indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: BoonOfTzeenchTableViewCell.identifier, for: indexPath) as! BoonOfTzeenchTableViewCell
        cell.updateCell()
        cell.setupText(abilitie: boonOfTzeentch)
        setColorToCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return boonsOfTzeentch?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boonsOfTzeentch?[section].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        var text = String()
        switch section {
        case 0:
            text = "Mutation"
        case 1:
            text = "Fate"
        case 2:
            text = "Aetheric"
        default:
            break
        }
        view.label.text = text
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cost = boonsOfTzeentch?[indexPath.row][indexPath.row] else { return }
        print("boonsOfTzeentch - \(cost.name)")
    }
}

//MARK: - BoonOfTzeench

class BoonOfTzeenchTableViewCell: KillTeamAbilitieTableViewCell<AbilitieView> {
    func setupText(abilitie: WarpcovenAbilitie.BoonsOfTzeentch) {
        view.setupText(abilitie: abilitie)
    }
    
    
}
