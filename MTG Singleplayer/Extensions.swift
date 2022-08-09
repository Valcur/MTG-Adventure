//
//  Extensions.swift
//  MTG Singleplayer
//
//  Created by Loic D on 01/08/2022.
//

import Foundation
import SwiftUI

struct AnimationsDuration {
    static let short: CGFloat = 0.3
    static let average: CGFloat = 0.5
    static let long: CGFloat = 1.0
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct GrayButtonLabel: View {
    let text: String?
    let systemName: String?
    
    init(_ text: String) {
        self.text = text
        self.systemName = nil
    }
    
    init(systemName: String) {
        self.text = nil
        self.systemName = systemName
    }
    
    var body: some View {
        if text != nil {
            Text(text!)
                .fontWeight(.bold)
                .font(.subheadline)
                .padding()
                .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(10)
                .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
        } else {
            Image(systemName: systemName!)
                .font(.subheadline)
                .padding()
                .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(10)
                .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
        }
    }
    
    
}

struct TextParagraph: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.subheadline)
            .foregroundColor(.white)
    }
}

struct TextSubTitle: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.title2)
            .foregroundColor(.white)
    }
}

struct TextLargeTitle: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.system(size: 70))
            .foregroundColor(.white)
    }
}

struct TextTitle: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.system(size: 40))
            .foregroundColor(.white)
    }
}

struct GradientView: View {
    
    let gradient: Gradient
    
    init(/*gradientId: Int*/) {
        let gradientId = 1
        switch gradientId {
        case 1:
            gradient = Gradient(colors: [Color("GradientLightColor"), Color("GradientDarkColor")])
            break
        case 3:
            gradient = Gradient(colors: [Color("GradientLight3Color"), Color("GradientDark3Color")])
            break
        case 4:
            gradient = Gradient(colors: [Color("GradientLight4Color"), Color("GradientDark4Color")])
            break
        case 5:
            gradient = Gradient(colors: [Color("GradientLight5Color"), Color("GradientDark5Color")])
            break
        case 6:
            gradient = Gradient(colors: [Color("GradientLight6Color"), Color("GradientDark6Color")])
            break
        case 7:
            gradient = Gradient(colors: [Color("GradientLight7Color"), Color("GradientDark7Color")])
            break
        case 8:
            gradient = Gradient(colors: [Color("GradientLight8Color"), Color("GradientDark8Color")])
            break
        default:
            gradient = Gradient(colors: [Color("GradientLight2Color"), Color("GradientDark2Color")])
            break
        }
    }
    
    var body: some View {
        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}
