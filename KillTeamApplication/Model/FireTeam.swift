//
//  FireTeam.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct FireTeam: Codable {
    let name: String
    let archetype: [FireTeamType]
    var availableDataslates: [Unit]
    var currentDataslates: [Unit] = []
}

enum FireTeamType: String, Codable {
    case seekAndDestroy
    case security
    case infiltration
    case recon
}

extension FireTeam: Equatable {
    static func == (lhs: FireTeam, rhs: FireTeam) -> Bool {
        lhs.name == rhs.name
    }
}
