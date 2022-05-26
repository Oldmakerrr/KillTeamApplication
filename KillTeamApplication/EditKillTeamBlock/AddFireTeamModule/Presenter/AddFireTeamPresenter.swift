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
    init(view: AddFireTeamTableVCProtocol, store: StoreProtocol)
}

class AddFireTeamPresenter: AddFireTeamPresenterProtocol {
    
    weak var view: AddFireTeamTableVCProtocol?
    
    var model = AddFireTeamModel()
    
    var store: StoreProtocol
    
    required init(view: AddFireTeamTableVCProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        store.multicastDelegate.addDelegate(self)
    }
    
    private func addCurrentWound(fireTeam: FireTeam) -> FireTeam {
        var fireTeam = fireTeam
        var availableDataslates = fireTeam.availableDataslates
        var currentDataslates = fireTeam.currentDataslates
        for (index, unit) in availableDataslates.enumerated() {
            availableDataslates[index].currentWounds = unit.wounds
        }
        for (index, unit) in currentDataslates.enumerated() {
            currentDataslates[index].currentWounds = unit.wounds
        }
        fireTeam.availableDataslates = availableDataslates
        fireTeam.currentDataslates = currentDataslates
        return fireTeam
    }
    
    private func addCounterFireTeam(killTeam: KillTeam) {
        model.counterFireteam = [String: Int]()
        killTeam.fireTeam.forEach { fireTeam in
            model.counterFireteam[fireTeam.name] = 0
        }
        killTeam.choosenFireTeam.forEach { fireTeam in
            guard var fireTeamCount = model.counterFireteam[fireTeam.name] else { return }
            fireTeamCount += 1
            model.counterFireteam[fireTeam.name] = fireTeamCount
        }
    }
    
    private func addFireTeam(fireTeam: FireTeam) {
        guard var killTeam = model.killTeam else { return }
        killTeam.choosenFireTeam.append(fireTeam)
        if var fireTeamCount = model.counterFireteam[fireTeam.name] {
            fireTeamCount += 1
            model.counterFireteam[fireTeam.name] = fireTeamCount
        }
        model.killTeam = killTeam
    }
    
    private func removeFireTeam(fireTeam: FireTeam) {
        guard let killTeam = model.killTeam else { return }
        for (index, currentFireTeam) in killTeam.choosenFireTeam.enumerated() {
            if currentFireTeam == fireTeam {
                model.killTeam?.choosenFireTeam[index].currentDataslates.forEach({ unit in
                    unit.equipment.forEach { equipment in
                        model.killTeam?.countEquipmentPoint += equipment.cost
                    }
                })
                model.killTeam?.choosenFireTeam.remove(at: index)
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
              let countOfFireTeam = model.killTeam?.choosenFireTeam.count,
              let view = view as? UIViewController else { return }
        if countOfFireTeam < maxCountOfFireTeam {
            var fireTeam = fireTeam
            fireTeam = addCurrentWound(fireTeam: fireTeam)
            addFireTeam(fireTeam: fireTeam)
            if let killTeam = model.killTeam {
                store.updateCurrentKillTeam(killTeam: killTeam)
            }
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
              let fireTeamCount = model.counterFireteam[fireTeam.name] else { return }
        cell.countFireTeam = fireTeamCount
        store.updateCurrentKillTeam(killTeam: killTeam)
    }
}
