//
//  RulesView.swift
//  MTG Singleplayer
//
//  Created by Loic D on 03/09/2022.
//

import SwiftUI

struct RulesView: View {
    
    @State public var showRules = true
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 100) {
                Button(action: {
                    
                }, label: {
                    TextTitle("Use the app")
                })
                Button(action: {
                    
                }, label: {
                    TextTitle("Play the game")
                })
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                        showRules = false
                    }
                }, label: {
                    TextTitle("Return")
                })
            }.frame(width: RuelsViewSize.leftPaneltWidth)
            
            UseTheAppView()
        }.padding(20).background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
        .opacity(showRules ? 1 : 0)
    }
    
    struct UseTheAppView: View {
        var body: some View {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 80) {
                    VStack(alignment: .leading, spacing: 20) {
                        TextSubTitle("Battlefield")
                        
                        TextParagraph("Touch a permanent to destroy it")
                        
                        TextParagraph("Permanents are split in two spaces : \n - cards already on the board : attackers in this space will attack you this turn \n - cards who arrived this turn : if they don't have haste they won't attack you")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        TextSubTitle("Left row")
                        
                        TextParagraph("The elements from top to bottom")
                        
                        TextParagraph("AI mana : show the current mana of the AI, if an effect CONTROLLED BY YOU would increase/decrease the AI mana, use the buttons -/+ (see 'Play the game section')")
                        
                        TextParagraph("The special rules for the AI during this game")
                        
                        TextParagraph("The AI graveyard : press to access")
                        
                        TextParagraph("The AI library : press to access")
                        
                        TextParagraph("The speical bonus you gained through your journey")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        TextSubTitle("Bottom row")
                        
                        HStack {
                            Image(systemName: "hand.wave.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: RuelsViewSize.iconSize, height: RuelsViewSize.iconSize)
                            TextParagraph("Enable/Disable the 'return to hand' mode : press a permanent on the battlefield with this mode enable to return the card to the AI hand")
                        }
                        
                        HStack {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: RuelsViewSize.iconSize, height: RuelsViewSize.iconSize)
                            TextParagraph("Enable/Disable the 'remove counters' mode : press a permanent on the battlefield with this mode enable to remove a counter")
                        }
                        
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: RuelsViewSize.iconSize, height: RuelsViewSize.iconSize)
                            TextParagraph("Enable/Disable the 'add counters' mode : press a permanent on the battlefield with this mode enable to add a counter")
                        }
                        
                        HStack {
                            Image("Attacker")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: RuelsViewSize.iconSize, height: RuelsViewSize.iconSize)
                            TextParagraph("Enable/Disable the 'show attackers' mode : only show the permanents that are elligible to attack you")
                        }
                        
                        HStack {
                            Image("Blocker")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: RuelsViewSize.iconSize, height: RuelsViewSize.iconSize)
                            TextParagraph("Enable/Disable the 'show blockers' mode : only show the permanents that are elligible to blocking your creatures when you are attacking")
                        }
                        
                        TextParagraph("Press a card in the row to create a token")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        TextSubTitle("Hand")
                        
                        TextParagraph("Press a card in the AI hand to make him discard a card at random")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        TextSubTitle("Lifepoint counter")
                        
                        TextParagraph("Top : the opponents lifepoints, if it reach 0, you win")
                        
                        TextParagraph("Top : your lifepoints, if it reach 0, you lose")
                    }
                }.padding(.trailing, 10)
            }
        }
    }
    
    struct RuelsViewSize {
        static let leftPaneltWidth: CGFloat = UIScreen.main.bounds.width / 4.7
        static let iconSize: CGFloat = 25
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            RulesView()
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            RulesView()
        }
    }
}
