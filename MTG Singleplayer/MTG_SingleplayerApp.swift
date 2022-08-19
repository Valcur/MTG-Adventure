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
            
            Main()
                .environmentObject(AdventureViewModel())
                .environmentObject(MainMenuViewModel())
            
            //EncounterView(encounter: Encounters.plane_kamigawa["Kamigawa_Intro"]!)
        }
    }
}

struct Main: View {
    @EnvironmentObject var mainMenuViewModel: MainMenuViewModel
    @State var showAdventureView = false
    var body: some View {
        ZStack {
            Color.black
            AdventureView()
                .opacity(showAdventureView ? 1 : 0)
                .scaleEffect(showAdventureView ? 1 : 1.5)
            MainMenuView()
        }.ignoresSafeArea()
            .onChange(of: mainMenuViewModel.hideMenu) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + AnimationsDuration.long) {
                    withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                        showAdventureView = true
                    }
                }
            }
    }
}
