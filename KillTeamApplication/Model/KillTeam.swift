//
//  KillTeam.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct Faction: Codable {
    let name: String
    let killTeam: [KillTeam]
}

struct KillTeam: Codable {
    
    let killTeamName: String
    let factionName: String
    var userCustomName: String?
    var id: String?
    let countOfFireTeam: Int
    let factionLogo: String
    let fireTeam: [FireTeam]
    var choosenFireTeam: [FireTeam] = []
    var counterFireTeam: [String: Int]?
    var choosenUnit: Unit?
    let ploys: [Ploy]
    let abilitiesOfKillTeam: [KillTeamAbilitie]?
    let equipment: [Equipment]
    var countEquipmentPoint: Int
    let tacOps: [TacOp]?
    var indexOfChoosenUnit: IndexPath?
    
    mutating func updateCurrentWounds() {
        for (i, fireTeam) in choosenFireTeam.enumerated() {
            for (j, unit) in fireTeam.currentDataslates.enumerated() {
                choosenFireTeam[i].currentDataslates[j].currentWounds = unit.wounds
            }
        }
    }
    
    mutating func initCounterFireTeam() {
        counterFireTeam = [:]
    }
    
    mutating func createId() {
        let uuid = UUID().uuidString
        id = uuid
    }

    mutating func addDefaultFireTeam() {
        if countOfFireTeam == 1 && fireTeam.count == 1 {
            choosenFireTeam = fireTeam
        }
        updateCurrentWounds()
    }
    
    mutating func prepareKillTeam() {
        addDefaultFireTeam()
        initCounterFireTeam()
        createId()
    }
    
 }

extension KillTeam: Equatable {
    static func == (lhs: KillTeam, rhs: KillTeam) -> Bool {
        lhs.id == rhs.id && lhs.killTeamName == rhs.killTeamName
    }
}
