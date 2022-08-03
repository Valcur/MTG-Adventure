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
    static let randomEncounter: String = "Random" // Use this as encounterId if no specific encounter for this choice
    static let deckEncounter: String = "DeckEncounter:"
    
    init(title: String, encounterId: String) {
        self.title = title
        self.encounterId = encounterId
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
        "Kamigawa_Intro": Encounter(title: "Kamigawa", description: Desciptions.Kamigawa_Intro, imageName: "Kamigawa_Intro", artistName: "Adam Paquette", reward: nil,
                                    choices: [EncounterChoice(title: "Go to the city", encounterId: ""), EncounterChoice(title: "Run", encounterId: "")])
    ]
}

class Desciptions {
    static let Kamigawa_Intro = "The world of Kamigawa, positioned far from any other world we know, is governed by the interplay between the mortals and the kami, minor gods or spirits of the world. The Kakuriyo or Reikai is the spirit world where the kami dwell; its other half is that of the Utsushiyo where mortals live. Together they form a sphere that makes the whole of the world."
}
