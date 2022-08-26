//
//  DeckManager.swift
//  MTG Singleplayer
//
//  Created by Loic D on 01/08/2022.
//

import Foundation
import SwiftUI
 
struct DeckManager {
    
    static func getDeckFor(deckName: String, stage: Int) -> ([Card], [Card], [Card], [Card], Card?) {
        let deckData: String = readDeckDataFromFile(fileName: "\(deckName)")
        return createDeckListFromDeckData(deckData: deckData)
    }
    
    static func createDeckListFromDeckData(deckData: String) -> ([Card], [Card], [Card], [Card], Card?){
        var deck = DeckList(deckBasic: [], deckMidrange: [], deckEndgame: [], tokensAvailable: [])
        var bossCard: Card? = nil
        
        if deckData != "" {
            let allLines = deckData.components(separatedBy: "\n")
            var selectedDeckListNumber = DeckManagerSelectedDeck.basicDeck
            
            for line in allLines {
                if line.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                    // Change current decklist to add cards to
                    if line == DeckFilePattern.basicDeck {
                        selectedDeckListNumber = DeckManagerSelectedDeck.basicDeck
                    } else if line == DeckFilePattern.midrangeDeck {
                        selectedDeckListNumber = DeckManagerSelectedDeck.midrangeDeck
                    } else if line == DeckFilePattern.endgameDeck {
                        selectedDeckListNumber = DeckManagerSelectedDeck.endgameDeck
                    } else if line == DeckFilePattern.tokensAvailable {
                        selectedDeckListNumber = DeckManagerSelectedDeck.tokensAvailable
                    } else if line == DeckFilePattern.bossCard {
                        selectedDeckListNumber = DeckManagerSelectedDeck.boss
                    } else
                    {
                        // Or add card if its a card
                        let cardDataArray = line.components(separatedBy: " ")
                        
                        let cardCount = Int(cardDataArray[0]) ?? 0
                        var cardName = cardDataArray[4]
                        for i in 5..<cardDataArray.count - 2 {
                            cardName += " " + cardDataArray[i]
                        }
                        
                        let cardAttributes = cardDataArray[3].split(separator: "-")
                        let cardHasFlashBack = cardAttributes[0] == DeckFilePattern.cardHaveFlashback
                        let cardShouldAttack = cardAttributes.count > 1 ? cardAttributes[1].contains(DeckFilePattern.cardShouldAttack) : false
                        let cardShouldBlock = cardAttributes.count > 1 ? cardAttributes[1].contains(DeckFilePattern.cardShouldBlock) : false
                        
                        let card = Card(cardName: cardName, cardType: getCardTypeFromTypeLine(typeLine: cardDataArray[2]), hasFlashback: cardHasFlashBack, shouldCardAttack: cardShouldAttack, shouldCardBlock: cardShouldBlock, specificSet: cardDataArray[1], cardOracleId: cardDataArray[cardDataArray.count - 2], cardId: cardDataArray.last ?? "")
                        card.cardCount = cardCount
                        
                        if selectedDeckListNumber == DeckManagerSelectedDeck.boss {
                            bossCard = card
                        } else {
                            deck = addCardToSelectedDeck(card: card, selectedDeckListNumber: selectedDeckListNumber, deckList: deck)
                        }
                    }
                }
            }
        }
        
        return (deck.deckBasic.shuffled(), deck.deckMidrange.shuffled(), deck.deckEndgame.shuffled(), deck.tokensAvailable, bossCard)
    }
    
    private static func addCardToSelectedDeck(card: Card, selectedDeckListNumber: Int, deckList: DeckList) -> DeckList {
        var deck = deckList
        if selectedDeckListNumber == DeckManagerSelectedDeck.basicDeck
        {
            deck.deckBasic = addCardToDeck(card: card, deck: deck.deckBasic)
        }
        else if selectedDeckListNumber == DeckManagerSelectedDeck.midrangeDeck
        {
            deck.deckMidrange = addCardToDeck(card: card, deck: deck.deckMidrange)
        }
        else if selectedDeckListNumber == DeckManagerSelectedDeck.endgameDeck
        {
            deck.deckEndgame = addCardToDeck(card: card, deck: deck.deckEndgame)
        }
        else if selectedDeckListNumber == DeckManagerSelectedDeck.tokensAvailable
        {
            deck.tokensAvailable.append(card)
        }
        
        return deck
    }
    
    static func getCardTypeFromTypeLine(typeLine: String) -> CardType {
        if typeLine.contains("oken") {
            return CardType.token
        } else if typeLine.contains("reature") {
            return CardType.creature
        } else if typeLine.contains("nchantment") {
            return CardType.enchantment
        } else if typeLine.contains("rtifact") {
            return CardType.artifact
        } else if typeLine.contains("orcery") {
            return CardType.sorcery
        } else if typeLine.contains("nstant") {
            return CardType.instant
        }
        return CardType.enchantment
    }
    
    private static func addCardToDeck(card: Card, deck: [Card], onlyAddOne: Bool = false) -> [Card] {
        let tmpCard = card.recreateCard()
        tmpCard.cardCount = 1
        var tmpDeck = deck
        if onlyAddOne {
            tmpDeck.append(tmpCard)
        } else {
            for _ in 0..<card.cardCount {
                tmpDeck.append(tmpCard.recreateCard())
            }
        }
        return tmpDeck
    }
    
    private static func readDeckDataFromFile(fileName: String) -> String {

        if let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        {
            let fm = FileManager()
            let exists = fm.fileExists(atPath: path)
            if(exists){
                let content = fm.contents(atPath: path)
                let contentAsString = String(data: content!, encoding: String.Encoding.utf8)
                return contentAsString!
            }
        }
        return ""
    }
    
    struct DeckFilePattern {
        static let basicDeck: String = "## Basic Deck ##"
        static let midrangeDeck: String = "## Midrange Deck ##"
        static let endgameDeck: String = "## Endgame Deck ##"
        static let tokensAvailable: String = "## Tokens ##"
        static let bossCard: String = "## Boss ##"
        static let cardHaveFlashback = "YES"
        static let cardDontHaveFlashback = "NO"
        static let cardShouldAttack = "A"
        static let cardShouldBlock = "B"
    }
}

struct DeckManagerSelectedDeck {
    static let basicDeck = 1
    static let midrangeDeck = 2
    static let endgameDeck = 3
    static let tokensAvailable = 4
    static let boss = 5
}
