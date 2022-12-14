//
//  GameView.swift
//  MTG Singleplayer
//
//  Created by Loic D on 01/08/2022.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @State var showMenu = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                GradientView()
                
                HStack(spacing: 0) {
                    LeftView()
                        .frame(width: GameViewSize.leftPanelWitdh)
                    VStack(spacing: 0) {
                        BoardView()
                        BottomBarView()
                            .frame(height: GameViewSize.bottomBar)
                    }
                }
                
                HStack {
                    Spacer()
                    LifePointsView()
                        .environmentObject(gameViewModel.lifePointsViewModel)
                        .frame(width: GameViewSize.lifePointsWidth, height: UIScreen.main.bounds.height / 2)
                        .cornerRadius(15)
                        .padding(.trailing, 10)
                        .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
                }
                
                Group {
                    HandView()
                    StackView()
                    GraveyardView()
                        .opacity(gameViewModel.showGraveyardView ? 1 : 0)
                    LibraryView()
                        .opacity(gameViewModel.showLibraryView ? 1 : 0)
                    CastedCardView()
                        .opacity(gameViewModel.showCardsToCastView ? 1 : 0)
                    WinningView()
                        .opacity(gameViewModel.gameResult == 1 ? 1 : 0)
                    LosingView()
                        .opacity(gameViewModel.gameResult == -1 ? 1 : 0)
                }
                
                Button(action: {
                    withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                        showMenu = true
                    }
                }, label: {
                    Image(systemName: "questionmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 30)
                }).position(x: geo.size.width - 30, y: 30)
                
                RulesView(showRules: $showMenu)
                
            }.frame(width: geo.size.width, height: geo.size.height)
        }.ignoresSafeArea()
    }
}

struct LeftView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            // Turn Counter
            ManaCounterView()
            
            // Emblem
            EmblemView()
            
            // Show graveyard
            PlayerGraveyardView()
            
            // Show library
            PlayerLibraryView()
            
            PlayerEmblemView()
            
            Spacer()
            
            //EmblemView()
        }.ignoresSafeArea().frame(maxHeight: .infinity).background(/*VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))*/ Color.black.opacity(0.3))
    }
}

struct BoardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 80) {
                if gameViewModel.board.count > 0 || gameViewModel.bossCard != nil {
                    VStack(alignment: .leading, spacing: 0) {
                        TextParagraph("Board").frame(height: GameViewSize.boardDescriptionHeight)
                        LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 15), count: 2), alignment: .top, spacing: 15) {
                            if gameViewModel.bossCard != nil {
                                CardView(card: gameViewModel.bossCard!)
                                    .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                                    .cornerRadius(CardSize.cornerRadius.normal)
                                    .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
                            }
                            ForEach(gameViewModel.board) { card in
                                if (!gameViewModel.onlyShowBlockers || (gameViewModel.onlyShowBlockers && card.shouldCardBlock)) && (!gameViewModel.onlyShowAttackers || (gameViewModel.onlyShowAttackers && card.shouldCardAttack)) {
                                    CardOnBoardView(card: card)
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                        }
                        .animation(Animation.easeInOut(duration: 0.5), value: gameViewModel.board)
                    }
                }
                if gameViewModel.newToTheBoard.count > 0 {
                    VStack(alignment: .leading, spacing: 0) {
                        TextParagraph("New to the board").frame(height: GameViewSize.boardDescriptionHeight)
                        LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 15), count: 2), alignment: .top, spacing: 15) {
                            ForEach(gameViewModel.newToTheBoard) { card in
                                if (!gameViewModel.onlyShowBlockers || (gameViewModel.onlyShowBlockers && card.shouldCardBlock)) && (!gameViewModel.onlyShowAttackers || (gameViewModel.onlyShowAttackers && card.shouldCardAttack)) {
                                    CardOnNewToTheBoardView(card: card)
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                        }
                        .animation(Animation.easeInOut(duration: 0.5), value: gameViewModel.newToTheBoard)
                    }
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, GameViewSize.lifePointsWidth + 20)
            .padding(.bottom, 10)
        }
        .frame(minHeight: CardSize.height.normal * 2 + 15 + GameViewSize.boardDescriptionHeight)
        .padding(.top, GameViewSize.handHeight - GameViewSize.boardDescriptionHeight)
    }
}

struct BottomBarView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            // Draw a card
            Button(action: {
                gameViewModel.drawOneCard()
            }, label: {
                GrayButtonLabel("Draw")
            })
            
            // Return to hand
            ReturnToHandView()
            
            // Add counters
            AddCountersOnPermanentsView()
            
            ShowAttackersAndBlockersView()
            
            // Token Creation
            TokenCreationRowView()
            
            // Sword by By Bartama Graphic
            // Shield by Freepik
            
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
                HStack(spacing: 50) {
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
            withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                gameViewModel.closeCardsToCast()
            }
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
            VStack(spacing: 40) {
                TextParagraph("Touch a permanent card to put it back onto the battlefield")
                
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
        
        @EnvironmentObject var gameViewModel: GameViewModel
        let card: Card
        
        var body: some View {
            HStack {
                VStack(spacing: 20) {
                    Button(action: {
                        gameViewModel.exileFromGraveyard(card: card)
                    }, label: {
                        TextSubTitle("Exile").padding(10)
                    })
                    
                    Button(action: {
                        gameViewModel.castFromGraveyard(card: card)
                    }, label: {
                        CardView(card: card)
                            .frame(width: CardSize.width.big, height: CardSize.height.big)
                            .cornerRadius(CardSize.cornerRadius.big)
                            .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
                    }).padding(.bottom, 10)

                    HStack {
                        // To hand
                        Button(action: {
                            gameViewModel.returnToHandFromGraveyard(card: card)
                        }, label: {
                            GrayButtonLabel(systemName: "hand.wave")
                        })
                        
                        // To top of library
                        Button(action: {
                            gameViewModel.sendToTopOfLibraryFromGraveyard(card: card)
                        }, label: {
                            GrayButtonLabel(systemName: "square.3.stack.3d.top.fill")
                        })
                        
                        // To bottom of library
                        Button(action: {
                            gameViewModel.sendToBottomOfLibraryFromGraveyard(card: card)
                        }, label: {
                            GrayButtonLabel(systemName: "square.3.stack.3d.bottom.fill")
                        })
                    }
                }
            }
        }
    }
}

struct LibraryView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .onTapGesture(count: 1) {
                    withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                        gameViewModel.showLibraryView = false
                    }
                }
            VStack(spacing: 20) {
                TextParagraph("Touch a permanent card to put cast it")
                
                HStack {
                    // Buttons
                    
                    VStack {
                        Button(action: {
                            gameViewModel.revealOneMoreCard()
                        }, label: {
                            GrayButtonLabel("Reveal one more card")
                        })
                        
                        Button(action: {
                            gameViewModel.millTopCardOfLibrary()
                        }, label: {
                            GrayButtonLabel("Mill a card")
                        })
                        
                        Button(action: {
                            gameViewModel.drawOneCard()
                        }, label: {
                            GrayButtonLabel("Draw a card")
                        })
                    }
                    
                    // Library
                    
                    if gameViewModel.libraryCount - gameViewModel.cardRevealed.count  > 0 {
                        Image("CardBack")
                            .resizable()
                            .frame(width: CardSize.width.big, height: CardSize.height.big)
                            .cornerRadius(CardSize.cornerRadius.big)
                    } else {
                        Image("BlackBackground")
                            .resizable()
                            .frame(width: CardSize.width.big, height: CardSize.height.big)
                            .cornerRadius(CardSize.cornerRadius.big)
                    }
                    
                    // Card revealed
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: -CardSize.width.big / 10) {
                            ForEach(gameViewModel.cardRevealed) { card in
                                LibraryCardView(card: card)
                            }
                        }.padding(.trailing, 20)
                    }
                }
            }
        }
    }
    
    struct LibraryCardView: View {
        
        @EnvironmentObject var gameViewModel: GameViewModel
        let card: Card
        
        var body: some View {
            HStack {
                VStack(spacing: 20) {
                    Button(action: {
                        gameViewModel.exileRevealedCard(card: card)
                    }, label: {
                        TextSubTitle("Exile")
                    }).frame(height: 60)
                    
                    Button(action: {
                        gameViewModel.castRevealedCard(card: card)
                    }, label: {
                        CardView(card: card)
                            .frame(width: CardSize.width.big, height: CardSize.height.big)
                            .cornerRadius(CardSize.cornerRadius.big)
                            .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
                    })

                    HStack(spacing: 0) {
                        // To his hand
                        Button(action: {
                            gameViewModel.drawRevealedCard(card: card)
                        }, label: {
                            GrayButtonLabel(systemName: "hand.wave")
                        })
                        
                        // To the bottom of his library
                        Button(action: {
                            gameViewModel.sendToBottomOfLibraryRevealedCard(card: card)
                        }, label: {
                            GrayButtonLabel(systemName: "square.3.stack.3d.bottom.fill")
                        })
                        
                        // To the graveyard
                        Button(action: {
                            gameViewModel.sendToGraveyardRevealedCard(card: card)
                        }, label: {
                            GrayButtonLabel("Graveyard")
                        })
                    }.frame(height: 60)
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
                Button(action: {
                    withAnimation(.easeInOut(duration: AnimationsDuration.average)) {
                        gameViewModel.discardACardAtRandom()
                    }
                }, label: {
                    Image("CardBack")
                        .resizable()
                        .frame(width: CardSize.width.hand * cardSizeCoeff, height: CardSize.height.hand * cardSizeCoeff)
                        .cornerRadius(CardSize.cornerRadius.hand * cardSizeCoeff)
                        .offset(y: CardSize.height.hand / 2 - GameViewSize.graveyardAndLibraryHeight / 2)
                        .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
                }).frame(height: GameViewSize.graveyardAndLibraryHeight).clipped()                        .rotationEffect(.degrees(180)).transition(.move(edge: .top))
            }
        }.position(x: (UIScreen.main.bounds.width - GameViewSize.leftPanelWitdh) / 2 + GameViewSize.leftPanelWitdh, y: GameViewSize.graveyardAndLibraryHeight / 2)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            GameView()
                .environmentObject(GameViewModel(deckName: "Kamigawa_Forge_01", stage: 1, numberOfPlayer: 1))
                .environmentObject(AdventureViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            GameView()
                .environmentObject(GameViewModel(deckName: "Kamigawa_Forge_01", stage: 1, numberOfPlayer: 1))
                .environmentObject(AdventureViewModel())
        }
    }
}





