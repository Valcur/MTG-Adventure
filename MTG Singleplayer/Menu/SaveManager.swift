//
//  SaveManager.swift
//  MTG Singleplayer
//
//  Created by Loic D on 19/08/2022.
//

import Foundation

class SaveManager {
    
    static func getSaveInfoFor(saveNumber: Int) -> SaveInfo {
        let userDefault = UserDefaults.standard
        let numberOfPlayer: Int = userDefault.integer(forKey: "Save_\(saveNumber)_NumberOfPlayer")
        let currentEncounter: String = userDefault.string(forKey: "Save_\(saveNumber)_CurrentEncounter") ?? "Unset"
        let currentPlane: String = userDefault.string(forKey: "Save_\(saveNumber)_CurrentPlane") ?? "Unset"
        let gold: Int = userDefault.integer(forKey: "Save_\(saveNumber)_Gold")
        let life: Int = userDefault.integer(forKey: "Save_\(saveNumber)_Life")
        let fightCompleted: Int = userDefault.integer(forKey: "Save_\(saveNumber)_FightCompleted")
        let shopHasBeenVisited: Bool = userDefault.bool(forKey: "Save_\(saveNumber)_ShopHasBeenVisited")
        let permanentUpgradeArray: [String] = userDefault.stringArray(forKey: "Save_\(saveNumber)_PermanentUpgradeArray") ?? []
        let currentStage: Int = userDefault.integer(forKey: "Save_\(saveNumber)_CurrentStage")
        let difficulty: Int = userDefault.integer(forKey: "Save_\(saveNumber)_Difficulty")
        let gameStyle: Int = userDefault.integer(forKey: "Save_\(saveNumber)_GameStyle")
        let availableRandomEncounter: [String] = userDefault.stringArray(forKey: "Save_\(saveNumber)_AvailableRandomEncounter") ?? []
        let fightCompletedSinceBeginning: Int = userDefault.integer(forKey: "Save_\(saveNumber)_FightCompletedSinceBeginning")
        return SaveInfo(numberOfPlayer: numberOfPlayer, currentEncounter: currentEncounter, currentPlane: currentPlane, gold: gold, life: life, fightCompleted: fightCompleted, shopHasBeenVisited: shopHasBeenVisited, permanentUpgradeArray: permanentUpgradeArray, currentStage: currentStage, difficulty: difficulty, gameStyle: gameStyle == 0 ? .edh : .classic, availableRandomEncounter: availableRandomEncounter, fightCompletedSinceBeginning: fightCompletedSinceBeginning)
    }
    
    static func setSaveInfoFor(saveInfo: SaveInfo, saveNumber: Int) {
        let userDefault = UserDefaults.standard
        userDefault.set(saveInfo.numberOfPlayer, forKey: "Save_\(saveNumber)_NumberOfPlayer")
        userDefault.set(saveInfo.currentEncounter, forKey: "Save_\(saveNumber)_CurrentEncounter")
        userDefault.set(saveInfo.currentPlane, forKey: "Save_\(saveNumber)_CurrentPlane")
        userDefault.set(saveInfo.gold, forKey: "Save_\(saveNumber)_Gold")
        userDefault.set(saveInfo.life, forKey: "Save_\(saveNumber)_Life")
        userDefault.set(saveInfo.fightCompleted, forKey: "Save_\(saveNumber)_FightCompleted")
        userDefault.set(saveInfo.shopHasBeenVisited, forKey: "Save_\(saveNumber)_ShopHasBeenVisited")
        userDefault.set(saveInfo.permanentUpgradeArray, forKey: "Save_\(saveNumber)_PermanentUpgradeArray")
        userDefault.set(saveInfo.currentStage, forKey: "Save_\(saveNumber)_CurrentStage")
        userDefault.set(saveInfo.difficulty, forKey: "Save_\(saveNumber)_Difficulty")
        userDefault.set(saveInfo.gameStyle == .edh ? 0 : 1, forKey: "Save_\(saveNumber)_GameStyle")
        userDefault.set(saveInfo.availableRandomEncounter, forKey: "Save_\(saveNumber)_AvailableRandomEncounter")
        userDefault.set(saveInfo.fightCompletedSinceBeginning, forKey: "Save_\(saveNumber)_FightCompletedSinceBeginning")
        print("Saving with \(saveInfo.currentEncounter)")
        print("Game Saved on slot \(saveNumber)")
    }
    
    static func deleteSaveInfoFor(saveNumber: Int) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: "Save_\(saveNumber)_NumberOfPlayer")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_CurrentEncounter")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_CurrentPlane")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_Gold")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_Life")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_FightCompleted")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_ShopHasBeenVisited")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_PermanentUpgradeArray")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_CurrentStage")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_Difficulty")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_GameStyle")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_AvailableRandomEncounter")
        userDefault.removeObject(forKey: "Save_\(saveNumber)_FightCompletedSinceBeginning")
    }
}

struct SaveInfo {
    let numberOfPlayer: Int
    let currentEncounter: String
    let currentPlane: String
    let gold: Int
    let life: Int
    let fightCompleted: Int
    let shopHasBeenVisited: Bool
    let permanentUpgradeArray: [String]
    let currentStage: Int
    let difficulty: Int
    let gameStyle: GameStyle
    let availableRandomEncounter: [String]
    let fightCompletedSinceBeginning: Int
}
