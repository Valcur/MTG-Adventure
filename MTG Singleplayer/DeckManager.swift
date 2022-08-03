//
//  DeckManager.swift
//  MTG Singleplayer
//
//  Created by Loic D on 01/08/2022.
//

import Foundation
import SwiftUI
 
struct DeckManager {
    
    static func getDeckFor(stage: Int, deckId: Int) -> ([Card], [Card], [Card]) {
        let deckData: String = readDeckDataFromFile(fileName: "\(stage)_\(deckId)")
        return createDeckListFromDeckData(deckData: deckData)
    }
    
    static func createDeckListFromDeckData(deckData: String) -> ([Card], [Card], [Card]){
        var deck = DeckList(deckBasic: [], deckMidrange: [], deckEndgame: [])
        
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
                    } else
                    {
                        // Or add card if its a card
                        let cardDataArray = line.components(separatedBy: " ")
                        
                        let cardCount = Int(cardDataArray[0]) ?? 0
                        var cardName = cardDataArray[4]
                        for i in 5..<cardDataArray.count - 2 {
                            cardName += " " + cardDataArray[i]
                        }
                        
                        let card = Card(cardName: cardName, cardType: getCardTypeFromTypeLine(typeLine: cardDataArray[2]), hasFlashback: cardDataArray[3] == DeckFilePattern.cardHaveFlashback, specificSet: cardDataArray[1], cardOracleId: cardDataArray[cardDataArray.count - 2], cardId: cardDataArray.last ?? "")
                        card.cardCount = cardCount
                        deck = addCardToSelectedDeck(card: card, selectedDeckListNumber: selectedDeckListNumber, deckList: deck)
                    }
                }
            }
        }
        
        return (deck.deckBasic.shuffled(), deck.deckMidrange.shuffled(), deck.deckEndgame.shuffled())
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
        static let cardHaveFlashback = "YES"
        static let cardDontHaveFlashback = "NO"
    }
    
    struct DeckManagerSelectedDeck {
        static let basicDeck = 1
        static let midrangeDeck = 2
        static let endgameDeck = 3
    }
}





/*
 ZOMBIE
 
 ## Horde Deck ##
 1 5DN creature NO Blind Creeper 02d4c3a8-c733-45c1-bca5-51eed47c9230 86d5440a-7460-4b4f-a167-a6c4fb2d855e
 4 USG creature NO Cackling Fiend 2029954b-6fa7-40d7-bb19-d7534c62be5d ae410ae8-1e72-4727-96df-c7c195063fb5
 1 TOR creature NO Carrion Wurm ed0cf504-c365-4486-92bc-c329b83b99d0 37c2b228-94c0-4e84-ad6d-80b170bb6c0c
 1 MIC creature NO Death Baron 99024aa8-5687-4d38-8a4b-feef42d6c1ff 11641a17-e979-4edb-adba-789f21fd017d
 1 MIC creature NO Fleshbag Marauder 4b1bf05e-753e-4350-a913-894cf3cecc0c a03c738c-88d9-4cf6-a650-20ce6e5565bc
 1 SLD creature NO Grave Titan f3abd4d1-a975-4e85-8684-aa0fce029670 8f1a018f-ce08-428b-9be2-937204dd25c2
 2 M19 creature NO Infectious Horror 0931206b-eed2-40d0-9496-5ecefc7f8f90 d17aaa92-10ca-4f70-b45e-5a51e9192efb
 3 PLS creature NO Maggot Carrier e4ad4b81-3685-4f95-84c0-755263b9d3b1 ab2c3dc4-bb49-4ec3-a6c8-4256d1939326
 2 MBS creature NO Nested Ghoul e60b6b71-eea8-42b3-81e2-c8fb1af5e218 c035ff58-9df3-4db4-b9d0-97d58080ecfe
 2 ISD creature NO Rotting Fensnake be22faba-07e0-4036-b700-82769989250b c21cbb10-9157-4887-a752-29b9e94fc77a
 2 10E creature NO Severed Legion 34a8a658-a5f6-406f-99d8-c32ea2e26202 82633f38-5af1-429e-8c9d-db536af85309
 1 TSP creature NO Skulking Knight 11e4c731-4212-4aad-891f-fe066ed0436f a7f7927b-64ae-4448-9540-8d7bbe88c9cc
 2 HOP creature NO Soulless One 27d98b94-a8a1-442b-8940-4ffab51b5164 410a214b-09c4-49bd-a461-3330d0249ae5
 1 ISD creature NO Unbreathing Horde e6cd9203-e4d3-4d9f-b59f-4e454fc5a477 1a91ea47-0c06-4333-a309-ac360c5cc9bd
 1 HOP creature NO Undead Warchief e6af56bf-bd78-4801-8f6e-033cdd68de3d 01482b0c-d05b-4356-9144-e044159f4dcb
 2 SCG creature NO Vengeful Dead 277c8ee9-0157-4e45-96ad-1b67716955ee 7c11c11d-9809-4031-8cbc-21aef07d7f1f
 1 ISD creature NO Walking Corpse fea95888-e16a-4209-9cd4-623f7f4d2f67 8e033384-3334-4082-9541-f2443d3bc424
 1 TSR creature NO Yixlid Jailer 1f55303e-1369-4e42-9ed4-36609887c7c1 3f2ef91f-d113-4e8d-a164-c6e261aa9c12

 2 GVL enchantment NO Bad Moon fc5d3341-cbce-49e5-93cc-8add92479dca 8f8a75da-ea3c-43e7-9d32-1c92f8ec0fd2
 1 M12 enchantment NO Call to the Grave db5a4c25-5ae5-4a04-be79-bdee39b9152c 5e1324b6-dba0-4aff-a403-a45d2b405f5b
 1 ISD enchantment NO Endless Ranks of the Dead 69d4ecac-4735-4667-bfc1-c8800b436d08 5db15c5f-80b7-4f7f-985a-9bbec3199ad9
 1 MIR enchantment NO Forsaken Wastes b9e61e68-9dc8-4295-95dc-dd66a0907c8c c9dbfc7c-164d-47b8-8f05-987864fca89b

 1 ISD sorcery NO Army of the Damned 75d667ec-86f4-4850-a3b6-e7a9fc7053b0 260a4544-a1eb-4d07-943f-0401ae288e13
 1 2X2 sorcery NO Damnation d57a8f0b-7989-4db5-8756-6f2690097252 d3c0aac5-b9f1-4446-bfea-3e1dd1cf1f2f
 2 MM3 sorcery NO Delirium Skeins 7397036f-8114-47cc-b52f-c532a6845d16 64b0d9e7-4a0f-4f07-99ae-31c3c9f0037a
 1 A25 sorcery NO Plague Wind 18ec721f-c1ac-4581-a61d-2f0b09d6bf92 72d21d0d-7de7-4f03-8663-002c9290512f
 1 DDJ sorcery NO Twilight's Call ae0a1d9c-19cb-42ee-97c3-464e38e84615 a6e04dd2-75ad-4427-93cc-37226340c2fb

 5 TBBD token NO Zombie Giant e7bba04b-be75-4857-a724-c9e2150d56ad be7e26e1-5db6-49ba-a88e-c79d889cd364
 55 TMH2 token NO Zombie ddc8c973-c31e-463f-be45-f3fa7d632362 3031bec1-c6dc-441f-9391-458bb1577c56

 ## Too Strong ##
 1 SLD creature NO Grave Titan f3abd4d1-a975-4e85-8684-aa0fce029670 8f1a018f-ce08-428b-9be2-937204dd25c2
 1 ISD sorcery NO Army of the Damned 75d667ec-86f4-4850-a3b6-e7a9fc7053b0 260a4544-a1eb-4d07-943f-0401ae288e13
 1 2X2 sorcery NO Damnation d57a8f0b-7989-4db5-8756-6f2690097252 d3c0aac5-b9f1-4446-bfea-3e1dd1cf1f2f
 1 A25 sorcery NO Plague Wind 18ec721f-c1ac-4581-a61d-2f0b09d6bf92 72d21d0d-7de7-4f03-8663-002c9290512f

 ## Available Tokens ##

 ## Weak Permanents ##
 1 EMN enchantment NO Graf Harvest d3ba6922-c2f7-45ab-87a3-d4bbd770d1ba fbc17697-9db9-41d4-aacf-b2f2e6ff80cf
 1 VOW creature NO Headless Rider d4fdacd7-3101-44e2-a880-dde7326137a4 c24018e8-b8f1-44a5-9355-8b79f363569d
 1 GPT enchantment NO Hissing Miasma e257d8e0-06e9-433d-a750-1962db399388 f394fd39-842f-4c98-b857-bdad3fd09758
 1 MIC enchantment NO Liliana's Mastery bd104c7e-311e-4b03-98d3-5f20f3a99d26 a92ee6ec-eebf-40b4-9dd9-c0551e33f5ff
 1 MIC enchantment NO Open the Graves 28778958-a1f9-4fea-b551-c193d1257f18 130978d1-0b20-4dfa-85f5-3ff2bc2cfda3

 ## Powerfull Permanents ##
 1 DOM creature NO Josu Vess, Lich Knight 974a46f9-aa84-4b34-bee5-c635166e5841 6ed6d088-db82-4648-a109-0e3fa1421847
 1 ME4 creature NO Zombie Master 5446c92f-ff22-4e9b-a2f6-e64c8560c1e0 c25eb8c9-4209-4fe4-8b02-be16d7d7bdf5
 */
