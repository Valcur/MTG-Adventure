//
//  Encounters.swift
//  MTG Singleplayer
//
//  Created by Loic D on 02/08/2022.
//

import Foundation

struct Encounter {
    let title: String
    let description: String
    let imageName: String
    let artistName: String
    let reward: Reward?
    let choices: [EncounterChoice]
}

class EncounterChoice: Identifiable {
    let title: String
    let encounterId: String
    let deckToFight: String?
    
    static let randomEncounter: String = "Random" // Use this as encounterId if no specific encounter for this choice
    static let deckEncounter: String = "DeckEncounter:"
    static let defaultTitle: String = "Continue"
    
    init(title: String, encounterId: String, deckToFight: String? = nil) {
        self.title = title
        self.encounterId = encounterId
        self.deckToFight = deckToFight
    }
    
    static func == (lhs: EncounterChoice, rhs: EncounterChoice) -> Bool {
        return lhs.title == rhs.title && lhs.encounterId == rhs.encounterId
    }
    
}

struct Reward {
    let title: String
    let imageName: String
    
    static let boosterReward = Reward(title: "open a booster", imageName: "boosterIcon")
    static let lifeReward = Reward(title: "restore a life", imageName: "lifeIcon")
    static let gold10Reward = Reward(title: "10 gold", imageName: "gold")
}

// All encounters
class Encounters {
    static let plane_kamigawa =
    [
        "Kamigawa_Intro": Encounter(title: "Kamigawa", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Intro", artistName: "Adam Paquette",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: "Fight", encounterId: EncounterChoice.randomEncounter, deckToFight: "AA"),
                                        EncounterChoice(title: "Run", encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Break_01": Encounter(title: "Peacefull forest walk", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forest", artistName: "Piotr Dura",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Kamigawa_Break_02": Encounter(title: "A city in the distance", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Plain", artistName: "Piotr Dura",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        /*
        "Kamigawa_Rat_01": Encounter(title: "Rat", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Rat_01", artistName: "Adam Paquette",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_02")
                                    ]),
        */
        "Kamigawa_Forge_01": Encounter(title: "Forge", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forge_01", artistName: "Alayna Danner",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_02")
                                    ]),
        
    ]
    
    static let plane_kamigawa_direct = [
        
        // MARK: Rat
        
        "Kamigawa_Rat_02": Encounter(title: "Fight 1", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Rat_02", artistName: "Manuel Castañón",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_03", deckToFight: "AA")
                                    ]),
        
        "Kamigawa_Rat_03": Encounter(title: "Fight 2", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Rat_03", artistName: "Raymond Swanland",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Rat_04", deckToFight: "AA")
                                    ]),
        
        "Kamigawa_Rat_04": Encounter(title: "Victory", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Rat_04", artistName: "Ilse Gort",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Forge
        
        "Kamigawa_Forge_02": Encounter(title: "Fight 1", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forge_02", artistName: "Chris Rahn",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_03", deckToFight: "Kamigawa_Forge_01")
                                    ]),
        
        "Kamigawa_Forge_03": Encounter(title: "Fight 2", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forge_03", artistName: "Isis Sangaré",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Kamigawa_Forge_04", deckToFight: "Kamigawa_Forge_02")
                                    ]),
        
        "Kamigawa_Forge_04": Encounter(title: "Victory", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Forge_04", artistName: "Julian Kok Joon Wen",
                                    reward: nil,
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
    ]
}

class Desciptions {
    static let Kamigawa_Intro = "The world of Kamigawa, positioned far from any other world we know, is governed by the interplay between the mortals and the kami, minor gods or spirits of the world. The Kakuriyo or Reikai is the spirit world where the kami dwell; its other half is that of the Utsushiyo where mortals live. Together they form a sphere that makes the whole of the world."
}
