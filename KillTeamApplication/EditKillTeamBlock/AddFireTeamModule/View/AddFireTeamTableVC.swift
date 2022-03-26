//
//  AddFireTeamTableVC.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class AddFireTeamTableVC: UITableViewController, AddFireTeamTableVCProtocol {
    
    var presenter: AddFireTeamPresenterProtocol?
    
    var maxCountFIreTeamLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        tableView.register(AddFireTeamCell.self, forCellReuseIdentifier: AddFireTeamCell.identifier)
        tableView.allowsMultipleSelection = true
        createBarlabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        maxCountFIreTeamLabel.removeFromSuperview()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.currentFireTeam?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddFireTeamCell.identifier, for: indexPath) as! AddFireTeamCell
        presenter?.store.multicastDelegate.addDelegate(cell)
        if let ft = presenter?.model.currentFireTeam?[indexPath.row] {
            cell.textLabel?.text = ft.name
        }
        cell.delegate = presenter as? AddFireTeamCellDelegate
        let fireTeam = presenter?.model.currentFireTeam![indexPath.row]
        cell.fireTeam = fireTeam
        cell.countFireTeam = presenter?.model.counterFireteam?[fireTeam!.name] ?? 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
