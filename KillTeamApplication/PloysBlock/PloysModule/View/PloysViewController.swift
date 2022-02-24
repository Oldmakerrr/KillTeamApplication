//
//  PloysViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class PloysViewController: UIViewController, PloysViewControllerProtocol {
    
    var presenter: PloysPresenterProtocol?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func usePloyAlert(ploy: Ploy, question: String, succes: String) {
        let alertController = UIAlertController(title: nil, message: question, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Yes", style: .default) { _ in
            if ploy.cost > self.presenter!.model.gameData.countCommandPoint {
                let alertController = UIAlertController(title: nil, message: "You have not enough command point.", preferredStyle: .alert)
                let alertOk = UIAlertAction(title: "Done", style: .cancel, handler: nil)
                alertController.addAction(alertOk)
                self.present(alertController, animated: true, completion: nil)
            } else {
                
                self.presenter!.model.gameData.countCommandPoint -= ploy.cost
                if ploy.type == .strategic {
                    self.presenter?.model.gameData.currentStrategicPloy = ploy
                }
                self.presenter?.gameStore.updateGameData(gameData: self.presenter!.model.gameData)
                let alertController = UIAlertController(title: nil, message: succes, preferredStyle: .alert)
                let alertOk = UIAlertAction(title: "Done", style: .cancel, handler: nil)
                alertController.addAction(alertOk)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let alertNo = UIAlertAction(title: "No, i changed my mind", style: .cancel, handler: nil)
        alertController.addAction(alertOk)
        alertController.addAction(alertNo)
        present(alertController, animated: true, completion: nil)
    }
}

extension PloysViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Strategic Ploy"
        default:
            return "Tactical Ploy"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let strategicPloy = presenter?.model.strategicPloy
        let tacticalPloy = presenter?.model.tacticalPloy
        switch section {
        case 0:
            return strategicPloy?.count ?? 0
        default:
            return tacticalPloy?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PloysTableViewCell.identifier, for: indexPath) as! PloysTableViewCell
        let strategicPloy = presenter?.model.strategicPloy
        let tacticalPloy = presenter?.model.tacticalPloy
        switch indexPath.section {
        case 0:
            cell.nameLabel.text = strategicPloy?[indexPath.row].name
            cell.coastLabel.text = "\(strategicPloy![indexPath.row].cost)CP"
            cell.descriptionLabel.text = strategicPloy?[indexPath.row].description
        default:
            cell.nameLabel.text = tacticalPloy?[indexPath.row].name
            cell.coastLabel.text = "\(tacticalPloy![indexPath.row].cost)CP"
            cell.descriptionLabel.text = tacticalPloy?[indexPath.row].description
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let strategicPloy = presenter!.model.strategicPloy[indexPath.row]
            usePloyAlert(ploy: strategicPloy, question: "Do you want to use this strategic ploy?", succes: "This strategic ploy successfully used.")
        default:
            let tacticalPloy = presenter!.model.tacticalPloy[indexPath.row]
            usePloyAlert(ploy: tacticalPloy, question: "Do you want to use this tactical ploy?", succes: "This tactical ploy successfully used.")
        }
    }
    
}

extension PloysViewController: UITableViewDelegate {
    
}

