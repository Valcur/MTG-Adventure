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
    
    init() {
        let startEncounter = Encounters.plane_kamigawa["Kamigawa_Intro"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
    }
    
    private func applyChoice(choice: EncounterChoice) {
        // If player have to fight a deck befroe going to the specified encounter
        if choice.deckToFight != nil {
            currentEncounterView = AnyView(GameView().environmentObject(GameViewModel(deckName: choice.deckToFight!, stage: 1)))
        }
        // Else if we have to go to a random encounter
        else if choice.encounterId.contains(EncounterChoice.randomEncounter) {
            let nextEncounter = Encounters.plane_kamigawa.randomElement()
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter!.value))
        }
        // Else we go to the specified encounter
        else {
            let nextEncounter = Encounters.plane_kamigawa_direct[choice.encounterId]
            currentEncounterView = AnyView(EncounterView(encounter: nextEncounter!))
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
}
