//
//  PsychicPowerPresenter.swift
//  KillTeamApplication
//
//  Created by Apple on 25.04.2022.
//

import Foundation

protocol PsychicPowerViewControllerProtocol: AnyObject {
    var presenter: PsychicPowerPresenterProtocol? { get }
}

protocol PsychicPowerPresenterProtocol: AnyObject {
    var view: PsychicPowerViewControllerProtocol? { get }
    var model: PsychicPowerModel { get }
    var store: StoreProtocol { get }
    init (view: PsychicPowerViewControllerProtocol, store: StoreProtocol)
    
    func getLastChoosenPsychicDisciplines() -> String?
    func updateLastChoosenPsychicDisciplines(psychicDisciplines: String)
}

class PsychicPowerPresenter: PsychicPowerPresenterProtocol {
    
    weak var view: PsychicPowerViewControllerProtocol?
    
    let store: StoreProtocol
    
    let model = PsychicPowerModel()
    
    required init(view: PsychicPowerViewControllerProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
        store.multicastDelegate.addDelegate(self)
    }
    
    func updateLastChoosenPsychicDisciplines(psychicDisciplines: String) {
        store.updateLastChoosenPsychicDisciplines(psychicDisciplines: psychicDisciplines)
    }
    
    func getLastChoosenPsychicDisciplines() -> String? {
        return store.lastChoosenPsychicDisciplines
    }
    
    private func addPsychicPowersToDictionary(psychicPower: PsychicPower, type: String) {
        if model.typesOfPsychicPower.contains(where: { (key, _) in key == type }) {
            if var psychicPowerArray = model.typesOfPsychicPower[type] {
                psychicPowerArray.append(psychicPower)
                model.typesOfPsychicPower[type] = psychicPowerArray
            }
        } else {
            model.typesOfPsychicPower[type] = [psychicPower]
        }
    
    }
    
}

extension PsychicPowerPresenter: StoreDelegate {
    func didUpdate(_ store: Store, killTeam: KillTeam?) {
        model.typesOfPsychicPower.removeAll()
        guard let psychicPowers = killTeam?.psychicPower,
              let psychicPowerDescription = killTeam?.psychicPowerDescription else { return }
        model.psychicPowerDescription = psychicPowerDescription
        for psychicPower in psychicPowers {
            if let type = psychicPower.type {
                addPsychicPowersToDictionary(psychicPower: psychicPower, type: type)
            } else {
                model.PsychicPowers.append(psychicPower)
            }
        }
    }
    
    
}
