//
//  AdventureView.swift
//  MTG Singleplayer
//
//  Created by Loic D on 02/08/2022.
//

import SwiftUI

struct AdventureView: View {
    
    @EnvironmentObject var adventureViewModel: AdventureViewModel
    @State var currentEncounterView: AnyView?
    @State var oldEncounterView: AnyView?
    @State var animationProgress: CGFloat = 0
    
    var body: some View {
        ZStack {
            
            if currentEncounterView != nil {
                currentEncounterView
                    .environmentObject(adventureViewModel)
                    //.opacity(animationProgress == 0 ? 1 : animationProgress)
            }
            
            if oldEncounterView != nil {
                Color.black
                    .opacity(1 - animationProgress)
                oldEncounterView
                    .environmentObject(adventureViewModel)
                    .ignoresSafeArea()
                    .offset(x: animationProgress *  -UIScreen.main.bounds.width * 1.2)
                    .opacity(1 - animationProgress)
                    .scaleEffect(1 + animationProgress / 5)
            }
        }.ignoresSafeArea()
        .onAppear() {
            currentEncounterView = adventureViewModel.currentEncounterView
        }
        .onChange(of: adventureViewModel.shouldAnimateTransitionNow) { shouldAnimate in
            if shouldAnimate {
                
                oldEncounterView = currentEncounterView
                currentEncounterView = adventureViewModel.currentEncounterView
                
                withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                    animationProgress = 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + AnimationsDuration.long) {
                    adventureViewModel.shouldAnimateTransitionNow = false
                    oldEncounterView = nil
                    animationProgress = 0
                }
            }
        }
    }
}

struct AdventureView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            AdventureView()
                .environmentObject(AdventureViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            AdventureView()
                .environmentObject(AdventureViewModel())
        }
    }
}
