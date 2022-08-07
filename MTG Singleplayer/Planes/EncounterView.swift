//
//  EncounterView.swift
//  MTG Singleplayer
//
//  Created by Loic D on 02/08/2022.
//

import SwiftUI

struct EncounterView: View {
    
    let encounter: Encounter
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(encounter.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        ForEach(encounter.choices) { choice in
                            ChoiceView(choice: choice)
                        }
                    }
                }
                
                GoldAndLifeCountView()
                    .position(x: geo.size.width - EncounterViewSize.choiceWidth - 60, y: 100)
                
                VStack(alignment: .leading) {
                    TextLargeTitle(encounter.title)
                    Spacer()
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 60) {
                            Spacer()
                            if encounter.reward != nil {
                                RewardsView(rewards: encounter.reward!)
                            }
                            if encounter.offer != nil {
                                OffersView(offers: encounter.offer!)
                            }
                            Spacer()
                        }.frame(minWidth: geo.size.width - EncounterViewSize.choiceWidth - 40)
                    }
                    
                    Spacer()
                    TextParagraph(encounter.description)
                        .padding(20)
                        .frame(maxWidth: UIScreen.main.bounds.width / 2)
                        .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                    TextSubTitle("Art by \(encounter.artistName)")
                }.padding(60)
            }
        }.ignoresSafeArea()
    }
}

struct GoldAndLifeCountView: View {
    @EnvironmentObject var adventureViewModel: AdventureViewModel
    @State var newGoldValue: Int = 0
    @State var goldAnimationProgress: CGFloat = 0
    @State var newLifeValue: Int = 0
    @State var lifeAnimationProgress: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 40) {
            VStack(spacing: 20) {
                GoldView(title: "x \(adventureViewModel.currentGold)").scaleEffect(1 +  goldAnimationProgress / 5)
                
                GoldView(title: (newGoldValue > 0 ? "+" : "-") + " \(newGoldValue)")
                    .offset(y: goldAnimationProgress * 50)
                    .opacity(goldAnimationProgress)
            }
            VStack(spacing: 20) {
                LifeView(title: "x \(adventureViewModel.currentLife)").scaleEffect(1 +  lifeAnimationProgress / 5)
                
                LifeView(title: (newLifeValue > 0 ? "+" : "-") + " \(newLifeValue)")
                    .offset(y: lifeAnimationProgress * 50)
                    .opacity(lifeAnimationProgress)
            }
        }
        .onChange(of: adventureViewModel.currentGold) { [oldValue = adventureViewModel.currentGold] newValue in
            newGoldValue = newValue - oldValue
            goldAnimationProgress = 1
            withAnimation(.easeInOut(duration: AnimationsDuration.average).delay(AnimationsDuration.long)) {
                goldAnimationProgress = 0
            }
        }
        .onChange(of: adventureViewModel.currentLife) { [oldValue = adventureViewModel.currentLife] newValue in
            newLifeValue = newValue - oldValue
            lifeAnimationProgress = 1
            withAnimation(.easeInOut(duration: AnimationsDuration.average).delay(AnimationsDuration.long)) {
                lifeAnimationProgress = 0
            }
        }
    }
    
    struct GoldView: View {
        let title: String
        
        var body: some View {
            HStack(spacing: 10) {
                TextSubTitle(title)
                Image("Gold")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
    }
    
    struct LifeView: View {
        let title: String
        
        var body: some View {
            HStack(spacing: 10) {
                TextSubTitle(title)
                Image("Life")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
    }
}

struct RewardsView: View {
    let rewards: [Reward]
    // IMAGE BY FREEPIK
    
    var body: some View {
        ForEach(0..<rewards.count, id:\.self) { i in
            RewardView(reward: rewards[i])
        }
    }
    
    struct RewardView: View {
        @EnvironmentObject var adventureViewModel: AdventureViewModel
        let reward: Reward
        
        var body: some View {
            VStack(spacing: 20) {
                Image(reward.imageName)
                    .resizable()
                    .frame(width: EncounterViewSize.rewardImageSize, height: EncounterViewSize.rewardImageSize)
                
                TextSubTitle(reward.title)
            }
        }
    }
}

struct OffersView: View {
    let offers: [Offer]
    
    var body: some View {
        ForEach(0..<offers.count, id:\.self) { i in
            OfferView(offer: offers[i])
        }
    }
    
    struct OfferView: View {
        @EnvironmentObject var adventureViewModel: AdventureViewModel
        let offer: Offer
        @State var alreadyPurchased = false
        
        var body: some View {
            Button(action: {
                adventureViewModel.buyOffer(offer: offer)
                alreadyPurchased = true
            }, label: {
                VStack(spacing: 20) {
                    Image(offer.imageName)
                        .resizable()
                        .frame(width: EncounterViewSize.rewardImageSize, height: EncounterViewSize.rewardImageSize)
                    
                    TextParagraph(offer.title)
                    
                    TextSubTitle(offer.cost.title)
                }
            }).disabled(!adventureViewModel.canPlayerBuyOffer(offer: offer) || alreadyPurchased)
        }
    }
}

struct ChoiceView: View {
    
    let choice: EncounterChoice
    @EnvironmentObject var adventureViewModel: AdventureViewModel
    
    var body: some View {
        Button(action: {
            // Go to choice.encounterId
            adventureViewModel.choiceButtonPressed(choice: choice)
        }, label: {
            //GrayButtonLabel(choice.title)
            ZStack() {
                LinearGradient(
                            gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)), Color(#colorLiteral(red: 0.06962847469, green: 0.06962847469, blue: 0.06962847469, alpha: 0.63))]),
                            startPoint: .leading, endPoint: .trailing)

                TextSubTitle(choice.title)
            }
        }).frame(width: EncounterViewSize.choiceWidth)
    }
}

struct EncounterViewSize {
    static let rewardImageSize: CGFloat = 80
    static let choiceWidth: CGFloat = 200
}

struct EncounterView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            EncounterView(encounter: Encounters.plane_kamigawa["Kamigawa_Intro"]!)
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            EncounterView(encounter: Encounters.plane_kamigawa["Kamigawa_Intro"]!)
        }
    }
}
