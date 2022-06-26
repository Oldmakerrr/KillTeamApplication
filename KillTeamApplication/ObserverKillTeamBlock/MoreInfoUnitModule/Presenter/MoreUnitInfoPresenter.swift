//
//  MoreUnitInfoPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol MoreInfoUnitViewControllerProtocol: AnyObject {
    var presenter: MoreUnitInfoPresenterProtocol? { get set }
}

protocol MoreUnitInfoPresenterProtocol: AnyObject {
    init(view: MoreInfoUnitViewControllerProtocol, store: StoreProtocol, userSettings: UserSettingsProtocol)
    var view: MoreInfoUnitViewControllerProtocol? { get }
    var userSettings: UserSettingsProtocol { get }
    var store: StoreProtocol { get set }
    var model: MoreInfoUnitModel { get }
    func updateChoosenUnit()
    func clearIndex()
}

class MoreUnitInfoPresenter: MoreUnitInfoPresenterProtocol {
    
    weak var view: MoreInfoUnitViewControllerProtocol?
    
    var store: StoreProtocol
    
    let userSettings: UserSettingsProtocol
    
    var model = MoreInfoUnitModel()
    
    required init(view: MoreInfoUnitViewControllerProtocol, store: StoreProtocol, userSettings: UserSettingsProtocol) {
        self.view = view
        self.store = store
        self.userSettings = userSettings
        store.multicastDelegate.addDelegate(self)
        model.indexPathOfChoosenUnit = store.indexObservedUnit
        updateChoosenUnit()
    }
    
    func clearIndex() {
        store.clearIndexObservedUnit()
    }
    
    func updateChoosenUnit() {
        guard let indexPath = store.indexObservedUnit,
              let killTeam = store.getKillTeam() else { return }
        if !killTeam.choosenFireTeam.isEmpty {
            model.choosenUnit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
            model.killTeam = killTeam
        }
    }
    
}

extension MoreUnitInfoPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        guard let killTeam = killTeam, let indexPath = store.indexObservedUnit else { return }
        model.killTeam = killTeam
        model.indexPathOfChoosenUnit = indexPath
        if !killTeam.choosenFireTeam.isEmpty {
            model.choosenUnit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
        }
    }
}
