//
//  ChooseLoadedKillTeamPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
import UIKit

protocol ChooseLoadedKillTeamControllerProtocol: AnyObject {
    var presenter: ChooseLoadedKillTeamPresenterProtocol? { get }
}

protocol ChooseLoadedKillTeamPresenterProtocol: AnyObject {
    init(view: ChooseLoadedKillTeamControllerProtocol, store: StoreProtocol)
    var view: ChooseLoadedKillTeamControllerProtocol? { get }
    var store: StoreProtocol { get }
    var model: ChooseLoadedKillTeamModel { get }
    func chooseKillTeam(killTeam: KillTeam)
    func removeMyKillTeam(indexPath: IndexPath, view: UITableViewController)
    func removeKillTeamSwipeAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction
}

protocol ChooseLoadedKillTeamPresenterDelegate: AnyObject {
    func didComplete(_ presenter: ChooseLoadedKillTeamPresenterProtocol)
}

class ChooseLoadedKillTeamPresenter: ChooseLoadedKillTeamPresenterProtocol {
    
    weak var view: ChooseLoadedKillTeamControllerProtocol?
    
    var store: StoreProtocol
    
    var model = ChooseLoadedKillTeamModel()
    
    weak var delegate: ChooseLoadedKillTeamPresenterDelegate?
    
    private var keysForKillTeam: [String] = []
    
    required init(view: ChooseLoadedKillTeamControllerProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        store.multicastDelegate.addDelegate(self)
        if let keys = KeySaver.getKey() {
            keysForKillTeam = keys
        }
        for key in keysForKillTeam {
            if let killTeam = loadMyKillTeam(key: key) {
                model.loadedKillTeam.append(killTeam)
            }
        }
    }
    
    
    private func loadMyKillTeam(key: String) -> KillTeam? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            return try? PropertyListDecoder().decode(KillTeam.self, from: data)
        } else { return nil }
    }
    
    func chooseKillTeam(killTeam: KillTeam) {
        delegate?.didComplete(self)
        store.addKillTeam(killTeam: killTeam)
    }
    
    func removeMyKillTeam(indexPath: IndexPath, view: UITableViewController) {
        model.loadedKillTeam.remove(at: indexPath.row)
        keysForKillTeam.remove(at: indexPath.row)
        view.tableView.reloadData()
        KeySaver.saveKey(key: keysForKillTeam)
    }
    
    func removeKillTeamSwipeAction(indexPath: IndexPath, view: UITableViewController) -> UIContextualAction {
        let removeSwipe = UIContextualAction(style: .destructive, title: "Remove") { _, _, completion in
            self.removeMyKillTeam(indexPath: indexPath, view: view)
            completion(true)
        }
        removeSwipe.backgroundColor = .red
        removeSwipe.image = UIImage(systemName: "minus.square.fill")
        return removeSwipe
    }
    
}

extension ChooseLoadedKillTeamPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
    }
}
