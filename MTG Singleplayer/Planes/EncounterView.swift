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
                
                VStack(alignment: .leading) {
                    TextLargeTitle(encounter.title)
                    Spacer()
                    HStack {
                        Spacer()
                        if encounter.reward != nil {
                            // REWARD VIEW
                        }
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
        }).frame(width: 200)
    }
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
