//
//  Extensions_Class.swift
//  MTG Singleplayer
//
//  Created by Loic D on 06/08/2022.
//

import Foundation
import SwiftUI

class Encounter {
    let title: String
    let id: String
    let artistName: String
    let reward: [Reward]?
    let offer: [Offer]?
    let choices: [EncounterChoice]
    
    init(title: String, id: String, artistName: String, reward: Reward? = nil, offer: Offer? = nil, choices: [EncounterChoice]) {
        self.title = title
        self.id = id
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
    
    init(title: String, id: String, artistName: String, reward: [Reward]? = nil, offer: [Offer]? = nil, choices: [EncounterChoice]) {
        self.title = title
        self.id = id
        self.artistName = artistName
        self.reward = reward
        self.offer = offer
        self.choices = choices
    }
    
    init(title: String, id: String, artistName: String, choices: [EncounterChoice]) {
        self.title = title
        self.id = id
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
    static let planeEnd: String = "Planeswalk"
    
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

enum Offer: Equatable {
    case gold(Int, Reward, Repeatable)
    case life(Int, Reward, Repeatable)
    
    enum Repeatable {
        case repeatable
        case nonrepeatable
    }
    
    func title() -> String {
        switch self {
        case .gold(let value, _, _):
            return "x \(value)"
        case .life(let value, _, _):
            return "x \(value)"
        }
    }
    
    func reward() -> Reward {
        switch self {
        case .gold(_, let reward, _):
            return reward
        case .life(_, let reward, _):
            return reward
        }
    }
    
    func isRepeatable() -> Bool {
        switch self {
        case .gold(_, _, let isRepeatable):
            return isRepeatable == .repeatable
        case .life(_, _, let isRepeatable):
            return isRepeatable == .repeatable
        }
    }
}

enum Reward: Equatable {
    case gold(Int)
    case life(Int)
    case booster
    case partner
    case permanentBonus(String)
    
    func image() -> Image? {
        switch self {
        case .gold(_):
            return Image("Gold")
        case .life(_):
            return Image("Life")
        case .booster:
            return Image("Booster")
        case .partner:
            return Image("Partner")
        case .permanentBonus(_):
            return nil
        }
    }
    
    func title() -> String {
        switch self {
        case .gold(let value):
            return "+ \(value)"
        case .life(let value):
            return "+ \(value)"
        case .booster:
            return "Open a booster"
        case .partner:
            return "Get a new partner"
        case .permanentBonus(let bonusName):
            return NSLocalizedString(bonusName, tableName: "PermanentBonusText", comment: "Player permanent bonus")
        }
    }
}
