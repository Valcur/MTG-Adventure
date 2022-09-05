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
    var currentEncounterChoiceType: String?
    
    @Published var currentGold: Int = 10
    @Published var currentLife: Int = 3
    var permanentBonusList: [String] = ["Kamigawa_Forge", "Kamigawa_Forge"]
    
    var availableRandomEncounter: [String] = []
    var fightCompleted: Int = 0
    var fightCompletedSinceBeginning: Int = 0
    var shopVisited: Bool = false
    var currentPlane: String = "Zendikar"
    var possiblePlanes: [String] = ["Zendikar", "Kamigawa"]
    var stage = 0
    var difficulty = 0
    var numberOfPlayer = 1
    var gameStyle: GameStyle = .edh
    var saveNumber = 1
    var currentEncounterId: String = ""
    
    init() {
        let startEncounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)["\(currentPlane)_Intro"]!
        //let startEncounter = Encounters.getArrayForPlane(currentPlane, array: .directEncounter)["Kamigawa_Forge_04"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
        //setFinalBossEncounter()
    }
    
    func loadSave(saveNumber: Int) {
        let saveInfo = SaveManager.getSaveInfoFor(saveNumber: saveNumber)
        self.fightCompleted = saveInfo.fightCompleted
        self.shopVisited = saveInfo.shopHasBeenVisited
        self.difficulty = saveInfo.difficulty
        self.stage = saveInfo.currentStage                        // CHANGE LATER
        self.permanentBonusList = saveInfo.permanentUpgradeArray
        self.currentGold = saveInfo.gold
        self.currentLife = saveInfo.life
        self.numberOfPlayer = saveInfo.numberOfPlayer
        self.gameStyle = saveInfo.gameStyle
        self.saveNumber = saveNumber
        self.availableRandomEncounter = saveInfo.availableRandomEncounter
        self.fightCompletedSinceBeginning = saveInfo.fightCompletedSinceBeginning
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
            case 3:             // We defeated the boss
                setVictoryEncounter()
            default:            // Next plane
                setIntroEncounter(planeName: possiblePlanes[stage - 1])
            }
        }
        // If player have to fight a deck before going to the specified encounter
        else if choice.deckToFight != nil {
            currentEncounterView = AnyView(GameView().environmentObject(GameViewModel(deckName: choice.deckToFight!, stage: stage + difficulty, numberOfPlayer: numberOfPlayer)))
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
        currentEncounterChoiceType = choice.deckToFight == nil ? encounterChoice : "Classic"
        switchView()
    }
    
    private func setIntroEncounter(planeName: String) {
        currentPlane = planeName
        shopVisited = stage == 1
        fightCompleted = 0
        setupAvailableRandomEncountersWith(plane: planeName)
        let startEncounter = Encounters.getArrayForPlane(planeName, array: .directEncounter)["\(currentPlane)_Intro"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
        currentEncounterId = startEncounter.id
        saveProgress()
    }
    
    private func setFinalShopEncounter() {
        currentPlane = "Final Boss"
        shopVisited = true
        setupAvailableRandomEncountersWith(plane: currentPlane)
        let bossShop = Encounters.bosses_shop
        currentEncounterView = AnyView(EncounterView(encounter: bossShop))
        currentEncounterId = bossShop.id
        saveProgress()
    }
    
    private func setFinalBossEncounter() {
        let bossEncounter = availableRandomEncounter.removeLast()
        currentEncounterView = AnyView(EncounterView(encounter: Encounters.getEncounter(encounterId: bossEncounter, planeName: currentPlane)!))
        currentEncounterId = bossEncounter
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
            let randomEncounter = availableRandomEncounter.removeLast()
            encounter = Encounters.getEncounter(encounterId: randomEncounter, planeName: currentPlane)!
        } else {
            // A single or a double
            if Bool.random() {
                let randomEncounter = availableRandomEncounter.removeLast()
                encounter = Encounters.getEncounter(encounterId: randomEncounter, planeName: currentPlane)!
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
    
    private func setupAvailableRandomEncountersWith(plane: String) {
        availableRandomEncounter = []
        let possibleRandomEncounters = Encounters.getArrayForPlane(plane, array: .singleEncounter)
        for enc in possibleRandomEncounters {
            availableRandomEncounter.append(enc.key)
        }
        availableRandomEncounter.shuffle()
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
                                currentStage: stage,
                                difficulty: difficulty,
                                gameStyle: gameStyle,
                                availableRandomEncounter: availableRandomEncounter,
                                fightCompletedSinceBeginning: fightCompletedSinceBeginning)
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
        fightCompleted += 1
        fightCompletedSinceBeginning += 1
        if currentEncounterChoice!.encounterId.first! == EncounterChoice.victory {
            setVictoryEncounter()
            self.saveProgress()
            switchView()
        } else {
            let choice = EncounterChoice(title: currentEncounterChoice!.title, encounterId: currentEncounterChoice!.encounterId)
            applyChoice(choice: choice)
            DispatchQueue.main.asyncAfter(deadline: .now() + AnimationsDuration.short) {
                self.currentGold += 10
                self.saveProgress()
            }
        }
    }
    
    func fightLost() {
        self.currentLife -= 1
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
