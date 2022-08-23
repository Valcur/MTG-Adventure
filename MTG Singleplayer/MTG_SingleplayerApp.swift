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
            /*
            GameView()
                .environmentObject(GameViewModel(deckName: "Kamigawa_Forge_01", stage: 1, numberOfPlayer: 1))
                .environmentObject(AdventureViewModel())
             */
            /*
            AdventureView()
                .environmentObject(AdventureViewModel())
                .statusBar(hidden: true)
            */
            
            Main()
                .environmentObject(AdventureViewModel())
                .environmentObject(MainMenuViewModel())
                .statusBar(hidden: true)
            
            
            //EncounterView(encounter: Encounters.plane_kamigawa["Kamigawa_Intro"]!)
        }
    }
}

struct Main: View {
    @EnvironmentObject var mainMenuViewModel: MainMenuViewModel
    @EnvironmentObject var adventureViewModel: AdventureViewModel
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
                if mainMenuViewModel.hideMenu == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + AnimationsDuration.long) {
                        withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                            showAdventureView = true
                        }
                    }
                }
            }
            .onChange(of: adventureViewModel.currentLife) { currentLife in
                if currentLife == -1 {
                    withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                        showAdventureView = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + AnimationsDuration.long) {
                        withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                            mainMenuViewModel.hideMenu = false
                        }
                    }
                }
            }
    }
}
