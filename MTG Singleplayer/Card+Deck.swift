//
//  Card+Deck.swift
//  MTG Singleplayer
//
//  Created by Loic D on 31/07/2022.
//

import Foundation
import SwiftUI

class Card: Hashable, Identifiable, ObservableObject {
    
    let id = UUID()
    let cardName: String
    var cardType: CardType // Can be changed in deckeditor
    let cardImageURL: String
    @Published var cardUIImage: Image = Image("BlackBackground")
    var hasFlashback: Bool
    let shouldCardAttack: Bool
    let shouldCardBlock: Bool
    let specificSet: String
    let cardOracleId: String    // Unique id of a card but same for each reprints
    let cardId: String          // Unique id of card and unique between reprints
    @Published var cardCount: Int = 1
    let cardEffect: CardEffect
    @Published var countersOnCard: Int = 0
    let cardInDeck: Int = DeckManagerSelectedDeck.basicDeck
        
    init(cardName: String, cardType: CardType, cardImageURL: String = "get-on-scryfall", cardUIImage: Image = Image("BlackBackground"), hasFlashback: Bool = false, shouldCardAttack: Bool = false, shouldCardBlock: Bool = false, specificSet: String = "", cardOracleId: String = "", cardId: String = ""){
        self.cardType = cardType
        self.hasFlashback = hasFlashback
        self.shouldCardAttack = shouldCardAttack
        self.shouldCardBlock = shouldCardBlock
        self.cardUIImage = cardUIImage
        self.specificSet = specificSet.uppercased()
        self.cardOracleId = cardOracleId
        self.cardId = cardId
        self.cardEffect = CardsEffects.cardsEffects_Kamigawa[cardName] ?? CardEffect()
   
        // Remove after "//" in name, example : "Amethyst Dragon // Explosive Crystal" -> only keep Amethyst Dragon
        var cardNameString = ""
        if let index = cardName.range(of: " //")?.lowerBound {
            let substring = cardName[..<index]
            let string = String(substring)
            cardNameString = "\(string)"
        } else {
            cardNameString = "\(cardName)"
        }
        cardNameString = cardNameString.trimmingCharacters(in: .whitespacesAndNewlines)
        //self.cardName = "\(cardNameString)\(cardType == .token && !cardName.contains(specificSet) ?
        self.cardName = cardNameString
        
        if cardImageURL == "get-on-scryfall" {
            self.cardImageURL = Card.getScryfallImageUrl(id: cardId, specifiSet: specificSet)
        } else {
            self.cardImageURL = cardImageURL
        }
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardId == rhs.cardId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cardId)
    }
    
    func recreateCard() -> Card {
        let tmpCard = Card(cardName: self.cardName, cardType: self.cardType, cardImageURL: self.cardImageURL, hasFlashback: self.hasFlashback, shouldCardAttack: self.shouldCardAttack, shouldCardBlock: self.shouldCardBlock, specificSet: self.specificSet, cardOracleId: self.cardOracleId, cardId: self.cardId)
        tmpCard.cardCount = self.cardCount
        tmpCard.cardUIImage = self.cardUIImage
        return tmpCard
    }
    
    // NEED CHANGE TO USE getUrlCardName
    static func getScryfallImageUrl(name: String, specifiSet: String = "") -> String {
        let cardResolution = "normal"
        //let cardNameForUrl = name.replacingOccurrences(of: " ", with: "+")
        let cardNameForUrl = name
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: ",", with: "") // Maybe "-" instead of "" ?????
            .replacingOccurrences(of: "'", with: "")
        var url = "https://api.scryfall.com/cards/named?exact=\(cardNameForUrl)&format=img&version=\(cardResolution)"
        // Example https://api.scryfall.com/cards/named?exact=Zombie+Giant&format=img&version=normal

        if specifiSet != "" {
            url.append("&set=\(specifiSet)")
        }
        print(url)
        return url
    }
    
    static func getScryfallImageUrl(id: String, specifiSet: String = "") -> String {
        let cardResolution = "normal"
        let url = "https://api.scryfall.com/cards/\(id)?format=img&version=\(cardResolution)"

        print(url)
        return url
    }
    
    static func emptyCard() -> Card {
        return Card(cardName: "Polyraptor", cardType: .token)
    }
    
    func getUrlCardName() -> String {
        var cardNameForUrl = self.cardName
        /*
        if self.cardType == .token {
            cardNameForUrl = cardNameForUrl
                .replacingOccurrences(of: " \(self.specificSet)", with: "")
        }*/
        
        cardNameForUrl = cardNameForUrl
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "'", with: "")
            
        
        return cardNameForUrl
    }
    
    func downloadImage() {
        DownloadManager.shared.startDownloading(card: self)
    }
    
    static func regroupSameCardsInArray(_ cardArray: [Card]) -> [Card] {
        var tmpArray = cardArray
        var i = 0
        while i < tmpArray.count {
            var j = i + 1
            while j < tmpArray.count {
                if tmpArray[i] == tmpArray[j] && tmpArray[i].countersOnCard == 0 && tmpArray[j].countersOnCard == 0 {
                    tmpArray[i].cardCount += tmpArray[j].cardCount
                    tmpArray.remove(at: j)
                    j -= 1
                }
                j += 1
            }
            i += 1
        }
        return tmpArray
    }
}

enum CardType {
    case token
    case creature
    case enchantment
    case artifact
    case sorcery
    case instant
    case planeswalker
}

struct DeckList {
    var deckBasic: [Card]
    var deckMidrange: [Card]
    var deckEndgame: [Card]
    var tokensAvailable: [Card]
}

struct CardsToCast {
    var cardsFromLibrary: [Card]
    var cardsFromHand: [Card]
    var cardsFromGraveyard: [Card]
}
