//
//  AllegoryTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit


class AllegoryTableViewController: UITableViewController {
    
    var allegory: [VoidDancerTroupeAbilitie.Allegory]?
    
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
        guard let cost = allegory?[indexPath.row] else { return }
        print("chaosBlessing - \(cost.name)")
    }
}

class AllegoryTableViewCell: KillTeamAbilitieTableViewCell<AllegoryView> {
    
    func setupText(allegory: VoidDancerTroupeAbilitie.Allegory) {
        view.setupText(allegory: allegory)
    }
    
}

