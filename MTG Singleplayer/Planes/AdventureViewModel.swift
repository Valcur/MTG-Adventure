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
    
    init() {
        let startEncounter = Encounters.plane_kamigawa["Kamigawa_Intro"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))
    }
}

// MARK: Buttons
extension AdventureViewModel {
    func choiceButtonPressed(choice: EncounterChoice) {
        // If player have to fight a deck
        if choice.encounterId.contains(EncounterChoice.deckEncounter) {
            
        }
        // Else if we have to go to a random encounter
        else if choice.encounterId.contains(EncounterChoice.randomEncounter) {
            
        }
        // Else we go to the specified encounter
        else {
            
        }
        /*let startEncounter = Encounters.plane_kamigawa["Kamigawa_Intro"]!
        currentEncounterView = AnyView(EncounterView(encounter: startEncounter))*/
        switchView()
        currentEncounterView = AnyView(GameView().environmentObject(GameViewModel(stage: 1, deckId: 1)))
    }
    
    /*private*/ func switchView() {
        withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
            shouldAnimateTransitionNow = true
        }
    }
}
