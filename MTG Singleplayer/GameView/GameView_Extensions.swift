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

struct ManaCounterView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                gameViewModel.manaCount -= 1
            }, label: {
                Image(systemName: "minus")
                    .font(.title2)
                    .foregroundColor(.white)
            })
            Spacer()
            ZStack {
                Image(systemName: "pentagon.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                TextTitle("\(gameViewModel.manaCount)")
            }
            Spacer()
            Button(action: {
                gameViewModel.manaCount += 1
            }, label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.white)
            })
            Spacer()
        }
    }
}

struct PlayerGraveyardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                gameViewModel.showGraveyardView = true
            }
        }, label: {
            ZStack {
                VStack {
                    if gameViewModel.graveyard.count > 0 {
                        CardView(card: gameViewModel.graveyard.last!)
                            .frame(width: CardSize.width.hand, height: CardSize.height.hand)
                            .cornerRadius(CardSize.cornerRadius.hand)
                            .offset(y: CardSize.height.hand / 2 - 40)
                    } else {
                        Image("BlackBackground")
                            .resizable()
                            .frame(width: CardSize.width.hand, height: CardSize.height.hand)
                            .cornerRadius(CardSize.cornerRadius.hand)
                            .offset(y: CardSize.height.hand / 2 - 40)
                    }
                }.frame(height: 80).clipped()
                
                
                TextSubTitle("\(gameViewModel.graveyard.count)")
            }
        })
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
                
                HStack {
                    Spacer()
                    if card.shouldCardAttack {
                        Image("Attacker")
                            .resizable()
                            .frame(width: GameViewSize.attackBlockerImageSize, height: GameViewSize.attackBlockerImageSize)
                    }
                    if card.shouldCardAttack && card.shouldCardBlock {
                        TextTitle("/")
                    }
                    if card.shouldCardBlock {
                        Image("Blocker")
                            .resizable()
                            .frame(width: GameViewSize.attackBlockerImageSize, height: GameViewSize.attackBlockerImageSize)
                    }
                }.offset(y: -CardSize.height.normal / 2 + GameViewSize.attackBlockerImageSize * 1.4).padding(.trailing, CardSize.height.normal / 18)
                
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
        VStack {
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

struct AddCountersOnPermanentsView: View {
    var body: some View {
        GrayButtonLabel("Counters")
    }
}

struct ReturnToHandView: View {
    var body: some View {
        GrayButtonLabel(systemName: "hand.wave.fill")
    }
}

struct TokenCreationRowView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let emblemText: String = "Creatures you control have SHROUD"
    
    var body: some View {
        HStack(spacing: 10) {
           TextParagraph("Create")
            
           ScrollView(.horizontal) {
               HStack(spacing: 10) {
                   ForEach(gameViewModel.deck.tokensAvailable) { token in
                       Button(action: {
                       }, label: {
                           CardView(card: token)
                               .frame(width: CardSize.width.small, height: CardSize.height.small)
                               .cornerRadius(CardSize.cornerRadius.small)
                               .onTapGesture(count: 1) {
                                   print("Create token button pressed")
                                   gameViewModel.tokenRowPressed(token: token)
                               }
                               /*.gesture(LongPressGesture(minimumDuration: 0.1)
                                   .sequenced(before: LongPressGesture(minimumDuration: .infinity))
                                   .updating($isDetectingLongPress) { value, state, transaction in
                                       switch value {
                                           case .second(true, nil): //This means the first Gesture completed
                                               state = true //Update the GestureState
                                           gameViewModel.shouldZoomOnCard = true //Update the @ObservedObject property
                                           gameViewModel.cardToZoomIn = token
                                           default: break
                                       }
                                   })*/
                           })
                   }
               }
           }.frame(maxWidth: GameViewSize.tokenCreationRowWidth)
       }
    }
}



// MARK: Structs

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

struct GameViewSize {
    static let bottomBar: CGFloat = 60
    static let leftPanelWitdh: CGFloat = 200
    static let handHeight: CGFloat = 80
    static let lifePointsWidth: CGFloat = UIScreen.main.bounds.width / 6
    static let tokenCreationRowWidth: CGFloat = UIScreen.main.bounds.width / 2
    static let attackBlockerImageSize: CGFloat = CardSize.height.normal / 7.5
}
