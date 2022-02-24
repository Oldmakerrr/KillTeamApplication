//
//  UnitGreenskin.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import Foundation

//MARK: - Boyz

let boyzFireTeam = FireTeam(name: "Boy Fire Team", archetype: ["SEEK & DESTROY", "SECURITY"], availableDataslates: [boyFighter, boyBosNob, boyGunner, gretchin], currentDataslates: [boyFighter, boyFighter, boyFighter, boyFighter, boyFighter])

let boyFighter: Unit = {
    var unit = Unit(name: "BOY (FIGHTER)", customName: nil, typeUnit: .combat, description: "Boyz form the muscled, brutal majority of any teeming Ork horde. No self-respecting Ork would be without a loud slugga and at least one enormous choppa with which to vent their wild fury. They live only for the joy of violence and the clamouring din of war.", portrait: "boyz_fighter", movement: 3, actionPointLimit: 2, groupActivation: 1, defense: 3, save: 5, wounds: 10, selectedCloseWeapon: boyzChoppa, availableWeapon: [boyzShoota, boyzSlugga, boyzChoppa, boyzFists], abilities: nil, uniqueActions: nil, keyWords: ["GREENSKIN", "ORK", "<CLAN>", "BOY", "FIGHTER"])
    unit.selectedRangeWeapon = boyzSlugga
    return unit
}()

let boyBosNob: Unit = {
    var unit = Unit(name: "BOSS NOB", customName: nil, typeUnit: .combat, description: "Orks grow bigger and more belligerent the more they fight. Over time, the most experienced fighters become hulking greenskins. Nobz have survived endless war and infighting through a combination of strength, cunning and the instinct to destroy anything that challenges them.", portrait: "", movement: 3, actionPointLimit: 2, groupActivation: 1, defense: 3, save: 4, wounds: 13, selectedCloseWeapon: boyzNobBigChoppa, availableWeapon: [boyzNobKombiRokkit, boyzNobKombiSkorcha, boyzNobShoota, boyzNobSlugga, boyzNobBigChoppa, boyzNobChoppa, boyzNobFists, boyzNobKillsaw, boyzNobPowerKlaw], abilities: nil, uniqueActions: nil, keyWords: ["GREENSKIN", "ORK", "<CLAN>", "LEADER", "BOY", "BOSS NOB"])
    unit.selectedRangeWeapon = boyzNobSlugga
    return unit
}()

let boyGunner: Unit = {
    var unit = Unit(name: "BOY (GUNNER)", customName: nil, typeUnit: .marksman, description: "Orks enjoy the din and recoil of the large firearms they refer to collectively as shootas, as much as the weapons’ gory results. Shootas are often cobbled together from scrap, but unleash hails of solid shot that can rip apart almost anything through sheer volume.", portrait: "", movement: 3, actionPointLimit: 2, groupActivation: 1, defense: 3, save: 5, wounds: 10, selectedCloseWeapon: boyzFists, availableWeapon: [boyzBigShoota, boyzRokkitLauncha], abilities: nil, uniqueActions: nil, keyWords: ["GREENSKIN", "ORK", "<CLAN>", "BOY", "GUNNER"])
    unit.selectedRangeWeapon = boyzBigShoota
    return unit
}()

let runtAbilities = UnitAbilities(name: "Rant", description: "This operative cannot be equipped with equipment. This operative cannot benefit from your Strategic and Tactical Ploys.")

let testUniqueActions = UnitUniqueActions(name: "Enhanced Data-tether", cost: 1, description: "Select one friendly HUNTER CLADE operative Visible to and within  of this operative. Add 1 to its APL. This operative cannot perform this action while within Engagement Range of an enemy operative !THIS TEST ACTION!.")

let gretchin: Unit = {
    var unit = Unit(name: "GRETCHIN", customName: nil, typeUnit: .scout, description: "Gretchin - or grots - are stunted, sneaky and vicious. They are more nimble than their Ork masters, able to squeeze through narrow spaces and operate more complicated gubbins. Their sharp eyes enable them to act as lookouts and sentries, and their screech of alarm is piercing.", portrait: "", movement: 3, actionPointLimit: 2, groupActivation: 2, defense: 3, save: 6, wounds: 5, selectedCloseWeapon: gretchinKnife, availableWeapon: [gretchinBlasta], abilities: [runtAbilities, runtAbilities, runtAbilities], uniqueActions: [testUniqueActions, testUniqueActions], keyWords: ["GREENSKIN", "ORK", "<CLAN>", "BOY", "GRETCHIN"])
    unit.selectedRangeWeapon = gretchinBlasta
    return unit
    

}()
//MARK: - KOMMANDO

let clanKommandoFireTeam = FireTeam(name: "Clan Kommando Fire Team", archetype: ["SEEK & DESTROY", "INFILTRATION"], availableDataslates: [clanCommandoFighter, clanCommandoNob], currentDataslates: [clanCommandoFighter, clanCommandoFighter, clanCommandoFighter, clanCommandoFighter, clanCommandoFighter,])

let clanCommandoFighter: Unit = {
    var unit = Unit(name: "CLAN KOMMANDO (FIGHTER)", customName: nil, typeUnit: .combat, description: "Kommandos epitomise the Orky virtue of low cunning, taking a less directly confrontational approach to their peers. Few things make them happier than sneaking up on an unsuspecting enemy and hacking, slashing and shooting before the foe can strike back.", portrait: "", movement: 3, actionPointLimit: 2, groupActivation: 1, defense: 3, save: 5, wounds: 10, selectedCloseWeapon: commandoChoppa, availableWeapon: [commandoChoppa,commandoSlugga], abilities: nil, uniqueActions: nil, keyWords: ["GREENSKIN", "ORK", "<CLAN>", "CLAN KOMMANDO", "FIGHTER"])
    unit.selectedRangeWeapon = commandoSlugga
    return unit
}()

let clanCommandoNob: Unit = {
    var unit = Unit(name: "CLAN KOMMANDO NOB", customName: nil, typeUnit: .combat, description: "The sneakiest of all their tribe’s sneaky gits, Kommando Nobs are both brutal and cunning enough to boss about the most conniving of their species as they lead espionage operations behind enemy lines.", portrait: "", movement: 3, actionPointLimit: 2, groupActivation: 1, defense: 3, save: 4, wounds: 13, selectedCloseWeapon: commandoNobChoppa, availableWeapon: [commandoNobChoppa,commandoNobSlugga, commandoNobPowerKlaw], abilities: nil, uniqueActions: nil, keyWords: ["GREENSKIN", "ORK", "<CLAN>", "LEADER", "CLAN KOMMANDO", "KOMMANDO NOB"])
    unit.selectedRangeWeapon = commandoNobSlugga
    return unit
}()



//MARK: - LOOTA

let speshulistFireTeam = FireTeam(name: "Speshulist Fire Team", archetype: ["SEEK & DESTROY"], availableDataslates: [burnaBoy, lootaBoy, spanner], currentDataslates: [lootaBoy, lootaBoy, lootaBoy, lootaBoy])


let burnaBoy: Unit = {
    var unit = Unit(name: "BURNA BOY", customName: nil, typeUnit: .marksman, description: "Burna Boyz are pyromaniacs all, obsessed with raging infernos - the bigger and hotter the better. Their burnas can weed hiding enemies out of cover, belching roaring flames that rush into defensive networks and incinerate lighter barriers entirely.", portrait: "", movement: 3, actionPointLimit: 2, groupActivation: 1, defense: 3, save: 5, wounds: 10, selectedCloseWeapon: fists, availableWeapon: [burna], abilities: nil, uniqueActions: nil, keyWords: ["GREENSKIN", "ORK", "<CLAN>", "SPESHULIST", "BURNA BOY"])
    unit.selectedRangeWeapon = burna
    return unit
}()

let lootaBoy: Unit = {
    var unit = Unit(name: "LOOTA", customName: nil, typeUnit: .marksman, description: "Lootas are the most heavily armed of all Orks - because they steal the best weapons from everyone else! They are kleptomaniacs obsessed with owning and firing the loudest and most destructive guns, modifying them to make them ever more ostentatious and killy.", portrait: "", movement: 3, actionPointLimit: 2, groupActivation: 1, defense: 3, save: 5, wounds: 10, selectedCloseWeapon: fists, availableWeapon: [deffgun], abilities: nil, uniqueActions: nil, keyWords: ["GREENSKIN", "ORK", "<CLAN>", "SPESHULIST", "LOOTA"])
    unit.selectedRangeWeapon = deffgun
    return unit
}()
    
let spanner: Unit = {
    var unit = Unit(name: "SPANNER", customName: nil, typeUnit: .marksman, description: "On the lower hierarchical rungs of the madcap geniuses known as Meks, Spanners help to keep Ork technology working. They obsessively acquire loot and scrap to build weapons and contraptions, as well as kustom weapons that unleash strange energy beams or ammo.", portrait: "", movement: 3, actionPointLimit: 2, groupActivation: 1, defense: 3, save: 5, wounds: 11, selectedCloseWeapon: fists, availableWeapon: [bigShoota, kustomMegablasta, rokkitLauncha], abilities: nil, uniqueActions: nil, keyWords: ["GREENSKIN", "ORK", "<CLAN>", "LEADER", "SPESHULIST", "SPANNER"])
    unit.selectedRangeWeapon = bigShoota
    return unit
}()



