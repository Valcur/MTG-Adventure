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
        "Papercraft Decoy": CardEffect(enterTheBattlefield: .draw(1)),
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
        }
    }
    
    func applyEnterTheBattlefieldEffectFor(card: Card) {
        guard let effects = card.cardEffect.enterTheBattlefield else { return }
        for effect in effects {
            applyEffect(effect: effect)
        }
    }
    
    func applyLeaveTheBattlefieldEffectFor(card: Card) {
        guard let effects = card.cardEffect.leaveTheBattlefield else { return }
        for effect in effects {
            applyEffect(effect: effect)
        }
    }
}
