//
//  Unit.swift
//  KillTeamApplication
//
//  Created by Apple on 17.04.2022.
//

import Foundation

struct Unit: Codable {
    let name: String
    var customName: String?
    let typeUnit: [UnitType]
    let description: String
    let portrait: String
    let movement: Int
    let actionPointLimit: Int
    let groupActivation: Int
    let defense: Int
    let save: Int
    let wounds: Int
    var currentWounds: Int?
    var selectedRangeWeapon: Weapon?
    var selectedCloseWeapon: Weapon?
    let additionalWeapon: [Weapon]?
    let availableWeapon: [Weapon]?
    var equipment: [Equipment] = []
    let abilities: [UnitAbilitie]?
    var additionalAbilitie: UnitAbilitieProtocol?
    let uniqueActions: [UnitUniqueAction]?
    let keyWords: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case customName = "customName"
        case typeUnit = "typeUnit"
        case description = "description"
        case portrait = "portrait"
        case movement = "movement"
        case actionPointLimit = "actionPointLimit"
        case groupActivation = "groupActivation"
        case defense = "defense"
        case save = "save"
        case wounds = "wounds"
        case currentWounds = "currentWounds"
        case selectedRangeWeapon = "selectedRangeWeapon"
        case selectedCloseWeapon = "selectedCloseWeapon"
        case additionalWeapon = "additionalWeapon"
        case availableWeapon = "availableWeapon"
        case equipment = "equipment"
        case abilities = "abilities"
        case additionalAbilitie = "additionalAbilitie"
        case uniqueActions = "uniqueActions"
        case keyWords = "keyWords"
    }
    
    init(from decoder: Decoder) throws {
        let additionalAbilitie = try decoder.container(keyedBy: CodingKeys.self)
        if let boonOfTzeentch = try? additionalAbilitie.decode(WarpcovenAbilitie.BoonsOfTzeentch.self, forKey: .additionalAbilitie) {
            self.additionalAbilitie = boonOfTzeentch
        }
        if let abilitie = try? additionalAbilitie.decode(UnitAbilitie.self, forKey: .additionalAbilitie) {
            self.additionalAbilitie = abilitie
        }
        let name = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try name.decode(String.self, forKey: .name)
        let customName = try decoder.container(keyedBy: CodingKeys.self)
        self.customName = try? customName.decode(String?.self, forKey: .customName)
        let typeUnit = try decoder.container(keyedBy: CodingKeys.self)
        self.typeUnit = try typeUnit.decode([UnitType].self, forKey: .typeUnit)
        let description = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try description.decode(String.self, forKey: .description)
        let portrait = try decoder.container(keyedBy: CodingKeys.self)
        self.portrait = try portrait.decode(String.self, forKey: .portrait)
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
        self.currentWounds = try? currentWounds.decode(Int?.self, forKey: .currentWounds)
        let selectedRangeWeapon = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedRangeWeapon = try? selectedRangeWeapon.decode(Weapon?.self, forKey: .selectedRangeWeapon)
        let selectedCloseWeapon = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedCloseWeapon = try? selectedCloseWeapon.decode(Weapon?.self, forKey: .selectedCloseWeapon)
        let additionalWeapon = try decoder.container(keyedBy: CodingKeys.self)
        self.additionalWeapon = try? additionalWeapon.decode([Weapon]?.self, forKey: .additionalWeapon)
        let availableWeapon = try decoder.container(keyedBy: CodingKeys.self)
        self.availableWeapon = try? availableWeapon.decode([Weapon]?.self, forKey: .availableWeapon)
        let equipment = try decoder.container(keyedBy: CodingKeys.self)
        self.equipment = try equipment.decode([Equipment].self, forKey: .equipment)
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
        var customName = encoder.container(keyedBy: CodingKeys.self)
        try? customName.encode(self.customName, forKey: .customName)
        var typeUnit = encoder.container(keyedBy: CodingKeys.self)
        try typeUnit.encode(self.typeUnit, forKey: .typeUnit)
        var description = encoder.container(keyedBy: CodingKeys.self)
        try description.encode(self.description, forKey: .description)
        var portrait = encoder.container(keyedBy: CodingKeys.self)
        try portrait.encode(self.portrait, forKey: .portrait)
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
        try? currentWounds.encode(self.currentWounds, forKey: .currentWounds)
        var selectedRangeWeapon = encoder.container(keyedBy: CodingKeys.self)
        try? selectedRangeWeapon.encode(self.selectedRangeWeapon, forKey: .selectedRangeWeapon)
        var selectedCloseWeapon = encoder.container(keyedBy: CodingKeys.self)
        try? selectedCloseWeapon.encode(self.selectedCloseWeapon, forKey: .selectedCloseWeapon)
        var additionalWeapon = encoder.container(keyedBy: CodingKeys.self)
        try? additionalWeapon.encode(self.additionalWeapon, forKey: .additionalWeapon)
        var availableWeapon = encoder.container(keyedBy: CodingKeys.self)
        try? availableWeapon.encode(self.availableWeapon, forKey: .availableWeapon)
        var equipment = encoder.container(keyedBy: CodingKeys.self)
        try equipment.encode(self.equipment, forKey: .equipment)
        var abilities = encoder.container(keyedBy: CodingKeys.self)
        try? abilities.encode(self.abilities, forKey: .abilities)
        var additionalAbilitie = encoder.container(keyedBy: CodingKeys.self)
        if let boonOfTzeentch = self.additionalAbilitie as? WarpcovenAbilitie.BoonsOfTzeentch {
            try additionalAbilitie.encode(boonOfTzeentch, forKey: .additionalAbilitie)
        }
        if let abilitie = self.additionalAbilitie as? UnitAbilitie {
            try additionalAbilitie.encode(abilitie, forKey: .additionalAbilitie)
        }
        var uniqueActions = encoder.container(keyedBy: CodingKeys.self)
        try? uniqueActions.encode(self.uniqueActions, forKey: .uniqueActions)
        var keyWords = encoder.container(keyedBy: CodingKeys.self)
        try keyWords.encode(self.keyWords, forKey: .keyWords)
    }
    
    mutating func updateCurrentWounds() {
        currentWounds = wounds
    }
}

enum UnitType: String, Codable {
    case combat
    case staunch
    case marksman
    case scout
}
