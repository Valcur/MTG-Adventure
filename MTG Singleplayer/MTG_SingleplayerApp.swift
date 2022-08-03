//
//  MTG_SingleplayerApp.swift
//  MTG Singleplayer
//
//  Created by Loic D on 31/07/2022.
//

import SwiftUI

@main
struct MTG_SingleplayerApp: App {
    var body: some Scene {
        WindowGroup {
            //GameView()
                //.environmentObject(GameViewModel(stage: 1, deckId: 1))
            AdventureView()
                .environmentObject(AdventureViewModel())
            //EncounterView(encounter: Encounters.plane_kamigawa["Kamigawa_Intro"]!)
        }
    }
}
