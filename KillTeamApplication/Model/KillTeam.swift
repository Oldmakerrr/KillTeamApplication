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
    let id: String
    var userCustomName: String?
    var uid: String?
    let countOfFireTeam: Int
    let factionLogo: String
    let fireTeams: [FireTeam]
    var chosenFireTeams: [FireTeam]
    let ploys: [Ploy]
    let psychicPowers: [PsychicPower]?
    let psychicPowerDescriptions: [String]?
    var abilityOfKillTeam: KillTeamAbility?
    let equipments: [Equipment]
    var countEquipmentPoint: Int
    let tacOps: [TacOp]?
    
    enum CodingKeys: String, CodingKey {
        case killTeamName
        case factionName
        case id
        case userCustomName
        case uid
        case countOfFireTeam
        case factionLogo
        case fireTeams
        case chosenFireTeams
        case ploys
        case psychicPowers
        case psychicPowerDescriptions
        case abilityOfKillTeam
        case equipments
        case countEquipmentPoint
        case tacOps
    }
    
    init(from decoder: Decoder) throws {
        let abilityOfKillTeam = try decoder.container(keyedBy: CodingKeys.self)
        
        if let novitiateAbility = try? abilityOfKillTeam.decode(NovitiateAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = novitiateAbility
        }
        if let hunterCladeAbilitie = try? abilityOfKillTeam.decode(HunterCladeAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = hunterCladeAbilitie
        }
        if let veteranGuardsmanAbilitie = try? abilityOfKillTeam.decode(VeteranGuardsmanAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = veteranGuardsmanAbilitie
        }
        if let legionaryAbilitie = try? abilityOfKillTeam.decode(LegionaryAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = legionaryAbilitie
        }
        if let warpcovenAbilitie = try? abilityOfKillTeam.decode(WarpcovenAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = warpcovenAbilitie
        }
        if let voidDancerTroupeAbilitie = try? abilityOfKillTeam.decode(VoidDancerTroupeAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = voidDancerTroupeAbilitie
        }
        if let wyrmbladeAbilitie = try? abilityOfKillTeam.decode(WyrmbladeAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = wyrmbladeAbilitie
        }
        if let hunterCadreAbilitie = try? abilityOfKillTeam.decode(HunterCadreAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = hunterCadreAbilitie
        }
        if let pathfinderAbilitie = try? abilityOfKillTeam.decode(PathfinderAbilitie.self, forKey: .abilityOfKillTeam) {
            self.abilityOfKillTeam = pathfinderAbilitie
        }
        let killTeamName = try decoder.container(keyedBy: CodingKeys.self)
        self.killTeamName = try killTeamName.decode(String.self, forKey: .killTeamName)
        let factionName = try decoder.container(keyedBy: CodingKeys.self)
        self.factionName = try factionName.decode(String.self, forKey: .factionName)
        let id = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try id.decode(String.self, forKey: .id)
        let userCustomName = try decoder.container(keyedBy: CodingKeys.self)
        self.userCustomName = try? userCustomName.decode(String.self, forKey: .userCustomName)
        let uid = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try? uid.decode(String.self, forKey: .uid)
        let countOfFireTeam = try decoder.container(keyedBy: CodingKeys.self)
        self.countOfFireTeam = try countOfFireTeam.decode(Int.self, forKey: .countOfFireTeam)
        let factionLogo = try decoder.container(keyedBy: CodingKeys.self)
        self.factionLogo = try factionLogo.decode(String.self, forKey: .factionLogo)
        let fireTeam = try decoder.container(keyedBy: CodingKeys.self)
        self.fireTeams = try fireTeam.decode([FireTeam].self, forKey: .fireTeams)
        let choosenFireTeam = try decoder.container(keyedBy: CodingKeys.self)
        self.chosenFireTeams = try choosenFireTeam.decode([FireTeam].self, forKey: .chosenFireTeams)
        let ploys = try decoder.container(keyedBy: CodingKeys.self)
        self.ploys = try ploys.decode([Ploy].self, forKey: .ploys)
        let psychicPower = try decoder.container(keyedBy: CodingKeys.self)
        self.psychicPowers = try? psychicPower.decode([PsychicPower].self, forKey: .psychicPowers)
        let psychicPowerDescription = try decoder.container(keyedBy: CodingKeys.self)
        self.psychicPowerDescriptions = try? psychicPowerDescription.decode([String].self, forKey: .psychicPowerDescriptions)
        let equipment = try decoder.container(keyedBy: CodingKeys.self)
        self.equipments = try equipment.decode([Equipment].self, forKey: .equipments)
        let countEquipmentPoint = try decoder.container(keyedBy: CodingKeys.self)
        self.countEquipmentPoint = try countEquipmentPoint.decode(Int.self, forKey: .countEquipmentPoint)
        let tacOps = try decoder.container(keyedBy: CodingKeys.self)
        self.tacOps = try? tacOps.decode([TacOp].self, forKey: .tacOps)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var abilitiesOfKillTeam = encoder.container(keyedBy: CodingKeys.self)
        if let novitiateAbilitie = self.abilityOfKillTeam as? NovitiateAbilitie {
            try abilitiesOfKillTeam.encode(novitiateAbilitie, forKey: .abilityOfKillTeam)
        }
        if let hunterCladeAbilitie = self.abilityOfKillTeam as? HunterCladeAbilitie {
            try abilitiesOfKillTeam.encode(hunterCladeAbilitie, forKey: .abilityOfKillTeam)
        }
        if let veteranGuardsmanAbilitie = self.abilityOfKillTeam as? VeteranGuardsmanAbilitie {
            try abilitiesOfKillTeam.encode(veteranGuardsmanAbilitie, forKey: .abilityOfKillTeam)
        }
        if let legionaryAbilitie = self.abilityOfKillTeam as? LegionaryAbilitie {
            try abilitiesOfKillTeam.encode(legionaryAbilitie, forKey: .abilityOfKillTeam)
        }
        if let warpcovenAbilitie = self.abilityOfKillTeam as? WarpcovenAbilitie {
            try abilitiesOfKillTeam.encode(warpcovenAbilitie, forKey: .abilityOfKillTeam)
        }
        if let voidDancerTroupeAbilitie = self.abilityOfKillTeam as? VoidDancerTroupeAbilitie {
            try abilitiesOfKillTeam.encode(voidDancerTroupeAbilitie, forKey: .abilityOfKillTeam)
        }
        if let wyrmbladeAbilitie = self.abilityOfKillTeam as? WyrmbladeAbilitie {
            try abilitiesOfKillTeam.encode(wyrmbladeAbilitie, forKey: .abilityOfKillTeam)
        }
        if let hunterCadreAbilitie = self.abilityOfKillTeam as? HunterCadreAbilitie {
            try abilitiesOfKillTeam.encode(hunterCadreAbilitie, forKey: .abilityOfKillTeam)
        }
        if let pathfinderAbilitie = self.abilityOfKillTeam as? PathfinderAbilitie {
            try abilitiesOfKillTeam.encode(pathfinderAbilitie, forKey: .abilityOfKillTeam)
        }
        var killTeamName = encoder.container(keyedBy: CodingKeys.self)
        try killTeamName.encode(self.killTeamName, forKey: .killTeamName)
        var factionName = encoder.container(keyedBy: CodingKeys.self)
        try factionName.encode(self.factionName, forKey: .factionName)
        var id = encoder.container(keyedBy: CodingKeys.self)
        try id.encode(self.id, forKey: .id)
        var userCustomName = encoder.container(keyedBy: CodingKeys.self)
        try? userCustomName.encode(self.userCustomName, forKey: .userCustomName)
        var uid = encoder.container(keyedBy: CodingKeys.self)
        try? uid.encode(self.uid, forKey: .uid)
        var countOfFireTeam = encoder.container(keyedBy: CodingKeys.self)
        try countOfFireTeam.encode(self.countOfFireTeam, forKey: .countOfFireTeam)
        var factionLogo = encoder.container(keyedBy: CodingKeys.self)
        try factionLogo.encode(self.factionLogo, forKey: .factionLogo)
        var fireTeam = encoder.container(keyedBy: CodingKeys.self)
        try fireTeam.encode(self.fireTeams, forKey: .fireTeams)
        var choosenFireTeam = encoder.container(keyedBy: CodingKeys.self)
        try choosenFireTeam.encode(self.chosenFireTeams, forKey: .chosenFireTeams)
        var ploys = encoder.container(keyedBy: CodingKeys.self)
        try ploys.encode(self.ploys, forKey: .ploys)
        var psychicPower = encoder.container(keyedBy: CodingKeys.self)
        try? psychicPower.encode(self.psychicPowers, forKey: .psychicPowers)
        var psychicPowerDescription = encoder.container(keyedBy: CodingKeys.self)
        try? psychicPowerDescription.encode(self.psychicPowerDescriptions, forKey: .psychicPowerDescriptions)
        var equipment = encoder.container(keyedBy: CodingKeys.self)
        try equipment.encode(self.equipments, forKey: .equipments)
        var countEquipmentPoint = encoder.container(keyedBy: CodingKeys.self)
        try countEquipmentPoint.encode(self.countEquipmentPoint, forKey: .countEquipmentPoint)
        var tacOps = encoder.container(keyedBy: CodingKeys.self)
        try? tacOps.encode(self.tacOps, forKey: .tacOps)
    }
    
    mutating func updateCurrentWounds() {
        for (i, fireTeam) in chosenFireTeams.enumerated() {
            for (j, unit) in fireTeam.currentDataslates.enumerated() {
                chosenFireTeams[i].currentDataslates[j].currentWounds = unit.wounds
            }
        }
    }

    mutating func addDefaultFireTeam() {
        if countOfFireTeam == 1 && fireTeams.count == 1 {
            chosenFireTeams = fireTeams
        }
    }
   
 }

extension KillTeam: Equatable {
    static func == (lhs: KillTeam, rhs: KillTeam) -> Bool {
        lhs.id == rhs.id
    }
}
