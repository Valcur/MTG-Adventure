//
//  Extensions_Class.swift
//  MTG Singleplayer
//
//  Created by Loic D on 06/08/2022.
//

import Foundation

class Encounter {
    let title: String
    let description: String
    let imageName: String
    let artistName: String
    let reward: [Reward]?
    let offer: [Offer]?
    let choices: [EncounterChoice]
    
    init(title: String, description: String, imageName: String, artistName: String, reward: Reward? = nil, offer: Offer? = nil, choices: [EncounterChoice]) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.artistName = artistName
        if reward != nil {
            self.reward = [reward!]
        } else {
            self.reward = nil
        }
        if offer != nil {
            self.offer = [offer!]
        } else {
            self.offer = nil
        }
        self.choices = choices
    }
    
    init(title: String, description: String, imageName: String, artistName: String, reward: [Reward]? = nil, offer: [Offer]? = nil, choices: [EncounterChoice]) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.artistName = artistName
        self.reward = reward
        self.offer = offer
        self.choices = choices
    }
    
    init(title: String, description: String, imageName: String, artistName: String, choices: [EncounterChoice]) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.artistName = artistName
        self.reward = nil
        self.offer = nil
        self.choices = choices
    }
}

class EncounterChoice: Identifiable {
    let title: String
    let encounterId: [String]
    let deckToFight: String?
    
    static let randomEncounter: String = "Random" // Use this as encounterId if no specific encounter for this choice
    static let deckEncounter: String = "DeckEncounter:"
    static let defaultTitle: String = "Continue"
    
    init(title: String, encounterId: String, deckToFight: String? = nil) {
        self.title = title
        self.encounterId = [encounterId]
        self.deckToFight = deckToFight
    }
    
    init(title: String, encounterId: [String], deckToFight: String? = nil) {
        self.title = title
        self.encounterId = encounterId
        self.deckToFight = deckToFight
    }
    
    static func == (lhs: EncounterChoice, rhs: EncounterChoice) -> Bool {
        return lhs.title == rhs.title && lhs.encounterId == rhs.encounterId
    }
    
}

class Reward {
    let title: String
    let imageName: String
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    static let reward_boosterReward = Reward(title: "open a booster", imageName: "boosterIcon")
    static let reward_life1 = RewardLife(value: 1)
    static let reward_gold10 = RewardGold(value: 10)
}

class RewardGold: Reward {
    let value: Int
    
    init(value: Int) {
        self.value = value
        super.init(title: "+ \(value)", imageName: "Gold")
    }
}

class RewardLife: Reward {
    let value: Int
    
    init(value: Int) {
        self.value = value
        super.init(title: "+ \(value)", imageName: "Life")
    }
}

class Offer: Reward {
    let cost: Cost
    let repeatable: Bool
    
    init(title: String, imageName: String, cost: Cost, repeatable: Bool = false) {
        self.cost = cost
        self.repeatable = repeatable
        super.init(title: title, imageName: imageName)
    }
    
    static let offer_life1 = Offer(title: "1 life", imageName: "Life", cost: Cost.cost_gold10)
}

class Cost {
    let title: String
    let value: Int
    
    init(title: String, value: Int = 0) {
        self.title = title
        self.value = value
    }
    
    static let cost_gold10 = CostGold(value: 10)
    static let cost_life1 = CostLife(value: 1)
}

class CostGold: Cost {
    init(value: Int) {
        super.init(title: "x \(value)", value: value)
    }
}

class CostLife: Cost {
    init(value: Int) {
        super.init(title: "x \(value)", value: value)
    }
}
