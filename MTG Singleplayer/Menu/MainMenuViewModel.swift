//
//  MainMenuViewModel.swift
//  MTG Singleplayer
//
//  Created by Loic D on 19/08/2022.
//

import Foundation

class MainMenuViewModel: ObservableObject {
    @Published var menuProgress = 1
    @Published var saveSelected = 1
    @Published var hideMenu = false
    
    func createNewSave(numberOfPlayer: Int, gameStyle: GameStyle, difficulty: Int) {
        let saveInfo = SaveInfo(numberOfPlayer: numberOfPlayer,
                                currentEncounter: "Unset",
                                currentPlane: "Unset",
                                gold: 10,
                                life: 3,
                                fightCompleted: 0,
                                shopHasBeenVisited: false,
                                permanentUpgradeArray: [],
                                difficulty: difficulty,
                                gameStyle: gameStyle,
                                availableRandomEncounter: [])
        SaveManager.setSaveInfoFor(saveInfo: saveInfo, saveNumber: saveSelected)
    }
}

