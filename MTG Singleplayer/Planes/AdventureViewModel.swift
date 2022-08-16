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
    var permanentBonusList: [String] = ["Kamigawa_Forge", "Kamigawa_Forge"]
    
    var availableRandomEncounter: [String:Encounter]
    var fightCompleted: Int = 0
    var shopVisited: Bool = false
    var currentPlane = "Zendikar"
    var stage = 0
    
    init() {
        
        availableRandomEncounter = Encounters.getArrayForPlane(currentPlane, array: .singleEncounter)
        let startEncounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)["\(currentPlane)_Intro"]!
        //let startEncounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)["Kamigawa_Forge_04"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
        //setFinalBossEncounter()
    }
    
    private func applyChoice(choice: EncounterChoice) {
        let encounterChoice = choice.encounterId.randomElement()
        
        // If plane is completed, siwtch to the next plane
        if encounterChoice == EncounterChoice.planeEnd {
            stage += 1
            
            switch(stage) {
            case 1:             // Final shop before the boss
                setFinalShopEncounter()
            case 2:             // We reach the boss
                setFinalBossEncounter()
            default:            // Next plane
                setIntroEncounter(planeName: "Kamigawa")
            }
        }
        // If player have to fight a deck before going to the specified encounter
        else if choice.deckToFight != nil {
            currentEncounterView = AnyView(GameView().environmentObject(GameViewModel(deckName: choice.deckToFight!, stage: stage)))
        }
        // Else if we have to go to a random encounter not already played
        else if encounterChoice == EncounterChoice.randomEncounter {
            let nextEncounter = getRandomEncounter()
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter))
            giveRewards(rewards: nextEncounter.reward, withDelay: true)
        }
        // Else we go to the specified encounter
        else {
            let nextEncounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)[encounterChoice!]
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter!))
            giveRewards(rewards: nextEncounter!.reward, withDelay: true)
        }

        currentEncounterChoice = choice
        switchView()
    }
    
    private func setIntroEncounter(planeName: String) {
        currentPlane = planeName
        availableRandomEncounter = Encounters.getArrayForPlane(planeName, array: .singleEncounter)
        let startEncounter = Encounters.getArrayForPlane(planeName, array: .directEncounter)["\(currentPlane)_Intro"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
    }
    
    private func setFinalShopEncounter() {
        currentPlane = "Final Shop"
        let bossShop = Encounters.bosses_shop
        currentEncounterView = AnyView(EncounterView(encounter: bossShop))
    }
    
    private func setFinalBossEncounter() {
        currentPlane = "Final Boss"
        let bossEncounter = Encounters.bosses["Boss_Garruk"]!
        currentEncounterView = AnyView(EncounterView(encounter: bossEncounter))
    }
    
    private func getRandomEncounter() -> Encounter {
        var encounter: Encounter
        if fightCompleted >= 3 && shopVisited {
            // Ending
            encounter = Encounters.getArrayForPlane(currentPlane, array: .endingEncounter).randomElement()!.value
        } else if fightCompleted >= 3 && !shopVisited {
            // Shop only
            encounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)["\(currentPlane)_Shop"]!
            shopVisited = true
        } else if fightCompleted == 1 {
            // Double only
            encounter = Encounters.getArrayForPlane(currentPlane, array: .doubleEncounter).randomElement()!.value
        } else if fightCompleted == 2 {
            // Single only
            let randomEncounter = availableRandomEncounter.randomElement()
            availableRandomEncounter.removeValue(forKey: randomEncounter!.key)
            encounter = randomEncounter!.value
        } else {
            // A single or a double
            if Bool.random() {
                let randomEncounter = availableRandomEncounter.randomElement()
                availableRandomEncounter.removeValue(forKey: randomEncounter!.key)
                encounter = randomEncounter!.value
            } else {
                encounter = Encounters.getArrayForPlane(currentPlane, array: .doubleEncounter).randomElement()!.value
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
        fightCompleted += 1
        applyChoice(choice: choice)
        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationsDuration.short) {
            self.currentGold += 10
        }
    }
    
    func fightLost() {
        currentLife -= 1
        //currentEncounterView = AnyView(GameViewParent(gameViewModel: GameViewModel(deckName: "Kamigawa_Invader_02", stage: stage)))
        //switchView()
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
        case .permanentBonus(let bonusName):
            permanentBonusList.append(bonusName)
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
