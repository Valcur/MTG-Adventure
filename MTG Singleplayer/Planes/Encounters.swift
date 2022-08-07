//
//  Encounters.swift
//  MTG Singleplayer
//
//  Created by Loic D on 02/08/2022.
//

import Foundation

// All encounters
class Encounters {
    static let plane_kamigawa =
    [
        "Kamigawa_Intro": Encounter(title: "Kamigawa", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Intro", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: "Fight", encounterId: EncounterChoice.randomEncounter, deckToFight: "AA"),
                                        EncounterChoice(title: "Run", encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Forest": Encounter(title: "Peacefull forest walk", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forest", artistName: "Piotr Dura",
                                    choices: [
                                        EncounterChoice(title: "Go off road", encounterId: ["Kamigawa_Forest_Attack", "Kamigawa_Forest_Break", "Kamigawa_Forest_Penitent"]),
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Shop": Encounter(title: "Shop", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Shop", artistName: "Adam Paquette",
                                    offer: [Offer.offer_life1, Offer.offer_life1, Offer.offer_life1],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Samurai_Intro": Encounter(title: "A city in the distance", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Plain", artistName: "Piotr Dura",
                                    reward: Reward.reward_life1,
                                    choices: [
                                        EncounterChoice(title: "Approach the city", encounterId: "Kamigawa_Samurai_MakeAChoice")
                                    ]),
        
        "Kamigawa_Shrine": Encounter(title: "Time to shrine", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Shrine", artistName: "Johannes Voss",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Kamigawa_Shrine")
                                    ]),
        
        /*
        "Kamigawa_Rat_01": Encounter(title: "Rat", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Rat_01", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_02")
                                    ]),
        */
        /*
        "Kamigawa_Forge_01": Encounter(title: "Forge", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forge_01", artistName: "Alayna Danner",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_02")
                                    ]),
     */
    ]
    
    static let plane_kamigawa_direct = [
        
        // MARK: Rat
        
        "Kamigawa_Rat_02": Encounter(title: "Fight 1", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Rat_02", artistName: "Manuel Castañón",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_03", deckToFight: "AA")
                                    ]),
        
        "Kamigawa_Rat_03": Encounter(title: "Fight 2", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Rat_03", artistName: "Raymond Swanland",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_04", deckToFight: "AA")
                                    ]),
        
        "Kamigawa_Rat_04": Encounter(title: "Victory", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Rat_04", artistName: "Ilse Gort",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Forge
        
        "Kamigawa_Forge_02": Encounter(title: "Fight 1", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forge_02", artistName: "Chris Rahn",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_03", deckToFight: "Kamigawa_Forge_01")
                                    ]),
        
        "Kamigawa_Forge_03": Encounter(title: "Fight 2", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forge_03", artistName: "Isis Sangaré",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_04", deckToFight: "Kamigawa_Forge_02")
                                    ]),
        
        "Kamigawa_Forge_04": Encounter(title: "Victory", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forge_04", artistName: "Julian Kok Joon Wen",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Forest
        
        "Kamigawa_Forest_Attack": Encounter(title: "Fight", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forest_Attack", artistName: "Ryan Pancoast",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Kamigawa_BG")
                                    ]),
        
        "Kamigawa_Forest_Break": Encounter(title: "Fight", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forest_Haven", artistName: "Lorenzo Lanfranconi",
                                    reward: Reward.reward_life1,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Forest_Penitent": Encounter(title: "Penitent Warlord", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forest_Penitent", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: "Follow him", encounterId: "Kamigawa_Forest_Offer"),
                                        EncounterChoice(title: "Ignore and continue", encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Forest_Offer": Encounter(title: "Offer to the spirit", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forest_Offer", artistName: "Aurore Folny",
                                    offer: Offer.offer_life1,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Samurai
        
        "Kamigawa_Samurai_MakeAChoice": Encounter(title: "Fight", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Invader_ChooseSide", artistName: "Johan Grenier",
                                    choices: [
                                        EncounterChoice(title: "Help the imperial army", encounterId: "Kamigawa_Samurai_ImperialSide_01", deckToFight: "Kamigawa_Invader_01"),
                                        EncounterChoice(title: "Help the invading army", encounterId: "Kamigawa_Samurai_InvaderSide_01", deckToFight: "Kamigawa_Imperial_01")
                                    ]),
        
        "Kamigawa_Samurai_ImperialSide_01": Encounter(title: "Fight the invader", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Invader_Imperial_01", artistName: "Ryan Pancoast",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Samurai_ImperialSide_02", deckToFight: "Kamigawa_Invader_02")
                                    ]),
        
        "Kamigawa_Samurai_ImperialSide_02": Encounter(title: "Reward", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Invader_Imperial_02", artistName: "Randy Vargas",
                                    reward: Reward.reward_life1,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Samurai_InvaderSide_01": Encounter(title: "Fight the empire", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Invader_Invader_01", artistName: "Nicholas Elias",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Samurai_InvaderSide_02", deckToFight: "Kamigawa_Imperial_02")
                                    ]),
        
        "Kamigawa_Samurai_InvaderSide_02": Encounter(title: "Reward", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Invader_Invader_02", artistName: "Joseph Weston",
                                    reward: Reward.reward_life1,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
    
    ]
}

class Desciptions {
    static let Kamigawa_Intro = "The world of Kamigawa, positioned far from any other world we know, is governed by the interplay between the mortals and the kami, minor gods or spirits of the world. The Kakuriyo or Reikai is the spirit world where the kami dwell; its other half is that of the Utsushiyo where mortals live. Together they form a sphere that makes the whole of the world."
}
