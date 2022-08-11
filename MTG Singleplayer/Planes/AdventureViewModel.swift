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
    var fightCompleted: Int = 0
    var shopVisited: Bool = false
    var currentPlane = "Kamigawa"
    
    init() {
        availableRandomEncounter = Encounters.plane_kamigawa
        
        let startEncounter = Encounters.plane_kamigawa_direct["\(currentPlane)_Intro"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
    }
    
    private func applyChoice(choice: EncounterChoice) {
        // If plane is completed, siwtch to the next plane
        if fightCompleted >= 5 {
            
        }
        // If player have to fight a deck before going to the specified encounter
        else if choice.deckToFight != nil {
            currentEncounterView = AnyView(GameView().environmentObject(GameViewModel(deckName: choice.deckToFight!, stage: 1)))
            fightCompleted += 1
            print("Starting fight \(fightCompleted)")
        }
        // Else if we have to go to a random encounter not already played
        else if choice.encounterId.contains(EncounterChoice.randomEncounter) {
            let nextEncounter = getRandomEncounter()
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter))
            giveRewards(rewards: nextEncounter.reward, withDelay: true)
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
    
    private func getRandomEncounter() -> Encounter {
        var encounter: Encounter
        if fightCompleted >= 3 && shopVisited {
            // Ending
            encounter = Encounters.plane_kamigawa_ending.randomElement()!.value
        } else if fightCompleted >= 3 && !shopVisited {
            // Shop only
            encounter = Encounters.plane_kamigawa_direct["\(currentPlane)_Shop"]!
            shopVisited = true
        } else if fightCompleted == 1 {
            // Double only
            encounter = Encounters.plane_kamigawa_double.randomElement()!.value
        } else if fightCompleted == 2 {
            // Single only
            let randomEncounter = availableRandomEncounter.randomElement()
            availableRandomEncounter.removeValue(forKey: randomEncounter!.key)
            encounter = randomEncounter!.value
        }else {
            // A single or a double
            if Bool.random() {
                let randomEncounter = availableRandomEncounter.randomElement()
                availableRandomEncounter.removeValue(forKey: randomEncounter!.key)
                encounter = randomEncounter!.value
            } else {
                encounter = Encounters.plane_kamigawa_double.randomElement()!.value
            }
        }
        return encounter
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
                    self.giveReward(reward: reward)
                }
            }
        }
    }
    
    func buyOffer(offer: Offer) {
        // Pay the offer
        switch offer {
        case .gold(let value, _, _):
            currentGold -= value
        case .life(let value, _, _):
            currentLife -= value
        }
        giveReward(reward: offer.reward())
    }
    
    private func giveReward(reward: Reward) {
        switch reward {
        case .gold(let value):
            currentGold += value
        case .life(let value):
            currentLife += value
        case .booster:
            print("OK")
        case .partner:
            print("OK")
        }
    }
    
    func canPlayerBuyOffer(offer: Offer) -> Bool {
        switch offer {
        case .gold(let value, _, _):
            return currentGold >= value
        case .life(let value, _, _):
            return currentLife >= value
        }
    }
    
    func playerCanAffordOffer(offer: Offer) -> Bool {
        return true
    }
}
