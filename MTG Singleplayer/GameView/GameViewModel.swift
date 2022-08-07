//
//  GameViewModel.swift
//  MTG Singleplayer
//
//  Created by Loic D on 01/08/2022.
//

import Foundation

class GameViewModel: ObservableObject {
    var deck: DeckList
    var cardsToCast: CardsToCast
    @Published var hand: [Card]
    @Published var manaCount: Int
    let startEndGameAtMana: Int = 5
    @Published var board: [Card]
    @Published var graveyard: [Card]
    @Published var showCardsToCastView: Bool = false
    @Published var showGraveyardView: Bool = false
    @Published var gameResult: Int                      // 0 = game in progress, 1 = game won, -1 = game lost
    
    /// AI TURN
    ///
    /// 1. Draw a card from one of the deck at random following this rule
    ///         roll a 6 sided die :
    ///             - 1 - 4 : Play top card of basic deck
    ///             - 5 - 6 : Play top card of midrange deck
    ///         after some turns, it become :
    ///          - 1 - 3 : Play top card of basic deck
    ///          - 4 -5 : Play top card of midrange deck
    ///          -  6 : Play top card of endgame deck
    ///  Show the card with any card from the AI hand and wait for player input
    ///
    ///  2. Add those cards to the board, graveyard or any zone where the card is supposed to go
    ///
    
    init(deckName: String, stage: Int) {
        let deckData = DeckManager.getDeckFor(deckName: deckName, stage: stage)
        let deckBasic: [Card] = deckData.0
        let deckMidrange: [Card] = deckData.1
        let deckEndgame: [Card] = deckData.2
        self.deck = DeckList(deckBasic: deckBasic, deckMidrange: deckMidrange, deckEndgame: deckEndgame)
        self.cardsToCast = CardsToCast(cardsFromLibrary: [], cardsFromHand: [], cardsFromGraveyard: [])
        self.hand = []
        self.manaCount = 0
        self.board = []
        self.graveyard = []
        self.gameResult = 0
    }
    
    
    
    // Draw a card from one of the random deck if not empty, if empty draw from another one, if all empty return nil
    private func drawCardFromRandomDeck() -> Card? {
        let dieResult = Int.random(in: 1...6)
        
        if manaCount < startEndGameAtMana {
            if dieResult < 5 {
                return getBasicCardFromDeck()
            } else {
                return getMidrangeCardFromDeck()
            }
        } else {
            if dieResult < 4 {
                return getBasicCardFromDeck()
            } else if dieResult < 6 {
                return getMidrangeCardFromDeck()
            } else {
                return getEndgameCardFromDeck()
            }
        }
    }
    
    private func setUpCardsToCastWith(cardFromLibrary: Card) {
        cardsToCast.cardsFromLibrary.append(cardFromLibrary)
        cardsToCast.cardsFromHand = self.hand
        
        cardsToCast.cardsFromHand = Card.regroupSameCardsInArray(cardsToCast.cardsFromHand)
        cardsToCast.cardsFromLibrary = Card.regroupSameCardsInArray(cardsToCast.cardsFromLibrary)
        cardsToCast.cardsFromGraveyard = Card.regroupSameCardsInArray(cardsToCast.cardsFromGraveyard)
        
        self.hand = []
    }
    
    private func addCardToBoad(card: Card) {
        // type and attack/not attack make the card appears at different place
        board.append(card)
        board = Card.regroupSameCardsInArray(board)
    }
    
    private func sendToGraveyard(card: Card) {
        graveyard.append(card)
    }
    
    private func castCard(card: Card) {
        if card.cardType == .instant || card.cardType == .sorcery {
            sendToGraveyard(card: card)
        } else {
            addCardToBoad(card: card)
        }
    }
    
    func removeOneCardOnBoard(card: Card) {
        for i in (0..<board.count) {
            let c = board[i]
            if card == c {
                c.cardCount -= 1
                if c.cardCount <= 0 {
                    board.remove(at: i)
                }
                return
            }
        }
    }
}

// MARK: Draw from decks
extension GameViewModel {
    private func getBasicCardFromDeck() -> Card? {
        if !deck.deckBasic.isEmpty {
            print("Draw from basic")
            return deck.deckBasic.removeFirst()
        } else if !deck.deckMidrange.isEmpty {
            print("Draw from midrange as basic is empty")
            return deck.deckMidrange.removeFirst()
        } else {
            print("Draw from endgame as basic and midrange are empty")
            return deck.deckEndgame.removeFirst()
        }
    }
    
    private func getMidrangeCardFromDeck() -> Card? {
        if !deck.deckMidrange.isEmpty {
            print("Draw from midrange")
            return deck.deckMidrange.removeFirst()
        } else if !deck.deckBasic.isEmpty {
            print("Draw from basic as midrange is empty")
            return deck.deckBasic.removeFirst()
        } else {
            print("Draw from endgame as midrange and basic are empty")
            return deck.deckEndgame.removeFirst()
        }
    }
    
    private func getEndgameCardFromDeck() -> Card? {
        if !deck.deckEndgame.isEmpty {
            print("Draw from endgame")
            return deck.deckEndgame.removeFirst()
        } else if !deck.deckMidrange.isEmpty {
            print("Draw from midrange as endgame is empty")
            return deck.deckMidrange.removeFirst()
        } else {
            print("Draw from basic as endgame and midrange are empty")
            return deck.deckBasic.removeFirst()
        }
    }
}

// MARK: Buttons
extension GameViewModel {
    
    // Starting step 1
    func newTurn() {
        manaCount += 1
        let card = drawCardFromRandomDeck()
        if card != nil {
            setUpCardsToCastWith(cardFromLibrary: card!)
        } else {
            // All decks are empty, player won
            gameResult = 1
        }
        showCardsToCastView = true
    }
    
    // Ending step 1
    func closeCardsToCast() {
        showCardsToCastView = false
        
        for card in cardsToCast.cardsFromGraveyard {
            castCard(card: card)
        }
        
        for card in cardsToCast.cardsFromHand {
            castCard(card: card)
        }
        
        for card in cardsToCast.cardsFromLibrary {
            castCard(card: card)
        }
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + AnimationsDuration.average) {
            self.cardsToCast = CardsToCast(cardsFromLibrary: [], cardsFromHand: [], cardsFromGraveyard: [])
        //}
    }
    
    func drawCard() {
        let card = drawCardFromRandomDeck()
        if card != nil {
            hand.append(card!)
        } else {
            // All decks are empty, player won
            gameResult = 1
        }
    }
    
    func destroyPermanent(card: Card) {
        removeOneCardOnBoard(card: card)
        let tmpCard = card.recreateCard()
        tmpCard.cardCount = 1
        sendToGraveyard(card: tmpCard)
    }
    
    func exileFromGraveyard(card: Card) {
        for i in (0..<graveyard.count) {
            let c = graveyard[i]
            if card == c {
                graveyard.remove(at: i)
                return
            }
        }
    }
    
    func castFromGraveyard(card: Card) {
        castCard(card: card)
        exileFromGraveyard(card: card)
    }
    
    func returnToHandFromGraveyard(card: Card) {
        hand.append(card)
        exileFromGraveyard(card: card)
    }
}
