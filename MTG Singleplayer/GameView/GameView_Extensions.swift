//
//  GameView_Extensions.swift
//  MTG Singleplayer
//
//  Created by Loic D on 01/08/2022.
//

import SwiftUI

struct WinningView: View {
    @EnvironmentObject var adventureViewModel: AdventureViewModel
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            VStack {
                TextSubTitle("You won")
                Spacer()
                TextSubTitle("press anywhere to continue")
            }.frame(height: UIScreen.main.bounds.height / 2)
        }
        .onTapGesture(count: 1) {
            adventureViewModel.fightWon()
        }
    }
}

struct LosingView: View {
    @EnvironmentObject var adventureViewModel: AdventureViewModel
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            VStack {
                TextSubTitle("You lost")
                Spacer()
                TextSubTitle("press anywhere to continue")
            }.frame(height: UIScreen.main.bounds.height / 2)
        }
        .onTapGesture(count: 1) {
            withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                //gameViewModel.showGraveyardView = false
            }
        }
    }
}


// MARK: Card Views
struct CardView: View {
    
    @ObservedObject var card: Card
    
    var body: some View {
        card.cardUIImage
            .resizable()
            .onAppear() {
                card.downloadImage()
            }
    }
}

struct CardOnBoardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let card: Card
    
    var body: some View {
        Button(action: {
            
        }, label: {
            ZStack {
                CardView(card: card)
                    .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                    .cornerRadius(CardSize.cornerRadius.normal)
                
                if card.cardCount > 1 {
                    Text("x\(card.cardCount)")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
            .onTapGesture(count: 1) {
                print("Remove card")
                gameViewModel.destroyPermanent(card: card)
            }
        })
    }
}

struct EmblemView: View {
    
    let emblemText: String = "Creatures you control have SHROUD"
    
    var body: some View {
        HStack {
            Text(emblemText)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(5)
        .frame(width: CardSize.width.hand, height: CardSize.height.hand)
        .overlay(
            RoundedRectangle(cornerRadius: CardSize.cornerRadius.hand)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}

// MARK: Structs
struct GameViewSize {
    static let bottomBar: CGFloat = 60
    static let leftPanelWitdh: CGFloat = 200
    static let handHeight: CGFloat = 80
    static let lifePointsWidth: CGFloat = UIScreen.main.bounds.width / 6
}

struct CardSize {
    struct width {
        static let big = (UIScreen.main.bounds.height / 100) * 6.3 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 6.3 * 4.5 as CGFloat
        static let hand = (UIScreen.main.bounds.height / 100) * 6.3 * 3.5 as CGFloat
        static let small = 54 as CGFloat
    }
    
    struct height {
        static let big = (UIScreen.main.bounds.height / 100) * 8.8 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 8.8 * 4.5 as CGFloat
        static let hand = (UIScreen.main.bounds.height / 100) * 8.8 * 3.5 as CGFloat
        static let small = 75 as CGFloat
    }
    
    struct cornerRadius {
        static let big = (UIScreen.main.bounds.height / 100) * 0.35 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 0.35 * 4.5 as CGFloat
        static let hand = (UIScreen.main.bounds.height / 100) * 0.35 * 3.5 as CGFloat
        static let small = 3 as CGFloat
    }
}
