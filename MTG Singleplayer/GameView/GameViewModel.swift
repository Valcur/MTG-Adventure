//
//  GameViewModel.swift
//  MTG Singleplayer
//
//  Created by Loic D on 01/08/2022.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    var deck: DeckList
    var cardsToCast: CardsToCast
    @Published var hand: [Card]
    @Published var manaCount: Int
    let startEndGameAtMana: Int = 5
    @Published var board: [Card]
    var bossCard: Card?
    @Published var graveyard: [Card]
    @Published var stack: [StackCard]
    @Published var showCardsToCastView: Bool = false
    @Published var showGraveyardView: Bool = false
    @Published var gameResult: Int                      // 0 = game in progress, 1 = game won, -1 = game lost
    let deckName: String
    let stage: Int
    let lifePointsViewModel: LifePointsViewModel
    let numberOfPlayer: Int
    
    // For buttons
    @Published var onlyShowAttackers: Bool = false
    @Published var onlyShowBlockers: Bool = false
    @Published var returnToHandModeEnable: Bool = false
    @Published var addCountersModeEnable: Bool = false
    @Published var removeCountersModeEnable: Bool = false
    
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
    
    init(deckName: String, stage: Int, numberOfPlayer: Int) {
        let deckData = DeckManager.getDeckFor(deckName: deckName, stage: stage)
        let deckBasic: [Card] = deckData.0
        let deckMidrange: [Card] = deckData.1
        let deckEndgame: [Card] = deckData.2
        let tokens: [Card] = deckData.3
        self.bossCard = deckData.4
        self.deck = DeckList(deckBasic: deckBasic, deckMidrange: deckMidrange, deckEndgame: deckEndgame, tokensAvailable: tokens)
        self.cardsToCast = CardsToCast(cardsFromLibrary: [], cardsFromHand: [], cardsFromGraveyard: [])
        self.hand = []
        self.manaCount = 0
        self.board = []
        self.graveyard = []
        self.stack = []
        self.gameResult = 0
        self.deckName = deckName
        self.stage = stage
        self.lifePointsViewModel = LifePointsViewModel()
        self.numberOfPlayer = numberOfPlayer
    }
    
    // Will have to do dometing cleaner at some point
    func reset() {
        let deckData = DeckManager.getDeckFor(deckName: deckName, stage: stage)
        let deckBasic: [Card] = deckData.0
        let deckMidrange: [Card] = deckData.1
        let deckEndgame: [Card] = deckData.2
        let tokens: [Card] = deckData.3
        self.bossCard = deckData.4
        self.deck = DeckList(deckBasic: deckBasic, deckMidrange: deckMidrange, deckEndgame: deckEndgame, tokensAvailable: tokens)
        self.cardsToCast = CardsToCast(cardsFromLibrary: [], cardsFromHand: [], cardsFromGraveyard: [])
        self.hand = []
        self.manaCount = 0
        self.board = []
        self.graveyard = []
        self.stack = []
        self.gameResult = 0
        self.lifePointsViewModel.reset()
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
    
    private func setUpCardsToCastWith(cardsFromLibrary: [Card]) {
        cardsToCast.cardsFromLibrary = cardsFromLibrary
        cardsToCast.cardsFromHand = self.hand
        cardsToCast.cardsFromGraveyard = getCardInGraveyardWithFlashback()
        
        cardsToCast.cardsFromHand = Card.regroupSameCardsInArray(cardsToCast.cardsFromHand)
        cardsToCast.cardsFromLibrary = Card.regroupSameCardsInArray(cardsToCast.cardsFromLibrary)
        cardsToCast.cardsFromGraveyard = Card.regroupSameCardsInArray(cardsToCast.cardsFromGraveyard)
        
        self.hand = []
    }
    
    private func getCardInGraveyardWithFlashback() -> [Card] {
        var cards: [Card] = []
        for card in graveyard {
            if card.hasFlashback {
                cards.append(card)
                exileFromGraveyard(card: card)
            }
        }
        return cards
    }
    
    private func addCardToBoad(card: Card) {
        // type and attack/not attack make the card appears at different place
        if card.cardType == .enchantment || card.cardType == .artifact {
            board.insert(card, at: 0)
        } else {
            board.append(card)
        }
        board = Card.regroupSameCardsInArray(board)
    }
    
    private func sendToGraveyard(card: Card) {
        if card.cardType != .token {
            graveyard.append(card)
        }
        if card.cardEffect.leaveTheBattlefield != nil {
            addToStack(card: card, stackType: .leaveTheBattlefield)
        }
    }
    
    private func castCard(card: Card) {
        if card.cardEffect.enterTheBattlefield != nil {
            for _ in 0..<card.cardCount {
                addToStack(card: card, stackType: .enterTheBattlefield)
            }
        }
        if card.cardType == .instant || card.cardType == .sorcery {
            sendToGraveyard(card: card)
        } else {
            addCardToBoad(card: card)
        }
    }
    
    func addToStack(card: Card, stackType: StackEffectType) {
        let arrayToCheck = stackType == .enterTheBattlefield ? card.cardEffect.enterTheBattlefield : card.cardEffect.leaveTheBattlefield

        if arrayToCheck?.contains(.applyWithoutShowing) ?? false {
            applyEffectFor(card: StackCard(card: card.recreateCard(), stackEffectType: stackType))
        } else {
            stack.append(StackCard(card: card.recreateCard(), stackEffectType: stackType))
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
    
    func tokenRowPressed(token: Card) {
        castCard(card: token.recreateCard())
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
        } else if !deck.deckEndgame.isEmpty {
            print("Draw from endgame as basic and midrange are empty")
            return deck.deckEndgame.removeFirst()
        }
        return nil
    }
    
    private func getMidrangeCardFromDeck() -> Card? {
        if !deck.deckMidrange.isEmpty {
            print("Draw from midrange")
            return deck.deckMidrange.removeFirst()
        } else if !deck.deckBasic.isEmpty {
            print("Draw from basic as midrange is empty")
            return deck.deckBasic.removeFirst()
        } else if !deck.deckEndgame.isEmpty {
            print("Draw from endgame as midrange and basic are empty")
            return deck.deckEndgame.removeFirst()
        }
        return nil
    }
    
    private func getEndgameCardFromDeck() -> Card? {
        if !deck.deckEndgame.isEmpty {
            print("Draw from endgame")
            return deck.deckEndgame.removeFirst()
        } else if !deck.deckMidrange.isEmpty {
            print("Draw from midrange as endgame is empty")
            return deck.deckMidrange.removeFirst()
        } else if !deck.deckBasic.isEmpty {
            print("Draw from basic as endgame and midrange are empty")
            return deck.deckBasic.removeFirst()
        }
        return nil
    }
    
    func resetModes(returnToHandModeEnable: Bool = false, onlyShowBlockers: Bool = false, onlyShowAttackers: Bool = false, addCountersModeEnable: Bool = false, removeCountersModeEnable: Bool = false) {
        self.returnToHandModeEnable = returnToHandModeEnable
        self.onlyShowBlockers = onlyShowBlockers
        self.onlyShowAttackers = onlyShowAttackers
        self.addCountersModeEnable = addCountersModeEnable
        self.removeCountersModeEnable = removeCountersModeEnable
    }
}

// MARK: Buttons
extension GameViewModel {
    
    // Starting step 1
    func newTurn() {
        manaCount += 1
        var cards: [Card] = []
        for _ in 0..<numberOfPlayer {
            // If all decks are empty, player won
            guard let card = drawCardFromRandomDeck() else { gameResult = 1; return }
            cards.append(card)
        }
        setUpCardsToCastWith(cardsFromLibrary: cards)
        withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
            showCardsToCastView = true
        }
        resetModes()
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
            castCard(card: card) // Should be casted from hand
        }
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + AnimationsDuration.average) {
            self.cardsToCast = CardsToCast(cardsFromLibrary: [], cardsFromHand: [], cardsFromGraveyard: [])
        //}
    }
    
    func drawCard() {
        let card = drawCardFromRandomDeck()
        if card != nil {
            withAnimation(.easeInOut(duration: AnimationsDuration.average)) {
                hand.append(card!)
            }
        } else {
            // All decks are empty, player won
            gameResult = 1
        }
        resetModes()
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
    
    func toggleOnlyShowAttackers() {
        onlyShowAttackers.toggle()
        resetModes(onlyShowAttackers: onlyShowAttackers)
    }
    
    func toggleOnlyShowBlockers() {
        onlyShowBlockers.toggle()
        resetModes(onlyShowBlockers: onlyShowBlockers)
    }
    
    func toggleReturnToHand() {
        returnToHandModeEnable.toggle()
        resetModes(returnToHandModeEnable: returnToHandModeEnable)
    }
    
    func toggleAddCounters() {
        addCountersModeEnable.toggle()
        resetModes(addCountersModeEnable: addCountersModeEnable)
    }
    
    func toggleRemoveCounters() {
        removeCountersModeEnable.toggle()
        resetModes(removeCountersModeEnable: removeCountersModeEnable)
    }
    
    func discardACardAtRandom() {
        if hand.count > 0 {
            let card = hand.remove(at: Int.random(in: 0..<hand.count))
            graveyard.append(card)
        }
    }
    
    func returnToHand(card: Card) {
        removeOneCardOnBoard(card: card)
        if card.cardType != .token {
            let tmpCard = card.recreateCard()
            tmpCard.cardCount = 1
            withAnimation(.easeInOut(duration: AnimationsDuration.average)) {
                hand.append(tmpCard)
            }
        } else {
            board = Card.regroupSameCardsInArray(board)
        }
    }
    
    func addCountersToCardOnBoard(card: Card) {
        if card.cardCount > 1 {
            let tmpCard = card.recreateCard()
            tmpCard.cardCount = card.cardCount - 1
            card.cardCount = 1
            card.countersOnCard += 1
            var cardIndexOnBoard = 0
            for i in 0..<board.count {
                if board[i] == card {
                    cardIndexOnBoard = i
                }
            }
            board.insert(tmpCard, at: cardIndexOnBoard + 1)
        } else {
            card.countersOnCard += 1
        }
        board = Card.regroupSameCardsInArray(board)
    }
    
    func removeCountersFromCardOnBoard(card: Card) {
        if card.countersOnCard > 0 {
            card.countersOnCard -= 1
        }
        board = Card.regroupSameCardsInArray(board)
    }
    
    func applyStackEffect() {
        withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
            let stackCard = stack.removeLast()
            applyEffectFor(card: stackCard)
        }
    }
    
    func cancelStackEffect() {
        withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
            stack.removeLast()
        }
    }
    
    
    
    
    func loseLife(life: Int) {
        lifePointsViewModel.opponentLife -= life
    }
    
    func gainLife(life: Int) {
        lifePointsViewModel.opponentLife += life
    }
    
    func addMana(mana: Int) {
        self.manaCount += mana
    }
    
    func loseMana(mana: Int) {
        self.manaCount -= mana
    }
    
    func discardHand() {
        for _ in 0..<hand.count {
            graveyard.append(hand.removeFirst())
        }
    }
    
    func drawXCards(x: Int) {
        for _ in 0..<x {
            drawCard()
        }
    }
}
