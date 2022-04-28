//
//  TacticalAssetsTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 28.04.2022.
//

import UIKit

class TacticalAssetsTableViewController: UITableViewController {
    
    var tacticalAssets: [VeteranGuardsmanAbilitie.TacticalAssets]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TacticalAssetsTableViewCell.self, forCellReuseIdentifier: TacticalAssetsTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tacticalAssets = tacticalAssets?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: TacticalAssetsTableViewCell.identifier, for: indexPath) as! TacticalAssetsTableViewCell
        cell.updateCell()
        cell.setupText(tacticalAssets: tacticalAssets, delegate: self)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tacticalAssets?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cost = tacticalAssets?[indexPath.row] else { return }
        print("tacticalAssets - \(cost.name)")
    }
}

extension TacticalAssetsTableViewController: WeaponRuleButtonDelegate {
    
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
}

class TacticalAssetsTableViewCell: KillTeamAbilitieTableViewCell<TacticalAssetsView> {
    
    func setupText(tacticalAssets: VeteranGuardsmanAbilitie.TacticalAssets, delegate: WeaponRuleButtonDelegate) {
        view.setupText(tacticalAssets: tacticalAssets, delegate: delegate)
    }
    
}
