//
//  Unit.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct Unit: Codable {
    let name: String
    let id: String
    var customName: String?
    let unitType: [UnitType]
    let description: String
    let unitImageName: String
    let movement: Int
    let actionPointLimit: Int
    let groupActivation: Int
    let defense: Int
    let save: Int
    let wounds: Int
    var currentWounds: Int
    var selectedRangeWeapon: Weapon?
    var selectedMeleeWeapon: Weapon?
    let additionalWeapons: [Weapon]?
    let availableWeapons: [Weapon]?
    var equipments: [Equipment]
    let abilities: [UnitAbilitie]?
    let uniqueActions: [UnitUniqueAction]?
    var additionalAbility: UnitAbilitieProtocol?
    let keyWords: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case customName
        case unitType
        case description
        case unitImageName
        case movement
        case actionPointLimit
        case groupActivation
        case defense
        case save
        case wounds
        case currentWounds
        case selectedRangeWeapon
        case selectedMeleeWeapon
        case additionalWeapons
        case availableWeapons
        case equipments
        case abilities
        case additionalAbility
        case uniqueActions
        case keyWords
    }
    
    init(from decoder: Decoder) throws {
        let additionalAbilitie = try decoder.container(keyedBy: CodingKeys.self)
        if let boonOfTzeentch = try? additionalAbilitie.decode(WarpcovenAbilitie.BoonsOfTzeentch.self, forKey: .additionalAbility) {
            self.additionalAbility = boonOfTzeentch
        }
        if let abilitie = try? additionalAbilitie.decode(UnitAbilitie.self, forKey: .additionalAbility) {
            self.additionalAbility = abilitie
        }
        let name = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try name.decode(String.self, forKey: .name)
        let id = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try id.decode(String.self, forKey: .id)
        let customName = try decoder.container(keyedBy: CodingKeys.self)
        self.customName = try? customName.decode(String?.self, forKey: .customName)
        let typeUnit = try decoder.container(keyedBy: CodingKeys.self)
        self.unitType = try typeUnit.decode([UnitType].self, forKey: .unitType)
        let description = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try description.decode(String.self, forKey: .description)
        let portrait = try decoder.container(keyedBy: CodingKeys.self)
        self.unitImageName = try portrait.decode(String.self, forKey: .unitImageName)
        let movement = try decoder.container(keyedBy: CodingKeys.self)
        self.movement = try movement.decode(Int.self, forKey: .movement)
        let actionPointLimit = try decoder.container(keyedBy: CodingKeys.self)
        self.actionPointLimit = try actionPointLimit.decode(Int.self, forKey: .actionPointLimit)
        let groupActivation = try decoder.container(keyedBy: CodingKeys.self)
        self.groupActivation = try groupActivation.decode(Int.self, forKey: .groupActivation)
        let defense = try decoder.container(keyedBy: CodingKeys.self)
        self.defense = try defense.decode(Int.self, forKey: .defense)
        let save = try decoder.container(keyedBy: CodingKeys.self)
        self.save = try save.decode(Int.self, forKey: .save)
        let wounds = try decoder.container(keyedBy: CodingKeys.self)
        self.wounds = try wounds.decode(Int.self, forKey: .wounds)
        let currentWounds = try decoder.container(keyedBy: CodingKeys.self)
        self.currentWounds = try currentWounds.decode(Int.self, forKey: .currentWounds)
        let selectedRangeWeapon = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedRangeWeapon = try? selectedRangeWeapon.decode(Weapon?.self, forKey: .selectedRangeWeapon)
        let selectedCloseWeapon = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedMeleeWeapon = try? selectedCloseWeapon.decode(Weapon?.self, forKey: .selectedMeleeWeapon)
        let additionalWeapon = try decoder.container(keyedBy: CodingKeys.self)
        self.additionalWeapons = try? additionalWeapon.decode([Weapon]?.self, forKey: .additionalWeapons)
        let availableWeapon = try decoder.container(keyedBy: CodingKeys.self)
        self.availableWeapons = try? availableWeapon.decode([Weapon]?.self, forKey: .availableWeapons)
        let equipment = try decoder.container(keyedBy: CodingKeys.self)
        self.equipments = try equipment.decode([Equipment].self, forKey: .equipments)
        let abilities = try decoder.container(keyedBy: CodingKeys.self)
        self.abilities = try? abilities.decode([UnitAbilitie].self, forKey: .abilities)
        let uniqueActions = try decoder.container(keyedBy: CodingKeys.self)
        self.uniqueActions = try? uniqueActions.decode([UnitUniqueAction]?.self, forKey: .uniqueActions)
        let keyWords = try decoder.container(keyedBy: CodingKeys.self)
        self.keyWords = try keyWords.decode([String].self, forKey: .keyWords)
    }
    
    func encode(to encoder: Encoder) throws {
        var name = encoder.container(keyedBy: CodingKeys.self)
        try name.encode(self.name, forKey: .name)
        var id = encoder.container(keyedBy: CodingKeys.self)
        try id.encode(self.id, forKey: .id)
        var customName = encoder.container(keyedBy: CodingKeys.self)
        try? customName.encode(self.customName, forKey: .customName)
        var typeUnit = encoder.container(keyedBy: CodingKeys.self)
        try typeUnit.encode(self.unitType, forKey: .unitType)
        var description = encoder.container(keyedBy: CodingKeys.self)
        try description.encode(self.description, forKey: .description)
        var portrait = encoder.container(keyedBy: CodingKeys.self)
        try portrait.encode(self.unitImageName, forKey: .unitImageName)
        var movement = encoder.container(keyedBy: CodingKeys.self)
        try movement.encode(self.movement, forKey: .movement)
        var actionPointLimit = encoder.container(keyedBy: CodingKeys.self)
        try actionPointLimit.encode(self.actionPointLimit, forKey: .actionPointLimit)
        var groupActivation = encoder.container(keyedBy: CodingKeys.self)
        try groupActivation.encode(self.groupActivation, forKey: .groupActivation)
        var defense = encoder.container(keyedBy: CodingKeys.self)
        try defense.encode(self.defense, forKey: .defense)
        var save = encoder.container(keyedBy: CodingKeys.self)
        try save.encode(self.save, forKey: .save)
        var wounds = encoder.container(keyedBy: CodingKeys.self)
        try wounds.encode(self.wounds, forKey: .wounds)
        var currentWounds = encoder.container(keyedBy: CodingKeys.self)
        try currentWounds.encode(self.currentWounds, forKey: .currentWounds)
        var selectedRangeWeapon = encoder.container(keyedBy: CodingKeys.self)
        try? selectedRangeWeapon.encode(self.selectedRangeWeapon, forKey: .selectedRangeWeapon)
        var selectedCloseWeapon = encoder.container(keyedBy: CodingKeys.self)
        try? selectedCloseWeapon.encode(self.selectedMeleeWeapon, forKey: .selectedMeleeWeapon)
        var additionalWeapon = encoder.container(keyedBy: CodingKeys.self)
        try? additionalWeapon.encode(self.additionalWeapons, forKey: .additionalWeapons)
        var availableWeapon = encoder.container(keyedBy: CodingKeys.self)
        try? availableWeapon.encode(self.availableWeapons, forKey: .availableWeapons)
        var equipment = encoder.container(keyedBy: CodingKeys.self)
        try equipment.encode(self.equipments, forKey: .equipments)
        var abilities = encoder.container(keyedBy: CodingKeys.self)
        try? abilities.encode(self.abilities, forKey: .abilities)
        var additionalAbilitie = encoder.container(keyedBy: CodingKeys.self)
        if let boonOfTzeentch = self.additionalAbility as? WarpcovenAbilitie.BoonsOfTzeentch {
            try additionalAbilitie.encode(boonOfTzeentch, forKey: .additionalAbility)
        }
        if let abilitie = self.additionalAbility as? UnitAbilitie {
            try additionalAbilitie.encode(abilitie, forKey: .additionalAbility)
        }
        var uniqueActions = encoder.container(keyedBy: CodingKeys.self)
        try? uniqueActions.encode(self.uniqueActions, forKey: .uniqueActions)
        var keyWords = encoder.container(keyedBy: CodingKeys.self)
        try keyWords.encode(self.keyWords, forKey: .keyWords)
    }
    
}

enum UnitType: String, Codable {
    case combat
    case staunch
    case marksman
    case scout
}
