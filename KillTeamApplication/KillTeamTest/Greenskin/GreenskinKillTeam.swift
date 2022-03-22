//
//  GreenskinKillTeam.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
/*

let ork = Faction(name: "Ork", killTeam: [greenskinKillTeam])

let greenskinKillTeam = KillTeam(killTeamName: "Greenskin", factionName: "Ork", id: nil, countOfFireTeam: 2, factionLogo: "orks", fireTeam: [boyzFireTeam, clanKommandoFireTeam, speshulistFireTeam], counterFT: ["sda":1], ploys: [], abilitiesOfKillTeam: nil, equipment: [stikkbomb, evyArmor, bosspole, drumMag, targetinFing, cuttinNozzle, kustomForceField], countEquipmentPoint: 10, tacOps: [blowItUp, shokkTaktiks, getStuckInTacOp])

//MARK:  Equipment

let stikkbomb = Equipment(name: "STIKKBOMB", description: "The operative is equipped with the following ranged weapon for the battle:", cost: 2, maxCounPerKillTeam: nil, body: nil, uniqueAction: nil, wargear: stikkbombWargear)

let evyArmor = Equipment(name: "’EAVY ARMOUR", description: "Operative with a 5+ Save characteristic only. Change the operative’s Save characteristic to 4+ for the battle.", cost: 2, maxCounPerKillTeam: nil, body: nil, uniqueAction: nil, wargear: nil)

let bosspole = Equipment(name: "BOSSPOLE", description: "BOSS NOB or KOMMANDO NOB operative only. Add 1 to the operative’s APL for the battle.", cost: 3, maxCounPerKillTeam: 1, body: nil, uniqueAction: nil, wargear: nil)

let drumMag = Equipment(name: "DRUM MAG", description: "Select one shoota or big shoota this operative is equipped with. That weapon gains the Ceaseless special rule for the battle.", cost: 2, maxCounPerKillTeam: nil, body: nil, uniqueAction: nil, wargear: nil)

let targetinFing = Equipment(name: "TARGETIN’ FING", description: "Select one ranged weapon this operative is equipped with (excluding a burna or a ranged weapon with the Kombi special rule). Improve that weapon’s Ballistic Skill characteristic by 1 for the battle (to a maximum of 4+).", cost: 3, maxCounPerKillTeam: nil, body: nil, uniqueAction: nil, wargear: nil)

let cuttinNozzle = Equipment(name: "CUTTIN’ NOZZLE", description: "BURNA BOY operative only. The operative is equipped with the following melee weapon for the battle:", cost: 2, maxCounPerKillTeam: nil, body: nil, uniqueAction: nil, wargear: cuttinNozzleWargear)

let kustomForceField = Equipment(name: "KUSTOM FORCE FIELD", description: "SPANNER operative only. The operative gains the following ability for the battle:", cost: 3, maxCounPerKillTeam: 1, body: nil, uniqueAction: kustomForceFieldAbilitie, wargear: nil)

let kustomForceFieldAbilitie = Abilitie(name: "Kustom Force Field", description: "Each time an operative makes a shooting attack, if the target is wholly within  of this operative and the operative making the shooting attack is not, the target has a 5+ invulnerable save for that shooting attack.", cost: nil, weapon: nil)

let cuttinNozzleWargear = Weapon(name: "Cuttin’ nozzle", type: "close", attacks: 4, ballisticWeaponSkill: 3, damage: 3, critDamage: 5, specialRule: [lethal5], criticalHitspecialRule: nil)

let stikkbombWargear = Weapon(name: "stikkbomb", type: "range", attacks: 4, ballisticWeaponSkill: 3, damage: 2, critDamage: 4, specialRule: [rng6, limited, blast2, indirect], criticalHitspecialRule: nil)

//MARK: - Ploys
/*
let dakkaDakkaDakka = Ploy(name: "DAKKA! DAKKA! DAKKA", description: "Until the end of the Turning Point, each time a friendly GREENSKIN operative makes a shooting attack, in the Roll Attack Dice step of that shooting attack, if you retain any critical hits, you can select one of your failed hits to be retained as a successful normal hit.", cost: 1, type: "strategic")

let waaaagh = Ploy(name: "WAAAAGH!", description: "Until the end of the Turning Point, each time a friendly GREENSKIN operative fights in combat, in the Roll Attack Dice step of that combat, when you would retain two or more normal hits, you can select one of those hits to be retained as a critical hit instead.", cost: 1, type: "strategic")

let getStuckIn = Ploy(name: "GET STUCK IN!", description: "Until the end of the Turning Point, each time a friendly BOY operative performs a Fight action, in the Roll Attack Dice step of that combat, you can re-roll one of your attack dice.", cost: 1, type: "strategic")

let skulkAbout = Ploy(name: "SKULK ABOUT", description: "Until the end of the Turning Point, each time a shooting attack is made against a friendly CLAN KOMMANDO operative, in the Roll Defence Dice step of that shooting attack, before rolling defence dice, if it has a Conceal order, you can retain one as a successful normal save without rolling it.", cost: 1, type: "strategic")

let justAScratch = Ploy(name: "JUST A SCRATCH", description: "Use this Tactical Ploy in the Resolve Successful Hits step of a shooting attack or combat, when damage would be inflicted on a friendly GREENSKIN operative from an attack dice. Ignore the damage inflicted from that attack dice.", cost: 1, type: "tactical")

let moreDakka = Ploy(name: "MORE DAKKA", description: "Use this Tactical Ploy after making a shooting attack with a friendly GREENSKIN operative in which the target did not lose any wounds. Repeat that shooting attack.", cost: 1, type: "tactical")
*/

//MARK: TacOps


let blowItUp = TacOps(name: "BLOW IT UP!", type: .special, description: "You can reveal this Tac Op in the Target Reveal step of the first Turning Point. Your opponent selects one terrain feature that includes any parts with the Heavy trait to be their bulwark.", firstCondition: "If a friendly operative performs the Blow It Up! action, you score 2VPs.", victoryPointForfirstCondition: 1, secondCondition: nil, victoryPointSecondCondition: nil, subText: "Friendly operatives can perform the following mission action:", uniquiAction: actionBlowItUp)

let actionBlowItUp = UnitUniqueActions(name: "BLOW IT UP!", cost: 2, description: "An operative can perform this action while within 1' of your opponent’s bulwark. An operative cannot perform this action while within 2' of enemy operatives. Other than a Dash action, an operative cannot perform any other action during an activation in which it would perform this action.")

let shokkTaktiks = TacOps(name: "SHOKK TAKTIKS", type: .special, description: "Reveal this Tac Op at the end of the first Turning Point.", firstCondition: "If any enemy operatives were incapacitated during the first Turning Point, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "At the end of the second Turning Point, if friendly operatives control more objective markers than enemy operatives control, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let getStuckInTacOp = TacOps(name: "GET STUCK IN!", type: .special, description: "You can reveal this Tac Op in the Reveal Tac Ops step of any Turning Point.", firstCondition: "At the end of any Turning Point (excluding the fourth), if three or more friendly operatives are within 6' of your opponent’s drop zone, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If you achieve the first condition at the end of any subsequent Turning Points (excluding the fourth), you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

*/
