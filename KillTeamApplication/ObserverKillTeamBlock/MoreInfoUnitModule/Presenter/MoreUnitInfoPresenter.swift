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
    
    
}

extension MoreUnitInfoPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam) {
        model.killTeam = killTeam
        model.choosenUnit = killTeam.choosenUnit
    }
}
