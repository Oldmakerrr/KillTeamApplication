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
    init(view: MoreInfoUnitViewControllerProtocol, store: StoreProtocol)
    var view: MoreInfoUnitViewControllerProtocol? { get }
    var store: StoreProtocol { get set }
    var model: MoreInfoUnitModel { get }
    func cleareIndex()
}

class MoreUnitInfoPresenter: MoreUnitInfoPresenterProtocol {
    
    weak var view: MoreInfoUnitViewControllerProtocol?
    
    var store: StoreProtocol
    
    var model = MoreInfoUnitModel()
    
    required init(view: MoreInfoUnitViewControllerProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        store.multicastDelegate.addDelegate(self)
    }
    
    func cleareIndex() {
        model.killTeam?.indexOfChoosenUnit = nil
        store.updateCurrentKillTeam(killTeam: model.killTeam!)
    }
    
}

extension MoreUnitInfoPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        guard let indexPath = killTeam.indexOfChoosenUnit else { return }
        model.killTeam = killTeam
        model.indexPathOfChoosenUnit = indexPath
        model.choosenUnit = killTeam.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row]
    }
}
