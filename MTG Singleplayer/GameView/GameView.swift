//
//  GameView.swift
//  MTG Singleplayer
//
//  Created by Loic D on 01/08/2022.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @State var lifePointsViewModel: LifePointsViewModel?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                GradientView()
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        LeftView()
                            .frame(width: GameViewSize.leftPanelWitdh)
                        BoardView()
                    }
                    BottomBarView()
                        .frame(height: GameViewSize.bottomBar)
                }
                if lifePointsViewModel != nil {
                    HStack {
                        Spacer()
                        LifePointsView()
                            .environmentObject(lifePointsViewModel!)
                            .frame(width: GameViewSize.lifePointsWidth, height: UIScreen.main.bounds.height / 2)
                            .cornerRadius(15)
                            .padding(.trailing, 10)
                            .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
                    }
                }
                HandView()
                GraveyardView()
                    .opacity(gameViewModel.showGraveyardView ? 1 : 0)
                CastedCardView()
                    .opacity(gameViewModel.showCardsToCastView ? 1 : 0)
                WinningView()
                    .opacity(gameViewModel.gameResult == 1 ? 1 : 0)
                LosingView()
                    .opacity(gameViewModel.gameResult == -1 ? 1 : 0)
            }.frame(width: geo.size.width, height: geo.size.height)
        }.ignoresSafeArea()
        .onAppear() {
            lifePointsViewModel = LifePointsViewModel()
        }
    }
}

struct LeftView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        VStack {
            // Turn Counter
            TextSubTitle("\(gameViewModel.turnCount)")
            
            // Draw a card
            Button(action: {
                withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                    gameViewModel.drawCard()
                }
            }, label: {
                GrayButtonLabel("Draw a card")
            })
            
            // Show graveyard
            Button(action: {
                withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                    gameViewModel.showGraveyardView = true
                }
            }, label: {
                GrayButtonLabel("Graveyard")
            })
        }
    }
}

struct BoardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 15), count: 2), alignment: .top, spacing: 15) {
                ForEach(gameViewModel.board) { card in
                    CardOnBoardView(card: card)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, GameViewSize.lifePointsWidth + 20)
            .padding(.bottom, 10)
            .animation(Animation.easeInOut(duration: 0.5), value: gameViewModel.board)
        }
        .padding(.top, GameViewSize.handHeight)
    }
}

struct BottomBarView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                gameViewModel.newTurn()
            }, label: {
                GrayButtonLabel("New turn")
            })
        }
    }
}

struct CastedCardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    if !gameViewModel.cardsToCast.cardsFromGraveyard.isEmpty {
                        CardToCastGroupView(text: "From Graveyard", cardArray: gameViewModel.cardsToCast.cardsFromGraveyard)
                    }
                    if !gameViewModel.cardsToCast.cardsFromHand.isEmpty {
                        CardToCastGroupView(text: "From Hand", cardArray: gameViewModel.cardsToCast.cardsFromHand)
                    }
                    if !gameViewModel.cardsToCast.cardsFromLibrary.isEmpty {
                        CardToCastGroupView(text: "From Library", cardArray: gameViewModel.cardsToCast.cardsFromLibrary)
                    }
                    Spacer()
                }
                .frame(minWidth: UIScreen.main.bounds.width - 40)
                .padding(.horizontal, 20)
            }
        }
        .onTapGesture(count: 1) {
            gameViewModel.closeCardsToCast()
        }
    }
    
    struct CardToCastGroupView: View {
        
        let text: String
        let cardArray: [Card]
        
        var body: some View {
            HStack {
                VStack {
                    TextSubTitle(text)
                    
                    HStack(spacing: 20) {
                        ForEach(cardArray) { card in
                            ZStack {
                                CardView(card: card)
                                    .frame(width: CardSize.width.big, height: CardSize.height.big)
                                    .cornerRadius(CardSize.cornerRadius.big)
                                
                                if card.cardCount > 1 {
                                    TextSubTitle("x\(card.cardCount)")
                                }
                            }
                            .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
                        }
                    }
                }
            }
        }
    }
}

struct GraveyardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .onTapGesture(count: 1) {
                    withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                        gameViewModel.showGraveyardView = false
                    }
                }
            VStack {
                TextSubTitle("Touch a permanent card to put it back onto the battlefield")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        Spacer()
                        ForEach(gameViewModel.graveyard) { card in
                            GraveyardCardView(card: card)
                        }
                        Spacer()
                    }
                    .frame(minWidth: UIScreen.main.bounds.width - 40, minHeight: CardSize.height.big + 10)
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
    struct GraveyardCardView: View {
        
        let card: Card
        
        var body: some View {
            HStack {
                VStack {
                    Button(action: {
                        
                    }, label: {
                        TextSubTitle("Exile")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        CardView(card: card)
                            .frame(width: CardSize.width.big, height: CardSize.height.big)
                            .cornerRadius(CardSize.cornerRadius.big)
                            .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
                    }).padding(.bottom, 10)

                        
                    
                    // TO LIBRARY ???
                }
            }
        }
    }
}

struct HandView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let maxCardsBeforeShrinking = 4
    var cardSizeCoeff: CGFloat {
        return gameViewModel.hand.count > maxCardsBeforeShrinking ? CGFloat(maxCardsBeforeShrinking) / CGFloat(gameViewModel.hand.count) : 1
    }
    
    var body: some View {
        HStack {
            ForEach(gameViewModel.hand) { card in
                Image("CardBack")
                    .resizable()
                    .frame(width: CardSize.width.hand * cardSizeCoeff, height: CardSize.height.hand * cardSizeCoeff)
                    .cornerRadius(CardSize.cornerRadius.hand * cardSizeCoeff)
                    .rotationEffect(.degrees(180))
                    .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
                    .transition(.move(edge: .top))
            }
        }.position(x: (UIScreen.main.bounds.width - GameViewSize.leftPanelWitdh) / 2 + GameViewSize.leftPanelWitdh, y: 0)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            GameView()
                .environmentObject(GameViewModel(stage: 1, deckId: 1))
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            GameView()
                .environmentObject(GameViewModel(stage: 1, deckId: 1))
        }
    }
}





