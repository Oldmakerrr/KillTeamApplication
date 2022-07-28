//
//  AddFireTeamPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

protocol AddFireTeamTableVCProtocol: AnyObject {
    var presenter: AddFireTeamPresenterProtocol? { get }
}

protocol AddFireTeamPresenterProtocol: AnyObject {
    var model: AddFireTeamModel { get }
    var store: StoreProtocol { get }
    var view: AddFireTeamTableVCProtocol? { get set }
    var userSettings: UserSettingsProtocol { get set }
    init(view: AddFireTeamTableVCProtocol, store: StoreProtocol, userSettings: UserSettingsProtocol)
}

class AddFireTeamPresenter: NSObject, AddFireTeamPresenterProtocol {
    
    weak var view: AddFireTeamTableVCProtocol?
    
    var model = AddFireTeamModel()
    
    let store: StoreProtocol
    
    var userSettings: UserSettingsProtocol
    
    required init(view: AddFireTeamTableVCProtocol, store: StoreProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.store = store
        self.userSettings = userSettings
        super.init()
        store.multicastDelegate.addDelegate(self)
    }
    
    private func addCounterFireTeam(killTeam: KillTeam) {
        model.counterFireteam = [String: Int]()
        killTeam.fireTeams.forEach { fireTeam in
            model.counterFireteam[fireTeam.name] = 0
        }
        killTeam.chosenFireTeams.forEach { fireTeam in
            guard var fireTeamCount = model.counterFireteam[fireTeam.name] else { return }
            fireTeamCount += 1
            model.counterFireteam[fireTeam.name] = fireTeamCount
        }
    }
    
    
    
    private func addFireTeam(fireTeam: FireTeam) {
        guard var killTeam = model.killTeam else { return }
        var fireTeam = fireTeam
        fireTeam.fillCurrentDataslates()
        killTeam.chosenFireTeams.append(fireTeam)
        if var fireTeamCount = model.counterFireteam[fireTeam.name] {
            fireTeamCount += 1
            model.counterFireteam[fireTeam.name] = fireTeamCount
        }
        model.killTeam = killTeam
    }
    
    private func removeFireTeam(fireTeam: FireTeam) {
        guard let killTeam = model.killTeam else { return }
        for (index, currentFireTeam) in killTeam.chosenFireTeams.enumerated() {
            if currentFireTeam == fireTeam {
                model.killTeam?.chosenFireTeams[index].currentDataslates.forEach({ unit in
                    unit.equipments.forEach { equipment in
                        model.killTeam?.countEquipmentPoint += equipment.cost
                    }
                })
                model.killTeam?.chosenFireTeams.remove(at: index)
                if var fireTeamCount = model.counterFireteam[fireTeam.name] {
                    fireTeamCount -= 1
                    model.counterFireteam[fireTeam.name] = fireTeamCount
                }
                break
            }
        }
    }
}

extension AddFireTeamPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let killTeam = killTeam else { return }
        model.killTeam = killTeam
        addCounterFireTeam(killTeam: killTeam)
    }
}

extension AddFireTeamPresenter: AddFireTeamCellDelegate {
    func addFireTeam(_ cell: AddFireTeamCell, fireTeam: FireTeam) {
        guard let maxCountOfFireTeam = model.killTeam?.countOfFireTeam,
              let countOfFireTeam = model.killTeam?.chosenFireTeams.count,
              let view = view as? UIViewController else { return }
        if countOfFireTeam < maxCountOfFireTeam {
            addFireTeam(fireTeam: fireTeam)
            if let killTeam = model.killTeam {
                store.updateCurrentKillTeam(killTeam: killTeam)
            }
            view.showToast(message: "Fire Team successfully added")
        } else {
            view.showToast(message: "You have the maximum number of Fire Team")
        }
        if let count = model.counterFireteam[fireTeam.name] {
            cell.countFireTeam = count
        }
    }
    
    func removeFireTeam(_ cell: AddFireTeamCell, fireTeam: FireTeam) {
        removeFireTeam(fireTeam: fireTeam)
        guard let killTeam = model.killTeam,
              let fireTeamCount = model.counterFireteam[fireTeam.name],
              let view = view as? UIViewController else { return }
        cell.countFireTeam = fireTeamCount
        view.showToast(message: "Fire Team successfully removed")
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
}

//MARK: - UITableView Delegate/DataSource

extension AddFireTeamPresenter: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.killTeam?.fireTeams.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddFireTeamCell.identifier, for: indexPath) as! AddFireTeamCell
        guard let fireTeam = model.killTeam?.fireTeams[indexPath.row],
              let fireTeamCount = model.counterFireteam[fireTeam.name] else { return UITableViewCell() }
        cell.countFireTeam = fireTeamCount
        cell.textLabel?.text = fireTeam.name
        cell.delegate = self
        cell.fireTeam = fireTeam
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.Size.cellHeight
    }
    
}
