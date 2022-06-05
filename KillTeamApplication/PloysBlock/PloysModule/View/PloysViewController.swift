//
//  PloysViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Instructions

class PloysViewController: UIViewController, PloysViewControllerProtocol {
    
    var presenter: PloysPresenterProtocol?
    
    let coachMarksController = CoachMarksController()
    
    let tableView = UITableView()
    
    let commandPointLabel = BoldLabel()
    
    let psychicPowerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "flame.fill"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupTableView()
        //tabBarController?.delegate = self
        navigationItem.title = "Ploys"
        
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
        coachMarksController.animationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCoachMarks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        commandPointLabel.text = "CP = \(presenter?.model.gameData.countCommandPoint ?? 0)"
        emptyTableState()
        setupKillTeamAbilitieButton()
        let isExistPsychicPower = presenter?.model.killTeam?.psychicPower != nil
        commandPointLabel.textColor = .white
        setupRightNavigationView(view: commandPointLabel)
        shouldPsychicPowerButton(shouldShow: isExistPsychicPower)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coachMarksController.stop()
        navigationController?.navigationBar.clearNavigationBar()
       
    }
    
    
    func emptyTableState() {
        if presenter?.model.strategicPloy.count == 0 && presenter?.model.tacticalPloy.count == 0 {
            setEmptyState(title: "No Kill Team",
                          message: "Please choose or create new Kill Team on the main screen")
        } else {
            restore()
        }
    }
    
    func setupKillTeamAbilitieButton() {
        guard presenter?.model.killTeam?.abilitiesOfKillTeam != nil else {
            navigationItem.leftBarButtonItem = nil
            return }
        let killTeamAbilitieBarButtonItem = UIBarButtonItem(image: nil,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(goToKillTeamAbilitieButtonAction))
        killTeamAbilitieBarButtonItem.title = "Abilitie"
        navigationItem.leftBarButtonItem = killTeamAbilitieBarButtonItem
    }
    
    @objc private func goToKillTeamAbilitieButtonAction() {
        presenter?.goToKillTeamAbilitieViewController()
    }
    
    func setupPsychicPowerButton() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        psychicPowerButton.addTarget(self, action: #selector(psychicPowerButtonAction), for: .touchUpInside)
        navigationBar.addSubview(psychicPowerButton)
        NSLayoutConstraint.activate([
            psychicPowerButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            psychicPowerButton.trailingAnchor.constraint(equalTo: commandPointLabel.leadingAnchor, constant: -Constant.Size.Otstup.normal)
        ])
    }
    
    @objc func psychicPowerButtonAction() {
        presenter?.goToPsychicPowerViewController()
    }
    
    private func shouldPsychicPowerButton(shouldShow: Bool) {
        if shouldShow {
            setupPsychicPowerButton()
        } else {
            psychicPowerButton.removeFromSuperview()
        }
    }
    
    func usePloy(ploy: Ploy, cell: UITableViewCell, tableView: UITableView) {
        guard let presenter = presenter else { return }
        if ploy.cost > presenter.model.gameData.countCommandPoint {
            showToast(message: "You have not enough command point.")
            cell.shake()
        } else {
            presenter.model.gameData.countCommandPoint -= ploy.cost
            if ploy.type == .strategic {
                presenter.addPloy(ploy: ploy)
                showToast(message: "Strategic ploy successfully used.")
                tableView.reloadData()
            } else {
                showToast(message: "Tactical ploy successfully used.")
            }
            commandPointLabel.text = "CP = \(presenter.model.gameData.countCommandPoint)"
        }
    }
    
   
}

extension PloysViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let strategicPloy = presenter?.model.strategicPloy,
              let tacticalPloy = presenter?.model.tacticalPloy else { return 0 }
        if strategicPloy.isEmpty && tacticalPloy.isEmpty {
            return 0
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        switch section {
        case 0:
            view.label.text = "Strategic Ploy"
        default:
            view.label.text = "Tactical Ploy"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Size.headerHeight
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
        guard let presenter = presenter else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: PloysTableViewCell.identifier, for: indexPath) as! PloysTableViewCell
        cell.updateCell()
        switch indexPath.section {
        case 0:
            let strategicPloy = presenter.model.strategicPloy[indexPath.row]
            if presenter.model.gameData.currentStrategicPloys.contains(strategicPloy) {
                cell.setupPloy(ploy: strategicPloy, image: UIImage(systemName: "largecircle.fill.circle"), delegate: self)
            } else {
                cell.setupPloy(ploy: strategicPloy, delegate: self)
            }
            return cell
        default:
            let tacticalPloy = presenter.model.tacticalPloy[indexPath.row]
            cell.setupPloy(ploy: tacticalPloy, delegate: self)
            return cell
        }
    }
    
}

extension PloysViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch indexPath.section {
        case 0:
            let strategicPloy = presenter!.model.strategicPloy[indexPath.row]
            if self.presenter!.model.gameData.currentStrategicPloys.contains(strategicPloy) {
                showToast(message: "You have already used this stratigic ploy in that Turning Point")
                cell.shake()
            } else {
                usePloy(ploy: strategicPloy, cell: cell, tableView: tableView)
            }
        case 1:
            let tacticalPloy = presenter!.model.tacticalPloy[indexPath.row]
            usePloy(ploy: tacticalPloy, cell: cell, tableView: tableView)
        default:
            return
        }
        
    }
    
}

//extension PloysViewController: UITabBarControllerDelegate {
//
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        guard let nav = viewController as? UINavigationController else { return }
//        nav.popToRootViewController(animated: true)
//    }
//
//}

extension PloysViewController: WeaponRuleButtonDelegate {
    
    func didComplete(_: WeaponRuleButton, weaponRule: WeaponSpecialRule) {
        moreInfoWeaponRuleAlert(weaponRule: weaponRule)
    }
    
}

 
 
