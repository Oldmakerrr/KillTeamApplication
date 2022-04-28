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
    let psychicPower: [PsychicPower]?
    let psychicPowerDescription: [String]?
    var abilitiesOfKillTeam: KillTeamAbilitie?
    let equipment: [Equipment]
    var countEquipmentPoint: Int
    let tacOps: [TacOp]?
    var indexOfChoosenUnit: IndexPath?
    
    enum CodingKeys: String, CodingKey {
        case killTeamName = "killTeamName"
        case factionName = "factionName"
        case userCustomName = "userCustomName"
        case id = "id"
        case countOfFireTeam = "countOfFireTeam"
        case factionLogo = "factionLogo"
        case fireTeam = "fireTeam"
        case choosenFireTeam = "choosenFireTeam"
        case counterFireTeam = "counterFireTeam"
        case choosenUnit = "choosenUnit"
        case ploys = "ploys"
        case psychicPower = "psychicPower"
        case psychicPowerDescription = "psychicPowerDescription"
        case abilitiesOfKillTeam = "abilitiesOfKillTeam"
        case equipment = "equipment"
        case countEquipmentPoint = "countEquipmentPoint"
        case tacOps = "tacOps"
        case indexOfChoosenUnit = "indexOfChoosenUnit"
    }
    
    init(from decoder: Decoder) throws {
        let abilitiesOfKillTeam = try decoder.container(keyedBy: CodingKeys.self)
        
        if let novitiateAbilitie = try? abilitiesOfKillTeam.decode(NovitiateAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = novitiateAbilitie
        }
        if let hunterCladeAbilitie = try? abilitiesOfKillTeam.decode(HunterCladeAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = hunterCladeAbilitie
        }
        if let veteranGuardsmanAbilitie = try? abilitiesOfKillTeam.decode(VeteranGuardsmanAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = veteranGuardsmanAbilitie
        }
        if let legionaryAbilitie = try? abilitiesOfKillTeam.decode(LegionaryAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = legionaryAbilitie
        }
        if let warpcovenAbilitie = try? abilitiesOfKillTeam.decode(WarpcovenAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = warpcovenAbilitie
        }
        if let voidDancerTroupeAbilitie = try? abilitiesOfKillTeam.decode(VoidDancerTroupeAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = voidDancerTroupeAbilitie
        }
        if let wyrmbladeAbilitie = try? abilitiesOfKillTeam.decode(WyrmbladeAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = wyrmbladeAbilitie
        }
        if let hunterCadreAbilitie = try? abilitiesOfKillTeam.decode(HunterCadreAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = hunterCadreAbilitie
        }
        if let pathfinderAbilitie = try? abilitiesOfKillTeam.decode(PathfinderAbilitie.self, forKey: .abilitiesOfKillTeam) {
            self.abilitiesOfKillTeam = pathfinderAbilitie
        }
        let killTeamName = try decoder.container(keyedBy: CodingKeys.self)
        self.killTeamName = try killTeamName.decode(String.self, forKey: .killTeamName)
        let factionName = try decoder.container(keyedBy: CodingKeys.self)
        self.factionName = try factionName.decode(String.self, forKey: .factionName)
        let userCustomName = try decoder.container(keyedBy: CodingKeys.self)
        self.userCustomName = try? userCustomName.decode(String.self, forKey: .userCustomName)
        let id = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? id.decode(String.self, forKey: .id)
        let countOfFireTeam = try decoder.container(keyedBy: CodingKeys.self)
        self.countOfFireTeam = try countOfFireTeam.decode(Int.self, forKey: .countOfFireTeam)
        let factionLogo = try decoder.container(keyedBy: CodingKeys.self)
        self.factionLogo = try factionLogo.decode(String.self, forKey: .factionLogo)
        let fireTeam = try decoder.container(keyedBy: CodingKeys.self)
        self.fireTeam = try fireTeam.decode([FireTeam].self, forKey: .fireTeam)
        let choosenFireTeam = try decoder.container(keyedBy: CodingKeys.self)
        self.choosenFireTeam = try choosenFireTeam.decode([FireTeam].self, forKey: .choosenFireTeam)
        let counterFireTeam = try decoder.container(keyedBy: CodingKeys.self)
        self.counterFireTeam = try? counterFireTeam.decode([String:Int].self, forKey: .counterFireTeam)
        let choosenUnit = try decoder.container(keyedBy: CodingKeys.self)
        self.choosenUnit = try? choosenUnit.decode(Unit.self, forKey: .choosenUnit)
        let ploys = try decoder.container(keyedBy: CodingKeys.self)
        self.ploys = try ploys.decode([Ploy].self, forKey: .ploys)
        let psychicPower = try decoder.container(keyedBy: CodingKeys.self)
        self.psychicPower = try? psychicPower.decode([PsychicPower].self, forKey: .psychicPower)
        let psychicPowerDescription = try decoder.container(keyedBy: CodingKeys.self)
        self.psychicPowerDescription = try? psychicPowerDescription.decode([String].self, forKey: .psychicPowerDescription)
        let equipment = try decoder.container(keyedBy: CodingKeys.self)
        self.equipment = try equipment.decode([Equipment].self, forKey: .equipment)
        let countEquipmentPoint = try decoder.container(keyedBy: CodingKeys.self)
        self.countEquipmentPoint = try countEquipmentPoint.decode(Int.self, forKey: .countEquipmentPoint)
        let tacOps = try decoder.container(keyedBy: CodingKeys.self)
        self.tacOps = try? tacOps.decode([TacOp].self, forKey: .tacOps)
        let indexOfChoosenUnit = try decoder.container(keyedBy: CodingKeys.self)
        self.indexOfChoosenUnit = try? indexOfChoosenUnit.decode(IndexPath.self, forKey: .indexOfChoosenUnit)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var abilitiesOfKillTeam = encoder.container(keyedBy: CodingKeys.self)
        if let novitiateAbilitie = self.abilitiesOfKillTeam as? NovitiateAbilitie {
            try abilitiesOfKillTeam.encode(novitiateAbilitie, forKey: .abilitiesOfKillTeam)
        }
        if let hunterCladeAbilitie = self.abilitiesOfKillTeam as? HunterCladeAbilitie {
            try abilitiesOfKillTeam.encode(hunterCladeAbilitie, forKey: .abilitiesOfKillTeam)
        }
        if let veteranGuardsmanAbilitie = self.abilitiesOfKillTeam as? VeteranGuardsmanAbilitie {
            try abilitiesOfKillTeam.encode(veteranGuardsmanAbilitie, forKey: .abilitiesOfKillTeam)
        }
        if let legionaryAbilitie = self.abilitiesOfKillTeam as? LegionaryAbilitie {
            try abilitiesOfKillTeam.encode(legionaryAbilitie, forKey: .abilitiesOfKillTeam)
        }
        if let warpcovenAbilitie = self.abilitiesOfKillTeam as? WarpcovenAbilitie {
            try abilitiesOfKillTeam.encode(warpcovenAbilitie, forKey: .abilitiesOfKillTeam)
        }
        if let voidDancerTroupeAbilitie = self.abilitiesOfKillTeam as? VoidDancerTroupeAbilitie {
            try abilitiesOfKillTeam.encode(voidDancerTroupeAbilitie, forKey: .abilitiesOfKillTeam)
        }
        if let wyrmbladeAbilitie = self.abilitiesOfKillTeam as? WyrmbladeAbilitie {
            try abilitiesOfKillTeam.encode(wyrmbladeAbilitie, forKey: .abilitiesOfKillTeam)
        }
        if let hunterCadreAbilitie = self.abilitiesOfKillTeam as? HunterCadreAbilitie {
            try abilitiesOfKillTeam.encode(hunterCadreAbilitie, forKey: .abilitiesOfKillTeam)
        }
        if let pathfinderAbilitie = self.abilitiesOfKillTeam as? PathfinderAbilitie {
            try abilitiesOfKillTeam.encode(pathfinderAbilitie, forKey: .abilitiesOfKillTeam)
        }
        var killTeamName = encoder.container(keyedBy: CodingKeys.self)
        try? killTeamName.encode(self.killTeamName, forKey: .killTeamName)
        var factionName = encoder.container(keyedBy: CodingKeys.self)
        try? factionName.encode(self.factionName, forKey: .factionName)
        var userCustomName = encoder.container(keyedBy: CodingKeys.self)
        try? userCustomName.encode(self.userCustomName, forKey: .userCustomName)
        var id = encoder.container(keyedBy: CodingKeys.self)
        try? id.encode(self.id, forKey: .id)
        var countOfFireTeam = encoder.container(keyedBy: CodingKeys.self)
        try? countOfFireTeam.encode(self.countOfFireTeam, forKey: .countOfFireTeam)
        var factionLogo = encoder.container(keyedBy: CodingKeys.self)
        try? factionLogo.encode(self.factionLogo, forKey: .factionLogo)
        var fireTeam = encoder.container(keyedBy: CodingKeys.self)
        try? fireTeam.encode(self.fireTeam, forKey: .fireTeam)
        var choosenFireTeam = encoder.container(keyedBy: CodingKeys.self)
        try? choosenFireTeam.encode(self.choosenFireTeam, forKey: .choosenFireTeam)
        var counterFireTeam = encoder.container(keyedBy: CodingKeys.self)
        try? counterFireTeam.encode(self.counterFireTeam, forKey: .counterFireTeam)
        var choosenUnit = encoder.container(keyedBy: CodingKeys.self)
        try? choosenUnit.encode(self.choosenUnit, forKey: .choosenUnit)
        var ploys = encoder.container(keyedBy: CodingKeys.self)
        try? ploys.encode(self.ploys, forKey: .ploys)
        var psychicPower = encoder.container(keyedBy: CodingKeys.self)
        try? psychicPower.encode(self.psychicPower, forKey: .psychicPower)
        var psychicPowerDescription = encoder.container(keyedBy: CodingKeys.self)
        try? psychicPowerDescription.encode(self.psychicPowerDescription, forKey: .psychicPowerDescription)
        var equipment = encoder.container(keyedBy: CodingKeys.self)
        try? equipment.encode(self.equipment, forKey: .equipment)
        var countEquipmentPoint = encoder.container(keyedBy: CodingKeys.self)
        try? countEquipmentPoint.encode(self.countEquipmentPoint, forKey: .countEquipmentPoint)
        var tacOps = encoder.container(keyedBy: CodingKeys.self)
        try? tacOps.encode(self.tacOps, forKey: .tacOps)
        var indexOfChoosenUnit = encoder.container(keyedBy: CodingKeys.self)
        try? indexOfChoosenUnit.encode(self.indexOfChoosenUnit, forKey: .indexOfChoosenUnit)
    }
    
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
