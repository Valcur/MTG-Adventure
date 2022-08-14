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
            LifePointsPlayerPanelView(playerName: "Opponent", blurEffect: .systemMaterialDark, isMainPlayerLife: false)
                .environmentObject(lifePointsViewModel)
            LifePointsPlayerPanelView(playerName: "Player", blurEffect: .systemThinMaterialDark, isMainPlayerLife: true)
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
    var life: Binding<Int> {
        if isMainPlayerLife {
            return $lifePointsViewModel.mainPLayerLife
        } else {
            return $lifePointsViewModel.opponentLife
        }
    }
    let blurEffect: UIBlurEffect.Style
    let isMainPlayerLife: Bool
    
    init(playerName: String, blurEffect: UIBlurEffect.Style, isMainPlayerLife: Bool) {
        self.playerName = playerName
        self.blurEffect = blurEffect
        self.isMainPlayerLife = isMainPlayerLife
    }
    
    var body: some View {
        ZStack {
            LifePointsPanelView(playerName: playerName, lifepoints: life, totalChange: $totalChange, blurEffect: blurEffect)
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
        life.wrappedValue += 1
        totalChange += 1
    }
    
    private func removeLifepoint() {
        totalChangeTimer?.invalidate()
        if life.wrappedValue > 0 {
            life.wrappedValue -= 1
            totalChange -= 1
        }
    }
    
    private func startTotalChangeTimer() {
        totalChangeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            totalChange = 0
            if life.wrappedValue <= 0 {
                withAnimation(.easeInOut(duration: AnimationsDuration.average)) {
                    gameViewModel.gameResult = isMainPlayerLife ? -1 : 1
                }
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
    @Published var mainPLayerLife: Int
    @Published var opponentLife: Int
    
    init() {
        self.startingLife = 1
        self.mainPLayerLife = startingLife
        self.opponentLife = startingLife
        // 60 if two player mode
    }
    
    func reset() {
        self.mainPLayerLife = startingLife
        self.opponentLife = startingLife
    }
}
