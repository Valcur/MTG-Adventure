//
//  CardEffects.swift
//  MTG Singleplayer
//
//  Created by Loic D on 09/08/2022.
//

import Foundation

class CardsEffects {
    static let cardsEffects_Kamigawa: [String: CardEffect] = [
        "Spirited Companion": CardEffect(enterTheBattlefield: .draw(1)),
        "Atsushi, the Blazing Sky": CardEffect(leaveTheBattlefield: .draw(2)),
        "Circuit Mender": CardEffect(enterTheBattlefield: .gainLife(2), leaveTheBattlefield: .draw(1)),
        "Sign in Blood": CardEffect(enterTheBattlefield: [.loseLife(2), .draw(2)]),
        "Counsel of the Soratami": CardEffect(enterTheBattlefield: .draw(2)),
        "Papercraft Decoy": CardEffect(leaveTheBattlefield: .draw(1)),
        "Sarulf's Packmate": CardEffect(enterTheBattlefield: .draw(1)),
        "Deliberate": CardEffect(enterTheBattlefield: .draw(1)),
        "Divination": CardEffect(enterTheBattlefield: .draw(2)),
        "Hedron Crawler": CardEffect(enterTheBattlefield: [.addMana(1), .applyWithoutShowing], leaveTheBattlefield: [.loseMana(1), .applyWithoutShowing]),
        "Enatu Golem": CardEffect(leaveTheBattlefield: .gainLife(4)),
        "Spore Crawler": CardEffect(leaveTheBattlefield: .draw(1)),
        "Ox of Agonas": CardEffect(enterTheBattlefield: [.discardHand, .draw(3)]),
        "Pressure Point": CardEffect(enterTheBattlefield: .draw(1)),
        "Runed Servitor": CardEffect(leaveTheBattlefield: .draw(1)),
        "Survival Cache": CardEffect(enterTheBattlefield: .gainLife(2)),
        "Farsight Adept": CardEffect(enterTheBattlefield: .draw(1)),
        "Kor Celebrant": CardEffect(enterTheBattlefield: .gainLife(1)),
        "Land Draw": CardEffect(enterTheBattlefield: [.draw(1), .applyWithoutShowing]),
    ]
}

class CardEffect {
    let enterTheBattlefield: [Effect]?
    let leaveTheBattlefield: [Effect]?
    
    private init(enter: [Effect]?, leave: [Effect]?) {
        self.enterTheBattlefield = enter
        self.leaveTheBattlefield = leave
    }
    
    // Ugly but it works
    convenience init(enterTheBattlefield: [Effect]?) {
        self.init(enter: enterTheBattlefield, leave: nil)
    }
    
    convenience init(leaveTheBattlefield: [Effect]?) {
        self.init(enter: nil, leave: leaveTheBattlefield)
    }
    
    convenience init(enterTheBattlefield: Effect?) {
        self.init(enter: enterTheBattlefield != nil ? [enterTheBattlefield!] : nil, leave: nil)
    }
    
    convenience init(leaveTheBattlefield: Effect?) {
        self.init(enter: nil, leave: leaveTheBattlefield != nil ? [leaveTheBattlefield!] : nil)
    }
    
    convenience init(enterTheBattlefield: Effect?, leaveTheBattlefield: [Effect]?) {
        self.init(enter: enterTheBattlefield != nil ? [enterTheBattlefield!] : nil, leave: leaveTheBattlefield)
    }
    
    convenience init(enterTheBattlefield: [Effect]?, leaveTheBattlefield: Effect?) {
        self.init(enter: enterTheBattlefield, leave: leaveTheBattlefield != nil ? [leaveTheBattlefield!] : nil)
    }
    
    convenience init(enterTheBattlefield: Effect? = nil, leaveTheBattlefield: Effect? = nil) {
        self.init(enter: enterTheBattlefield != nil ? [enterTheBattlefield!] : nil, leave: leaveTheBattlefield != nil ? [leaveTheBattlefield!] : nil)
    }
    
    convenience init(enterTheBattlefield: [Effect]?, leaveTheBattlefield: [Effect]?) {
        self.init(enter: enterTheBattlefield, leave: leaveTheBattlefield)
    }
    
    convenience init() {
        self.init(enter: nil, leave: nil)
    }
}

enum Effect: Equatable {
    case draw(Int)
    case gainLife(Int)
    case loseLife(Int)
    case addMana(Int)
    case loseMana(Int)
    case discardHand
    case applyWithoutShowing
}

extension GameViewModel {
    private func applyEffect(effect: Effect) {
        switch effect {
        case .draw(let cardsToDraw):
            self.drawXCards(x: cardsToDraw)
        case .gainLife(let lifeToGain):
            self.gainLife(life: lifeToGain)
        case .loseLife(let lifeToLose):
            self.loseLife(life: lifeToLose)
        case .addMana(let manaGained):
            self.addMana(mana: manaGained)
        case .loseMana(let manaLost):
            self.loseMana(mana: manaLost)
        case .discardHand:
            self.discardHand()
        case .applyWithoutShowing:
            print("Not showing this one")
        }
    }
    
    func applyEffectFor(card: StackCard) {
        guard let effects = card.stackEffectType == .enterTheBattlefield ? card.card.cardEffect.enterTheBattlefield : card.card.cardEffect.leaveTheBattlefield else { return }
        for effect in effects {
            applyEffect(effect: effect)
        }
    }
}
