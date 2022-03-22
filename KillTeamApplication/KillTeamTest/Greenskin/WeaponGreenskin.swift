//
//  WeaponGreenskin.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation
/*
//MARK: - BoyzNob

let boyzNobPowerKlaw = Weapon(name: "Power klaw", type: "close", attacks: 4, ballisticWeaponSkill: 3, damage: 5, critDamage: 7, specialRule: [brutal], criticalHitspecialRule: nil)

let boyzNobKillsaw = Weapon(name: "Killsaw", type: "close", attacks: 4, ballisticWeaponSkill: 3, damage: 5, critDamage: 7, specialRule: nil, criticalHitspecialRule: [rending])

let boyzNobFists = Weapon(name: "Fists", type: "close", attacks: 3, ballisticWeaponSkill: 2, damage: 3, critDamage: 4, specialRule: nil, criticalHitspecialRule: nil)

let boyzNobChoppa = Weapon(name: "Choppa", type: "close", attacks: 4, ballisticWeaponSkill: 2, damage: 4, critDamage: 5, specialRule: nil, criticalHitspecialRule: nil)

let boyzNobBigChoppa = Weapon(name: "Big choppa", type: "close", attacks: 4, ballisticWeaponSkill: 2, damage: 5, critDamage: 6, specialRule: nil, criticalHitspecialRule: nil)

let boyzNobSlugga = Weapon(name: "Slugga", type: "range", attacks: 4, ballisticWeaponSkill: 5, damage: 3, critDamage: 4, specialRule: [rng6], criticalHitspecialRule: nil)

let boyzNobShoota = Weapon(name: "Shoota", type: "range", attacks: 4, ballisticWeaponSkill: 5, damage: 3, critDamage: 4, specialRule: nil, criticalHitspecialRule: nil)

let boyzNobKombiSkorcha = Weapon(name: "Kombi-skorcha", type: "range", attacks: 6, ballisticWeaponSkill: 2, damage: 2, critDamage: 2, specialRule: [greenSkinKombi, limited, rng6, torrent2], criticalHitspecialRule: nil)

let boyzNobKombiRokkit = Weapon(name: "Kombi-rokkit", type: "range", attacks: 5, ballisticWeaponSkill: 5, damage: 4, critDamage: 5, specialRule: [greenSkinKombi, limited, ap1], criticalHitspecialRule: [splash1])

//MARK: - BOYZ

let boyzFists = Weapon(name: "Fists", type: "close", attacks: 3, ballisticWeaponSkill: 3, damage: 3, critDamage: 4, specialRule: nil, criticalHitspecialRule: nil)

let boyzRokkitLauncha = Weapon(name: "Rokkit launcha", type: "range", attacks: 5, ballisticWeaponSkill: 5, damage: 4, critDamage: 5, specialRule: [ap1], criticalHitspecialRule: [splash1])

let boyzBigShoota = Weapon(name: "Big shoota", type: "range", attacks: 6, ballisticWeaponSkill: 5, damage: 2, critDamage: 3, specialRule: [fusillade], criticalHitspecialRule: nil)

let boyzChoppa = Weapon(name: "Choppa", type: "close", attacks: 4, ballisticWeaponSkill: 3, damage: 4, critDamage: 5, specialRule: nil, criticalHitspecialRule: nil)

let boyzSlugga = Weapon(name: "Slugga", type: "range", attacks: 4, ballisticWeaponSkill: 5, damage: 3, critDamage: 4, specialRule: [rng6], criticalHitspecialRule: nil)

let boyzShoota = Weapon(name: "Shoota", type: "range", attacks: 4, ballisticWeaponSkill: 5, damage: 3, critDamage: 4, specialRule: nil, criticalHitspecialRule: nil)

//MARK: - GRETCHIN

let gretchinBlasta = Weapon(name: "Gretchin blasta", type: "range", attacks: 3, ballisticWeaponSkill: 4, damage: 2, critDamage: 3, specialRule: [rng6], criticalHitspecialRule: nil)

let gretchinKnife = Weapon(name: "Gretchin knife", type: "close", attacks: 3, ballisticWeaponSkill: 5, damage: 1, critDamage: 2, specialRule: nil, criticalHitspecialRule: nil)

//MARK: - KOMMANDO

let commandoNobPowerKlaw = Weapon(name: "Power klaw", type: "close", attacks: 4, ballisticWeaponSkill: 3, damage: 5, critDamage: 7, specialRule: [brutal], criticalHitspecialRule: nil)

let commandoNobChoppa = Weapon(name: "Choppa", type: "close", attacks: 4, ballisticWeaponSkill: 2, damage: 4, critDamage: 5, specialRule: nil, criticalHitspecialRule: nil)

let commandoNobSlugga = Weapon(name: "Slugga", type: "range", attacks: 4, ballisticWeaponSkill: 4, damage: 3, critDamage: 4, specialRule: [rng6], criticalHitspecialRule: nil)

let commandoSlugga = Weapon(name: "Slugga", type: "range", attacks: 4, ballisticWeaponSkill: 5, damage: 3, critDamage: 4, specialRule: [rng6], criticalHitspecialRule: nil)

let commandoChoppa = Weapon(name: "Choppa", type: "close", attacks: 4, ballisticWeaponSkill: 3, damage: 4, critDamage: 5, specialRule: nil, criticalHitspecialRule: nil)

//MARK: - LootasWeapon

let fists = Weapon(name: "Fists", type: "close", attacks: 3, ballisticWeaponSkill: 3, damage: 3, critDamage: 4, specialRule: nil, criticalHitspecialRule: nil)

let rokkitLauncha = Weapon(name: "Rokkit launcha", type: "range", attacks: 5, ballisticWeaponSkill: 4, damage: 4, critDamage: 5, specialRule: [ap1], criticalHitspecialRule: [splash1])

let kustomMegablasta = Weapon(name: "Kustom mega-blasta", type: "range", attacks: 4, ballisticWeaponSkill: 4, damage: 5, critDamage: 6, specialRule: [ap2, hot], criticalHitspecialRule: nil)

let bigShoota = Weapon(name: "Big shoota", type: "range", attacks: 6, ballisticWeaponSkill: 4, damage: 2, critDamage: 3, specialRule: [fusillade], criticalHitspecialRule: nil)

let deffgun = Weapon(name: "Deffgun", type: "range", attacks: 5, ballisticWeaponSkill: 5, damage: 4, critDamage: 6, specialRule: nil, criticalHitspecialRule: nil)

let burna = Weapon(name: "Burna", type: "range", attacks: 5, ballisticWeaponSkill: 2, damage: 2, critDamage: 2, specialRule: [rng6, torrent2], criticalHitspecialRule: nil)


//MARK: - Specil Rules

let fusillade = WeaponSpecialRule(name: "Fusillade", description: "Each time a friendly operative performs a Shoot action and selects this weapon, after selecting a valid target, you can select any number of other valid targets within 2' of the original target. Distribute your attack dice between the targets you have selected. Make a shooting attack with this weapon (using the same profile) against each of the targets you have selected using the attack dice you have distributed to each of them.")

let ap1 = WeaponSpecialRule(name: "AP1", description: "Armour Penetration. Each time a friendly operative makes a shooting attack with this weapon, subtract x from the Defence of the target for that shooting attack, x is the number after the weapon’s AP, e.g. AP1. If two different APx special rules would be in effect for a shooting attack, they are not cumulative - the attacker selects which one to use.")

let ap2 = WeaponSpecialRule(name: "AP2", description: "Armour Penetration. Each time a friendly operative makes a shooting attack with this weapon, subtract x from the Defence of the target for that shooting attack, x is the number after the weapon’s AP, e.g. AP1. If two different APx special rules would be in effect for a shooting attack, they are not cumulative - the attacker selects which one to use.")

let hot = WeaponSpecialRule(name: "Hot", description: "Each time a friendly operative makes a shooting attack with this weapon, in the Roll Attack Dice step of that shooting attack, for each attack dice result of 1 that is discarded, that operative suffers three mortal wounds.")

let splash1 = WeaponSpecialRule(name: "Splash 1", description: "Each time a friendly operative makes a shooting attack with this weapon, in the Roll Attack Dice step of that shooting attack, for each critical hit retained, inflict x mortal wounds on the target and each other operative Visible to and within 2' of it. x is the number after the weapon’s Splash, e.g. Splash 1.")

let rng6 = WeaponSpecialRule(name: "Rng 6", description: "Range. Each time a friendly operative makes a shooting attack with this weapon, only operatives within x are a valid target, x is the distance after the weapon’s Rng, e.g. Rng 6'. All other rules for selecting a valid target still apply.")

let torrent2 = WeaponSpecialRule(name: "Torrent 2", description: "Each time a friendly operative performs a Shoot action or Overwatch action and selects this weapon, after making the shooting attack against the target, it can make a shooting attack with this weapon against each other valid target within x of the original target and each other, x is the distance after the weapon’s Torrent, e.g. Torrent 2'.")

let brutal = WeaponSpecialRule(name: "Brutal", description: "Each time a friendly operative fights in combat with this weapon, in the Resolve Successful Hits step of that combat, your opponent can only parry with critical hits.")

let rending = WeaponSpecialRule(name: "Rending", description: "Each time a friendly operative fights in combat or makes a shooting attack with this weapon, in the Roll Attack Dice step of that combat or shooting attack, if you retain any critical hits you can retain one normal hit as a critical hit.")

let limited = WeaponSpecialRule(name: "Limited", description: "This weapon can only be selected for use once per battle. If the weapon has a special rule that would allow it to make more than one shooting attack for an action (e.g. Blast), make each of those attacks as normal.")

let greenSkinKombi = WeaponSpecialRule(name: "Kombi", description: "An operative equipped with this weapon is also equipped with a shoota.")

let blast2 = WeaponSpecialRule(name: "Blast 2", description: "Each time a friendly operative performs a Shoot action and selects this weapon (or, in the case of profiles, this weapon’s profile), after making the shooting attack against the target, make a shooting attack with this weapon (using the same profile) against each other operative Visible to and within X of the original target – each of them is a valid target and cannot be in Cover. X is the distance after the weapon’s Blast, e.g. Blast 2'. An operative cannot make a shooting attack with this weapon by performing an Overwatch action.")

let indirect = WeaponSpecialRule(name: "Indirect", description: "Each time a friendly operative makes a shooting attack with this weapon, in the select valid target step of that shooting attack, enemy operatives are not in Cover.")

let lethal5 = WeaponSpecialRule(name: "Lethal 5+", description: "Each time a friendly operative fights in combat or makes a shooting attack with this weapon, in the Roll Attack Dice step of that combat or shooting attack, your attack dice results of equal to or greater than x that are successful hits are critical hits, x is the number after the weapon’s Lethal, e.g. Lethal 5+.")
 */

let headhunter = TacOps(name: "HEADHUNTER", type: .seekandDestroy, description: "Reveal this Tac Op when an enemy LEADER operative is incapacitated.", firstCondition: "You score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If it is the first or second Turning Point, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let challenge = TacOps(name: "CHALLENGE", type: .seekandDestroy, description: "Reveal this Tac Op in the Target Reveal step of the first Turning Point. Select one enemy operative and one friendly operative.", firstCondition: "If that enemy operative is incapacitated by that friendly operative, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If you achieve the first condition while that enemy operative is within 6' of that friendly operative, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let rout = TacOps(name: "ROUT", type: .seekandDestroy, description: "You can reveal this Tac Op in the Target Reveal step of any Turning Point.", firstCondition: "If an enemy operative is incapacitated by a friendly operative that is within  of your opponent’s drop zone, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If you achieve the first condition in any subsequent Turning Points, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let execution = TacOps(name: "EXECUTION", type: .seekandDestroy, description: "Reveal this Tac Op at the end of any Turning Point in which more enemy operatives than friendly operatives were incapacitated during that Turning Point.", firstCondition: "At the end of the battle, if more enemy operatives than friendly operatives were incapacitated during two or more Turning Points, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "At the end of the battle, if more enemy operatives than friendly operatives were incapacitated during three or more Turning Points, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let deadlyMarksman = TacOps(name: "DEADLY MARKSMAN", type:.seekandDestroy, description: "After selecting this Tac Op, secretly select one friendly operative to be your Marksman. You can reveal this Tac Op when an enemy operative is incapacitated by a shooting attack made by your Marksman while your Marksman is wholly within 3' of your drop zone.", firstCondition: "If any other enemy operatives are incapacitated by another shooting attack made by your Marksman, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "At the end of the battle, if you achieved the first condition and your Marksman has not been incapacitated, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let robAndRansack = TacOps(name: "ROB AND RANSACK", type: .seekandDestroy, description: "You can reveal this Tac Op when an enemy operative is incapacitated by a friendly operative within 1' of it, and that friendly operative is more than 3' from other enemy operatives.", firstCondition: "You score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "At the end of the battle, if you achieved the first condition and that friendly operative has not been incapacitated, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)


let seizeGround = TacOps(name: "SEIZE GROUND", type: .security, description: "Reveal this Tac Op in the Target Reveal step of the first Turning Point. Select one terrain feature that is more than 3' from your drop zone and includes any parts with the Heavy trait.", firstCondition: "At the end of the battle, if the total APL of friendly operatives within 1' of that terrain feature is greater than that of enemy operatives, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If you achieve the first condition, there are no enemy operatives on or within 1' of that terrain feature, and the total APL of friendly operatives within 1' of that terrain feature is 4 or more, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let holdTheLine = TacOps(name: "HOLD THE LINE", type: .security, description: "You can reveal this Tac Op in the Target Reveal step of any Turning Point after the first.", firstCondition: "At the end of any Turning Point, if there are no enemy operatives within 6' of your drop zone, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If you achieve the first condition at the end of any subsequent Turning Points, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let protectAssets = TacOps(name: "PROTECT ASSETS", type: .security, description: "You can reveal this Tac Op in the Target Reveal step of any Turning Point.", firstCondition: "At the end of any Turning Point, if two or more enemy operatives were incapacitated while within 2' of an objective marker during that Turning Point, and/or while carrying an objective during that Turning Point, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If you achieve the first condition at the end of any subsequent Turning Points, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let damageLimitation = TacOps(name: "DAMAGE LIMITATION", type: .security, description: "You can reveal this Tac Op in the Target Reveal step of any Turning Point after the first.", firstCondition: "At the end of any Turning Point, if no friendly operatives were incapacitated during that Turning Point, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If you achieve the first condition at the end of any subsequent Turning Points, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)

let tacOpsActionDestroyBanner = UnitUniqueActions(name: "DESTROY BANNER", cost: 1, description: "An operative can perform this action while within  of the centre of an opponent’s Banner token. Remove that Banner token from the killzone. An operative cannot perform this action while within  of enemy operatives.", subText: nil, wargear: nil, postSubText: nil)

let plantBanner = TacOps(name: "PLANT BANNER", type: .security, description: "After selecting this Tac Op, secretly select one friendly operative to be carrying your Banner token. Reveal this Tac Op when that operative drops your Banner token. When you do, until the end of the battle, the Pick Up action can be performed by friendly operatives upon your Banner token.", firstCondition: "At the end of the battle, if your Banner token is within 6' of but not wholly within your opponent’s drop zone, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "At the end of the battle, if your Banner token is wholly within your opponent’s drop zone, you score 2VP.", victoryPointSecondCondition: 1, subText: "Operatives can perform the following mission action:", uniquiAction: tacOpsActionDestroyBanner)

let centralControl = TacOps(name: "CENTRAL CONTROL", type: .security, description: "You can reveal this Tac Op in the Target Reveal step of any Turning Point.", firstCondition: "At the end of any Turning Point, if the total APL of friendly operatives within 3' of the centre of the killzone is greater than that of enemy operatives, you score 1VP.", victoryPointForfirstCondition: 1, secondCondition: "If you achieve the first condition at the end of any subsequent Turning Points, you score 1VP.", victoryPointSecondCondition: 1, subText: nil, uniquiAction: nil)


