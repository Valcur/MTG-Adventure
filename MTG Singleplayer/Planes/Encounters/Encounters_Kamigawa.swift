//
//  Encounters.swift
//  MTG Singleplayer
//
//  Created by Loic D on 02/08/2022.
//

import Foundation

// All encounters
extension Encounters {
    
    static let plane_kamigawa =
    [
        "Kamigawa_Forest_Intro": Encounter(title: "Peacefull forest walk", id: "Kamigawa_Forest_Intro", artistName: "Piotr Dura",
                                    choices: [
                                        EncounterChoice(title: "Go off road", encounterId: ["Kamigawa_Forest_Attack", "Kamigawa_Forest_Attack", "Kamigawa_Forest_Haven", "Kamigawa_Forest_Penitent"]),
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: [EncounterChoice.randomEncounter, "Kamigawa_Forest_Attack"])
                                    ]),
        
        "Kamigawa_Shrine": Encounter(title: "Time to shrine", id: "Kamigawa_Shrine", artistName: "Johannes Voss",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Kamigawa_Shrine")
                                    ]),
        
        "Kamigawa_Water_Intro": Encounter(title: "Hangar", id: "Kamigawa_Water_Intro", artistName: "Piotr Dura",
                                    choices: [
                                        EncounterChoice(title: "Follow the river", encounterId: ["Kamigawa_Water_Haven", "Kamigawa_Water_Fight", "Kamigawa_Water_Fight"]),
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: [EncounterChoice.randomEncounter, "Kamigawa_Water_Fight"])
                                    ]),

        "Kamigawa_Swamp_Intro": Encounter(title: "Lost in the swamps", id: "Kamigawa_Swamp_Intro", artistName: "Julian Kok Joon Wen",
                                    choices: [
                                        EncounterChoice(title: "Follow the light", encounterId: "Kamigawa_Swamp_Lost_01"),
                                        EncounterChoice(title: "Venture into the woods", encounterId: "Kamigawa_Swamp_Lost_End")
                                    ]),
    ]
    
    static let plane_kamigawa_double = [
        
        "Kamigawa_Otawara_Intro": Encounter(title: "Otawara", id: "Kamigawa_Otawara_Intro", artistName: "Yuta Shimpo",
                                    choices: [
                                        EncounterChoice(title: "Help the city of Otawara", encounterId: "Kamigawa_Otawara_Fight_01"),
                                    ]),
        
        "Kamigawa_Samurai_Intro": Encounter(title: "A city in the distance", id: "Kamigawa_Samurai_Intro", artistName: "Piotr Dura",
                                    choices: [
                                        EncounterChoice(title: "Approach the city", encounterId: "Kamigawa_Samurai_MakeAChoice")
                                    ]),
    ]
    
    static let plane_kamigawa_ending = [

        "Kamigawa_Boseiju": Encounter(title: "Towashi", id: "Kamigawa_Boseiju", artistName: "Chris Ostrowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_01")
                                    ]),
        
        "Kamigawa_Forge_01": Encounter(title: "Forge", id: "Kamigawa_Forge_01", artistName: "Alayna Danner",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_02")
                                    ]),
    ]
    
    static let plane_kamigawa_direct = [
        
        "Kamigawa_Intro": Encounter(title: "Kamigawa", id: "Kamigawa_Intro", artistName: "Piotr Dura",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Shop": Encounter(title: "Shop", id: "Kamigawa_Shop", artistName: "Adam Paquette",
                                    offer: [
                                       .gold(OffersPrices.cardsPrice, .booster, .repeatable),
                                       .gold(OffersPrices.lifePrice, .life(1), .repeatable)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Rat
        
        "Kamigawa_Rat_01": Encounter(title: "Towashi", id: "Kamigawa_Rat_01", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_02")
                                    ]),
        
        "Kamigawa_Rat_02": Encounter(title: "Towashi", id: "Kamigawa_Rat_02", artistName: "Manuel Casta????n",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_03", deckToFight: "Kamigawa_Ninja_01")
                                    ]),
        
        "Kamigawa_Rat_03": Encounter(title: "Towashi", id: "Kamigawa_Rat_03", artistName: "Raymond Swanland",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_04", deckToFight: "Kamigawa_Ninja_02")
                                    ]),
        
        "Kamigawa_Rat_04": Encounter(title: "Towashi", id: "Kamigawa_Rat_04", artistName: "Ilse Gort",
                                    reward: [.permanentBonus("Kamigawa_Rat")],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.planeEnd, encounterId: EncounterChoice.planeEnd)
                                    ]),
        
        // MARK: Forge
        
        "Kamigawa_Forge_02": Encounter(title: "Forge", id: "Kamigawa_Forge_02", artistName: "Chris Rahn",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_03", deckToFight: "Kamigawa_Forge_01")
                                    ]),
        
        "Kamigawa_Forge_03": Encounter(title: "Forge", id: "Kamigawa_Forge_03", artistName: "Isis Sangar??",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_04", deckToFight: "Kamigawa_Forge_02")
                                    ]),
        
        "Kamigawa_Forge_04": Encounter(title: "Forge", id: "Kamigawa_Forge_04", artistName: "Julian Kok Joon Wen",
                                    reward: [.permanentBonus("Kamigawa_Forge")],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.planeEnd, encounterId: EncounterChoice.planeEnd)
                                    ]),
        
        // MARK: Forest
        
        "Kamigawa_Forest_Attack": Encounter(title: "Forest", id: "Kamigawa_Forest_Attack", artistName: "Ryan Pancoast",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Kamigawa_BG")
                                    ]),
        
        "Kamigawa_Forest_Haven": Encounter(title: "Forest", id: "Kamigawa_Forest_Haven", artistName: "Lorenzo Lanfranconi",
                                    reward: [.life(1)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Forest_Penitent": Encounter(title: "Penitent Warlord", id: "Kamigawa_Forest_Penitent", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: "Follow him", encounterId: "Kamigawa_Forest_Offer"),
                                        EncounterChoice(title: "Ignore and continue", encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Forest_Offer": Encounter(title: "Offer to the spirit", id: "Kamigawa_Forest_Offer", artistName: "Aurore Folny",
                                    offer: [.gold(5, .life(1), .nonrepeatable)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Samurai
        
        "Kamigawa_Samurai_MakeAChoice": Encounter(title: "Make a choice", id: "Kamigawa_Samurai_MakeAChoice", artistName: "Johan Grenier",
                                    choices: [
                                        EncounterChoice(title: "Help the imperial army", encounterId: "Kamigawa_Samurai_ImperialSide_01", deckToFight: "Kamigawa_Invader_01"),
                                        EncounterChoice(title: "Help the invading army", encounterId: "Kamigawa_Samurai_InvaderSide_01", deckToFight: "Kamigawa_Imperial_01")
                                    ]),
        
        "Kamigawa_Samurai_ImperialSide_01": Encounter(title: "Fight the invader", id: "Kamigawa_Samurai_ImperialSide_01", artistName: "Ryan Pancoast",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Samurai_ImperialSide_02", deckToFight: "Kamigawa_Invader_02")
                                    ]),
        
        "Kamigawa_Samurai_ImperialSide_02": Encounter(title: "Reward", id: "Kamigawa_Samurai_ImperialSide_02", artistName: "Randy Vargas",
                                    reward: [.gold(50)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Samurai_InvaderSide_01": Encounter(title: "Fight the empire", id: "Kamigawa_Samurai_InvaderSide_01", artistName: "Nicholas Elias",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Samurai_InvaderSide_02", deckToFight: "Kamigawa_Imperial_02")
                                    ]),
        
        "Kamigawa_Samurai_InvaderSide_02": Encounter(title: "Reward", id: "Kamigawa_Samurai_InvaderSide_02", artistName: "Joseph Weston",
                                    reward: [.partner],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Otawara
        
        "Kamigawa_Otawara_Fight_01": Encounter(title: "Fight", id: "Kamigawa_Otawara_Fight_01", artistName: "Victor Adame Minguez",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Otawara_Hangar", deckToFight: "Kamigawa_Vehicle_01")
                                    ]),
        
        "Kamigawa_Otawara_Hangar": Encounter(title: "Hangar", id: "Kamigawa_Otawara_Hangar", artistName: "Julian Kok Joon Wen",
                                    reward: [.gold(10)],
                                    choices: [
                                        EncounterChoice(title: "Fight the remaining troups", encounterId: "Kamigawa_Otawara_Fight_02"),
                                        EncounterChoice(title: "Send some soldiers to sabotage the enemy mechs", encounterId: "Kamigawa_Otawara_Fight_02_B")
                                    ]),
        
        "Kamigawa_Otawara_Fight_02": Encounter(title: "Fight", id: "Kamigawa_Otawara_Fight_02", artistName: "Victor Adame Minguez",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Otawara_Reward", deckToFight: "Kamigawa_Vehicle_02")
                                    ]),
        
        "Kamigawa_Otawara_Fight_02_B": Encounter(title: "Fight", id: "Kamigawa_Otawara_Fight_02_B", artistName: "Victor Adame Minguez",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Otawara_Reward", deckToFight: "Kamigawa_Vehicle_02_B")
                                    ]),
        
        "Kamigawa_Otawara_Reward": Encounter(title: "Reward", id: "Kamigawa_Otawara_Reward", artistName: "Alayna Danner",
                                    reward: [.gold(30)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Water
    
        "Kamigawa_Water_Fight": Encounter(title: "Reward", id: "Kamigawa_Water_Fight", artistName: "Jesper Ejsing",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Kamigawa_Water")
                                    ]),
        
        "Kamigawa_Water_Haven": Encounter(title: "Reward", id: "Kamigawa_Water_Haven", artistName: "Ryan Pancoast",
                                    reward: [.life(1)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Swamp
        
        "Kamigawa_Swamp_Lost_01": Encounter(title: "Cemetery", id: "Kamigawa_Swamp_Lost_01", artistName: "Alayna Danner",
                                    choices: [
                                        EncounterChoice(title: "Walk through the cemetery", encounterId: "Kamigawa_Swamp_Lost_Fight"),
                                        EncounterChoice(title: "Venture into the woods", encounterId: "Kamigawa_Swamp_Lost_02")
                                    ]),
        
        "Kamigawa_Swamp_Lost_Fight": Encounter(title: "Cemeterey", id: "Kamigawa_Swamp_Lost_Fight", artistName: "Jason A. Engle",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Kamigawa_Swamp")
                                    ]),
        
        "Kamigawa_Swamp_Lost_02": Encounter(title: "Lost in the swamps", id: "Kamigawa_Swamp_Lost_02", artistName: "Piotr Dura",
                                    choices: [
                                        EncounterChoice(title: "Stay in the water", encounterId: "Kamigawa_Swamp_Lost_Fight"),
                                        EncounterChoice(title: "Back to the ground and venture into the woods", encounterId: "Kamigawa_Swamp_Lost_End")
                                    ]),
        
        "Kamigawa_Swamp_Lost_Success": Encounter(title: "A hidden Kami", id: "Kamigawa_Swamp_Lost_Success", artistName: "Marta Nael",
                                    reward: [.life(2)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Swamp_Lost_End": Encounter(title: "Lost in the swamps", id: "Kamigawa_Swamp_Lost_End", artistName: "Jesper Ejsing",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Mountain
        
        /*www.artofmtg.com/art/mountain-35/
        /www.artofmtg.com/art/swiftwater-cliffs-2/
        www.artofmtg.com/art/goblin-shaman-token/
         */
    ]
}
