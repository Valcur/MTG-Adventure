//
//  LifePointsView.swift
//  Horde
//
//  Created by Loic D on 23/07/2022.
//
import SwiftUI

struct LifePointsView: View {

    @EnvironmentObject var lifePointsViewModel: LifePointsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LifePointsPlayerPanelView(playerName: "AI",life: lifePointsViewModel.startingLife, blurEffect: .systemMaterialDark, isMainPlayerLife: false)
                .environmentObject(lifePointsViewModel)
            LifePointsPlayerPanelView(playerName: "Player",life: lifePointsViewModel.startingLife, blurEffect: .systemThinMaterialDark, isMainPlayerLife: true)
                .environmentObject(lifePointsViewModel)
        }.ignoresSafeArea()
    }
}

struct LifePointsPlayerPanelView: View {
    
    @EnvironmentObject var lifePointsViewModel: LifePointsViewModel
    @EnvironmentObject var gameViewModel: GameViewModel
    
    let playerName: String
    @State var prevValue: CGFloat = 0
    @State var totalChange: Int = 0
    @State var totalChangeTimer: Timer?
    @State var life: Int
    let blurEffect: UIBlurEffect.Style
    let isMainPlayerLife: Bool
    
    var body: some View {
        ZStack {
            LifePointsPanelView(playerName: playerName, lifepoints: $life, totalChange: $totalChange, blurEffect: blurEffect)
            VStack(spacing: 0) {
                Rectangle()
                    .opacity(0.0001)
                    .onTapGesture {
                        addLifepoint()
                        startTotalChangeTimer()
                    }
                Rectangle()
                    .opacity(0.0001)
                    .onTapGesture {
                        removeLifepoint()
                        startTotalChangeTimer()
                    }
            }
        }
        .gesture(DragGesture()
            .onChanged { value in
                let newValue = value.translation.height
                if newValue > prevValue + 10 {
                    prevValue = newValue
                    removeLifepoint()
                }
                else if newValue < prevValue - 10 {
                    prevValue = newValue
                    addLifepoint()
                }
            }
            .onEnded({ _ in
                startTotalChangeTimer()
            })
        )
    }
    
    private func addLifepoint() {
        totalChangeTimer?.invalidate()
        life += 1
        totalChange += 1
    }
    
    private func removeLifepoint() {
        totalChangeTimer?.invalidate()
        if life > 0 {
            life -= 1
            totalChange -= 1
        }
    }
    
    private func startTotalChangeTimer() {
        totalChangeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            totalChange = 0
            if life <= 0 {
                gameViewModel.gameResult = isMainPlayerLife ? -1 : 1
            }
        }
    }
}

struct LifePointsPanelView: View {
    
    @EnvironmentObject var lifePointsViewModel: LifePointsViewModel
    
    let playerName: String
    @Binding var lifepoints: Int
    @Binding var totalChange: Int
    let blurEffect: UIBlurEffect.Style
    
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: blurEffect))
            
            VStack {
                Spacer()
                
                Text(playerName)
                    .font(.title3)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(lifepoints)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            
            if totalChange != 0 {
                VStack {
                    HStack {
                        Text(totalChange > 0  ? "+\(totalChange)" : "\(totalChange)")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.leading, 20).padding(.top, 20)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LifePointsView_Previews: PreviewProvider {
    static var previews: some View {
        LifePointsView()
            .environmentObject(LifePointsViewModel())
    }
}

class LifePointsViewModel: ObservableObject {
    
    let startingLife: Int
    
    init() {
        self.startingLife = 1
        // 60 if two player mode
    }
}
