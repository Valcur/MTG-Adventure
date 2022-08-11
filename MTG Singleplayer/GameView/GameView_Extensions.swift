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
                    .padding(5)
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
                    .padding(5)
            })
            Spacer()
        }.padding(.vertical, 10).background(Color.black.opacity(0.3))
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
                            .offset(y: CardSize.height.hand / 2 - GameViewSize.graveyardAndLibraryHeight / 2)
                    } else {
                        Image("BlackBackground")
                            .resizable()
                            .frame(width: CardSize.width.hand, height: CardSize.height.hand)
                            .cornerRadius(CardSize.cornerRadius.hand)
                            .offset(y: CardSize.height.hand / 2 - GameViewSize.graveyardAndLibraryHeight / 2)
                    }
                }.frame(height: GameViewSize.graveyardAndLibraryHeight).clipped()
                
                
                TextSubTitle("\(gameViewModel.graveyard.count)")
            }
        })
    }
}

struct PlayerLibraryView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    var libraryCount: Int {
        return gameViewModel.deck.deckBasic.count + gameViewModel.deck.deckMidrange.count + gameViewModel.deck.deckEndgame.count
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                gameViewModel.showGraveyardView = true
            }
        }, label: {
            ZStack {
                VStack {
                    if libraryCount > 0 {
                        Image("CardBack")
                            .resizable()
                            .frame(width: CardSize.width.hand, height: CardSize.height.hand)
                            .cornerRadius(CardSize.cornerRadius.hand)
                            .offset(y: CardSize.height.hand / 2 - GameViewSize.graveyardAndLibraryHeight / 2)
                    } else {
                        Image("BlackBackground")
                            .resizable()
                            .frame(width: CardSize.width.hand, height: CardSize.height.hand)
                            .cornerRadius(CardSize.cornerRadius.hand)
                            .offset(y: CardSize.height.hand / 2 - GameViewSize.graveyardAndLibraryHeight / 2)
                    }
                }.frame(height: GameViewSize.graveyardAndLibraryHeight).clipped()
                
                
                TextSubTitle("\(libraryCount)")
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
                    TextSubTitle("x\(card.cardCount)")
                }
                
                HStack {
                    if card.countersOnCard > 0 {
                        CountersOnCardView(countersCount: card.countersOnCard)
                    }
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
                }.offset(y: -CardSize.height.normal / 3.1).padding(.horizontal, CardSize.height.normal / 17)
                
            }
            .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
            .onTapGesture(count: 1) {
                // Remove or return to hand
                if gameViewModel.returnToHandModeEnable {
                    print("Send \(card.cardName) to hand")
                    gameViewModel.returnToHand(card: card)
                } else if gameViewModel.addCountersModeEnable {
                    gameViewModel.addCountersToCardOnBoard(card: card)
                } else if gameViewModel.removeCountersModeEnable {
                    gameViewModel.removeCountersFromCardOnBoard(card: card)
                } else {
                    print("Send \(card.cardName) to graveyard")
                    gameViewModel.destroyPermanent(card: card)
                }
            }
        })
    }
    
    struct CountersOnCardView: View {
        let countersCount: Int
        var body: some View {
            ZStack {
                TextSubTitle("\(countersCount)")
            }
            .frame(width: GameViewSize.attackBlockerImageSize * 1.1, height: GameViewSize.attackBlockerImageSize * 1.1)
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
            .cornerRadius(40)
            .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
        }
    }
}

struct EmblemView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        VStack {
            TextParagraph(NSLocalizedString("Deck_\(gameViewModel.deckName)", tableName: "DeckTexts", comment: "The deck special text"))
            //Spacer()
        }
        .padding(5)
        //.frame(width: CardSize.width.hand, height: CardSize.height.hand)
        /*.overlay(
            RoundedRectangle(cornerRadius: CardSize.cornerRadius.hand)
                .stroke(Color.white, lineWidth: 2)
        )*/
    }
}

struct AddCountersOnPermanentsView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    var body: some View {
        HStack {
            Button(action: {
                gameViewModel.removeCountersModeEnable.toggle()
                gameViewModel.addCountersModeEnable = false
            }, label: {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(15)
            }).opacity(gameViewModel.removeCountersModeEnable ? 0.5 : 1)
            TextParagraph("/")
            Button(action: {
                gameViewModel.addCountersModeEnable.toggle()
                gameViewModel.removeCountersModeEnable = false
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(15)
            }).opacity(gameViewModel.addCountersModeEnable ? 0.5 : 1)
        }
        .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
        .cornerRadius(40)
        .padding(10)
        .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
    }
}

struct ReturnToHandView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    var body: some View {
        Button(action: {
            gameViewModel.returnToHandModeEnable.toggle()
        }, label: {
            GrayButtonLabel(systemName: "hand.wave.fill")
        }).opacity(gameViewModel.returnToHandModeEnable ? 0.5 : 1)
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
           }
       }.frame(width: 200)
    }
}

struct ShowAttackersAndBlockersView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        HStack {
            //TextParagraph("Show")
            Button(action: {
                withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                    gameViewModel.toggleOnlyShowAttackers()
                }
            }, label: {
                GrayButtonImageLabel("Attacker")
            }).opacity(gameViewModel.onlyShowAttackers ? 0.5 : 1)
            TextParagraph("/")
            Button(action: {
                withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                    gameViewModel.toggleOnlyShowBlockers()
                }
            }, label: {
                GrayButtonImageLabel("Blocker")
            }).opacity(gameViewModel.onlyShowBlockers ? 0.5 : 1)
        }
    }
}



// MARK: Structs

struct CardSize {
    struct width {
        static let big = (UIScreen.main.bounds.height / 100) * 6.3 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 6.3 * 4.5 as CGFloat
        static let hand = (UIScreen.main.bounds.height / 100) * 6.3 * 3.5 as CGFloat
        static let small = 49 as CGFloat
    }
    
    struct height {
        static let big = (UIScreen.main.bounds.height / 100) * 8.8 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 8.8 * 4.5 as CGFloat
        static let hand = (UIScreen.main.bounds.height / 100) * 8.8 * 3.5 as CGFloat
        static let small = 67 as CGFloat
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
    static let tokenCreationRowWidth: CGFloat = UIScreen.main.bounds.width / 5
    static let attackBlockerImageSize: CGFloat = CardSize.height.normal / 8.5
    static let graveyardAndLibraryHeight: CGFloat = 100
}
