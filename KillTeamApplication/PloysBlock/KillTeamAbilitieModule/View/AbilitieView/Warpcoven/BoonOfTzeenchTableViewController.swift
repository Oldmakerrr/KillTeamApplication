//
//  BoonOfTzeenchTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

protocol BoonOfTzeenchTableViewControllerDelegate: AnyObject {
    func didComplete(_ boonOfTzeenchTableViewController: BoonOfTzeenchTableViewController, boonOfTzeentch: WarpcovenAbilitie.BoonsOfTzeentch)
}

class BoonOfTzeenchTableViewController: UITableViewController {
    
    weak var delegate: BoonOfTzeenchTableViewControllerDelegate?
    
    var boonsOfTzeentch: [[WarpcovenAbilitie.BoonsOfTzeentch]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BoonOfTzeenchTableViewCell.self, forCellReuseIdentifier: BoonOfTzeenchTableViewCell.identifier)
    }
    
    func addBoonOfTzeench(abilitie: WarpcovenAbilitie) {
        var boonsOfTzeentch = [[WarpcovenAbilitie.BoonsOfTzeentch]]()
        var mutation = [WarpcovenAbilitie.BoonsOfTzeentch]()
        var fate = [WarpcovenAbilitie.BoonsOfTzeentch]()
        var aetheric = [WarpcovenAbilitie.BoonsOfTzeentch]()
        abilitie.mutation.forEach { boonOfTzeentch in
            switch boonOfTzeentch.type {
            case .mutation:
                mutation.append(boonOfTzeentch)
            case .fate:
                fate.append(boonOfTzeentch)
            case .aetheric:
                aetheric.append(boonOfTzeentch)
            }
        }
        boonsOfTzeentch.append(mutation)
        boonsOfTzeentch.append(fate)
        boonsOfTzeentch.append(aetheric)
        self.boonsOfTzeentch = boonsOfTzeentch
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
        guard let boonOfTzeentch = boonsOfTzeentch?[indexPath.section][indexPath.row] else { return }
        delegate?.didComplete(self, boonOfTzeentch: boonOfTzeentch)
    }
}

//MARK: - BoonOfTzeench

class BoonOfTzeenchTableViewCell: KillTeamAbilitieTableViewCell<AbilitieView> {
    func setupText(abilitie: WarpcovenAbilitie.BoonsOfTzeentch) {
        view.setupText(abilitie: abilitie)
    }
    
    
}
