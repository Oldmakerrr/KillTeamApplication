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
}

extension AddFireTeamPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        model.killTeam = killTeam
        model.currentFireTeam = killTeam.fireTeam
        model.counterFireteam = killTeam.counterFT
        model.maxCountOfFireTeam = killTeam.countOfFireTeam
        model.currentCointOFFireTeam = killTeam.choosenFireTeam.count
    }
}

extension AddFireTeamPresenter: AddFireTeamCellDelegate {
    func didCompletePlusFireTeam(_ cell: AddFireTeamCell, fireTeam: FireTeam) {
        guard let maxCountOfFireTeam = model.maxCountOfFireTeam, let currentCointOFFireTeam = model.currentCointOFFireTeam else { return }
        if currentCointOFFireTeam < maxCountOfFireTeam {
            store.addFireTeam(fireTeam: fireTeam)
        }
    }
    
    func didCompleteMinusFireTeam(_ cell: AddFireTeamCell, fireTeam: FireTeam) {
        store.removeFireTeam(fireTeam: fireTeam)
    }
}
