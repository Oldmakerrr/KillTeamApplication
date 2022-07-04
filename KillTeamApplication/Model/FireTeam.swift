//
//  FireTeam.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct FireTeam: Codable {
    let name: String
    let id: String
    let archetype: [FireTeamType]
    let availableDataslates: [Unit]
    var currentDataslates: [Unit]
    let defaultDataslates: [String:Int]
    
    mutating func fillCurrentDataslates() {
        for (key, value) in defaultDataslates {
            for unit in availableDataslates {
                if unit.id == key {
                    if unit.keyWords.contains("leader".uppercased()) || unit.keyWords.contains("sorcerer".uppercased()) {
                        currentDataslates.insert(unit, at: 0)
                    } else {
                        for _ in 0..<value {
                            currentDataslates.append(unit)
                        }
                    }
                    break
                }
            }
        }
    }
}

enum FireTeamType: String, Codable {
    case seekAndDestroy
    case security
    case infiltration
    case recon
}

extension FireTeam: Equatable {
    static func == (lhs: FireTeam, rhs: FireTeam) -> Bool {
        lhs.id == rhs.id
    }
}
