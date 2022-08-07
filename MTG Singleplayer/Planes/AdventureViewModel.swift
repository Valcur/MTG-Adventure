//
//  AdventureViewModel.swift
//  MTG Singleplayer
//
//  Created by Loic D on 02/08/2022.
//

import Foundation
import SwiftUI

class AdventureViewModel: ObservableObject {
    
    @Published var currentEncounterView: AnyView
    @Published var shouldAnimateTransitionNow: Bool = false
    private var currentEncounterChoice: EncounterChoice?
    
    @Published var currentGold: Int = 10
    @Published var currentLife: Int = 3
    
    var availableRandomEncounter: [String:Encounter]
    
    init() {
        availableRandomEncounter = Encounters.plane_kamigawa
        
        let startEncounter = Encounters.plane_kamigawa["Kamigawa_Intro"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
        availableRandomEncounter.removeValue(forKey: "Kamigawa_Intro")
    }
    
    private func applyChoice(choice: EncounterChoice) {
        // If player have to fight a deck befroe going to the specified encounter
        if choice.deckToFight != nil {
            currentEncounterView = AnyView(GameView().environmentObject(GameViewModel(deckName: choice.deckToFight!, stage: 1)))
        }
        // Else if we have to go to a random encounter not already played
        else if choice.encounterId.contains(EncounterChoice.randomEncounter) {
            let nextEncounter = availableRandomEncounter.randomElement()
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter!.value))
            giveRewards(rewards: nextEncounter!.value.reward, withDelay: true)
            
            availableRandomEncounter.removeValue(forKey: nextEncounter!.key)
        }
        // Else we go to the specified encounter
        else {
            let nextEncounter = Encounters.plane_kamigawa_direct[choice.encounterId.randomElement()!]
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter!))
            giveRewards(rewards: nextEncounter!.reward, withDelay: true)
        }

        currentEncounterChoice = choice
        switchView()
        
    }

    private func switchView() {
        withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
            shouldAnimateTransitionNow = true
        }
    }
}

// MARK: Buttons
extension AdventureViewModel {
    // RENAME PLEASE
    func choiceButtonPressed(choice: EncounterChoice) {
        applyChoice(choice: choice)
    }
    
    func fightWon() {
        let choice = EncounterChoice(title: currentEncounterChoice!.title, encounterId: currentEncounterChoice!.encounterId)
        applyChoice(choice: choice)
    }
    
    func giveRewards(rewards: [Reward]?, withDelay: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + (withDelay ? AnimationsDuration.long : 0)) {
            if let rewards = rewards {
                for reward in rewards {
                    if let goldReward = reward as? RewardGold {
                        self.currentGold += goldReward.value
                    } else if let lifeReward = reward as? RewardLife {
                        self.currentLife += lifeReward.value
                    }
                }
            }
        }
    }
    
    func buyOffer(offer: Offer) {
        // Pay the offer
        if let goldCost = offer.cost as? CostGold {
            currentGold -= goldCost.value
        } else if let lifeCost = offer.cost as? CostLife {
            currentLife -= lifeCost.value
        }
        currentLife += 1
        giveRewards(rewards: [offer])
    }
    
    func canPlayerBuyOffer(offer: Offer) -> Bool {
        if let goldCost = offer.cost as? CostGold {
            return currentGold >= goldCost.value
        } else if let lifeCost = offer.cost as? CostLife {
            return currentLife >= lifeCost.value
        }
        return true
    }
    
    func playerCanAffordOffer(offer: Offer) -> Bool {
        return true
    }
}
