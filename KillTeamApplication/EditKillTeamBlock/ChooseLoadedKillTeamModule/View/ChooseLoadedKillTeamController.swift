//
//  ChooseLoadedKillTeamController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class ChooseLoadedKillTeamController: UITableViewController, ChooseLoadedKillTeamControllerProtocol {
    
    var presenter: ChooseLoadedKillTeamPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        tableView.register(ChooseKillTeamCell.self, forCellReuseIdentifier: KillTeamTableViewCell.ChooseLoadedKillTeamCell.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func removeKillTeamSwipeAction(indexPath: IndexPath, view: UITableViewController, uid: String) -> UIContextualAction {
        let removeSwipe = UIContextualAction(style: .destructive, title: "Remove") { _, _, completion in
            self.presenter?.removeMyKillTeam(indexPath: indexPath, uid: uid)
            self.tableView.reloadData()
            completion(true)
        }
        removeSwipe.backgroundColor = .red
        removeSwipe.image = UIImage(systemName: "minus.square.fill")
        return removeSwipe
    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.loadedKillTeam.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let killTeam = presenter?.model.loadedKillTeam[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: KillTeamTableViewCell.ChooseLoadedKillTeamCell.rawValue, for: indexPath) as! ChooseKillTeamCell
        cell.setupText(killTeam: killTeam)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Size.killTeamCellHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Kill Team"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let killTeam = presenter?.model.loadedKillTeam[indexPath.row] else { return }
        self.dismiss(animated: true, completion: nil)
        presenter?.chooseKillTeam(killTeam: killTeam)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let uid = presenter?.model.loadedKillTeam[indexPath.row].uid else { return nil }
        let removeKillTeamAction = removeKillTeamSwipeAction(indexPath: indexPath, view: self, uid: uid)
        return UISwipeActionsConfiguration(actions: [removeKillTeamAction])
    }
}
