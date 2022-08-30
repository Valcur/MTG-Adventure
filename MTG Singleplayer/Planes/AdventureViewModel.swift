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
    var currentPlane: String = "Zendikar"
    var possiblePlanes: [String] = ["Zendikar", "Kamigawa"]
    var stage = 0
    var numberOfPlayer = 1
    var gameStyle: GameStyle = .edh
    var saveNumber = 1
    var currentEncounterId: String = ""
    
    init() {
        availableRandomEncounter = Encounters.getArrayForPlane(currentPlane, array: .singleEncounter)
        let startEncounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)["\(currentPlane)_Intro"]!
        //let startEncounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)["Kamigawa_Forge_04"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
        //setFinalBossEncounter()
    }
    
    func loadSave(saveNumber: Int) {
        let saveInfo = SaveManager.getSaveInfoFor(saveNumber: saveNumber)
        self.fightCompleted = saveInfo.fightCompleted
        self.shopVisited = saveInfo.shopHasBeenVisited
        self.stage = saveInfo.difficulty - 2                        // CHANGE LATER
        self.permanentBonusList = saveInfo.permanentUpgradeArray
        self.currentGold = saveInfo.gold
        self.currentLife = saveInfo.life
        self.numberOfPlayer = saveInfo.numberOfPlayer
        self.gameStyle = saveInfo.gameStyle
        self.saveNumber = saveNumber
        if saveInfo.currentEncounter == "Unset" {
            let startEncounter = Encounters.introEncounter
            //let startEncounter = Encounters.victoryEncounter
            currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
            self.currentPlane = "Zendikar"
            switchView()
            currentEncounterId = startEncounter.id
            saveProgress()
        } else {
            self.currentPlane = saveInfo.currentPlane
            let startEncounter = Encounters.getEncounter(encounterId: saveInfo.currentEncounter, planeName: saveInfo.currentPlane)
            currentEncounterView = AnyView(EncounterView(encounter: startEncounter!))
            giveRewards(rewards: startEncounter!.reward, withDelay: true)
            currentEncounterId = startEncounter!.id
            switchView()
        }
    }
    
    private func applyChoice(choice: EncounterChoice) {
        let encounterChoice = choice.encounterId.randomElement()
        if encounterChoice == EncounterChoice.returnToMenu {
            currentLife = -1
            //SaveManager.deleteSaveInfoFor(saveNumber: saveNumber)
            return
        }
        
        // If plane is completed, siwtch to the next plane
        if encounterChoice == EncounterChoice.planeEnd {
            stage += 1
            
            switch(stage) {
            case 2:             // Final shop before the boss
                setFinalShopEncounter()
            case 3:             // We reach the boss
                setFinalBossEncounter()
            default:            // Next plane
                setIntroEncounter(planeName: possiblePlanes[stage + 1])
            }
        }
        // If player have to fight a deck before going to the specified encounter
        else if choice.deckToFight != nil {
            currentEncounterView = AnyView(GameView().environmentObject(GameViewModel(deckName: choice.deckToFight!, stage: stage, numberOfPlayer: numberOfPlayer)))
        }
        else if encounterChoice == EncounterChoice.planeEnd {
            setVictoryEncounter()
        }
        // Else if we have to go to a random encounter not already played
        else if encounterChoice == EncounterChoice.randomEncounter {
            let nextEncounter = getRandomEncounter()
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter))
            giveRewards(rewards: nextEncounter.reward, withDelay: true)
            currentEncounterId = nextEncounter.id
            saveProgress()
        }
        // Else we go to the specified encounter
        else {
            let nextEncounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)[encounterChoice!]
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter!))
            giveRewards(rewards: nextEncounter!.reward, withDelay: true)
            currentEncounterId = nextEncounter!.id
            saveProgress()
        }

        currentEncounterChoice = choice
        switchView()
    }
    
    private func setIntroEncounter(planeName: String) {
        currentPlane = planeName
        shopVisited = stage == 0
        stage += 1
        availableRandomEncounter = Encounters.getArrayForPlane(planeName, array: .singleEncounter)
        let startEncounter = Encounters.getArrayForPlane(planeName, array: .directEncounter)["\(currentPlane)_Intro"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
        currentEncounterId = startEncounter.id
        saveProgress()
    }
    
    private func setFinalShopEncounter() {
        currentPlane = "Final Shop"
        let bossShop = Encounters.bosses_shop
        currentEncounterView = AnyView(EncounterView(encounter: bossShop))
        currentEncounterId = bossShop.id
        saveProgress()
    }
    
    private func setFinalBossEncounter() {
        currentPlane = "Final Boss"
        let bossEncounter = Encounters.bosses["Boss_Garruk"]!
        currentEncounterView = AnyView(EncounterView(encounter: bossEncounter))
        currentEncounterId = bossEncounter.id
        stage -= 1  // UGLY, DO IT WITH RANDOM ENCOUNTER WHEN OTHER BOSSES ARE ADDED
        saveProgress()
    }
    
    private func setVictoryEncounter() {
        currentPlane = "Victory"
        let victoryEncounter = Encounters.victoryEncounter
        currentEncounterView = AnyView(EncounterView(encounter: victoryEncounter))
        SaveManager.deleteSaveInfoFor(saveNumber: saveNumber)
    }
    
    private func setDefeatEncounter() {
        currentPlane = "Defeat"
        let defeatEncounter = Encounters.defeatEncounter
        currentEncounterView = AnyView(EncounterView(encounter: defeatEncounter))
        SaveManager.deleteSaveInfoFor(saveNumber: saveNumber)
    }

    private func getRandomEncounter() -> Encounter {
        var encounter: Encounter
        if !shopVisited {
            encounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)["\(currentPlane)_Shop"]!
            shopVisited = true
        } else if fightCompleted >= 3 {
            // Ending
            encounter = Encounters.getArrayForPlane(currentPlane, array: .endingEncounter).randomElement()!.value
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
    
    private func saveProgress() {
        let saveInfo = SaveInfo(numberOfPlayer: numberOfPlayer,
                                currentEncounter: currentEncounterId,
                                currentPlane: currentPlane,
                                gold: currentGold,
                                life: currentLife,
                                fightCompleted: fightCompleted,
                                shopHasBeenVisited: shopVisited,
                                permanentUpgradeArray: permanentBonusList,
                                difficulty: stage,
                                gameStyle: gameStyle)
        SaveManager.setSaveInfoFor(saveInfo: saveInfo, saveNumber: saveNumber)
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
            self.saveProgress()
        }
    }
    
    func fightLost() {
        currentLife -= 1
        if currentLife == 0 {
            setDefeatEncounter()
            switchView()
        }
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
