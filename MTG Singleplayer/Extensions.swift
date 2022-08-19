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

struct GrayButtonImageLabel: View {
    let imageName: String
    
    init(_ imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 15, height: 15)
            .padding()
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(10)
            .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
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
    var color: Color
    
    init(_ text: String, color: Color = .white) {
        self.text = text
        self.color = color
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.title2)
            .foregroundColor(color)
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

struct TextParagraphWithManaCost: View {
    let text: NSMutableAttributedString
    let imageSize: CGFloat = 12
    let textSize: CGFloat = 15   // Subheadline
    
    // {2}{W}: aaeazeae -> 2,W,:aeeaze
    init(_ text: String) {
        let font = UIFont.systemFont(ofSize: textSize, symbolicTraits: .traitBold)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
        ]
    
        let textSeparated = text.replacingOccurrences(of: "{", with: "").components(separatedBy: "}")
        let manaCost = textSeparated.dropLast()
        let fullString = NSMutableAttributedString(string: "", attributes: attributes)
        for cost in manaCost {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: cost)
            imageAttachment.bounds = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
            let imageString = NSAttributedString(attachment: imageAttachment)
            fullString.append(imageString)
        }
        fullString.append(NSAttributedString(string: textSeparated.last!, attributes: attributes))
        self.text = fullString
    }
    
    var body: some View {
        //AttributedText(text)
        
        TextWithAttributedString(attributedText: text)
                 //.padding([.leading, .trailing], self.horizontalPadding)
                 .layoutPriority(1)
                 .background(Color.clear)

    }
}

extension UIFont {
    class func systemFont(ofSize fontSize: CGFloat, symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        return UIFont.systemFont(ofSize: fontSize).including(symbolicTraits: symbolicTraits)
    }

    func including(symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        var _symbolicTraits = self.fontDescriptor.symbolicTraits
        _symbolicTraits.update(with: symbolicTraits)
        return withOnly(symbolicTraits: _symbolicTraits)
    }

    func excluding(symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        var _symbolicTraits = self.fontDescriptor.symbolicTraits
        _symbolicTraits.remove(symbolicTraits)
        return withOnly(symbolicTraits: _symbolicTraits)
    }

    func withOnly(symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        guard let fontDescriptor = fontDescriptor.withSymbolicTraits(symbolicTraits) else { return nil }
        return .init(descriptor: fontDescriptor, size: pointSize)
    }
}

struct TextWithAttributedString: View {

   var attributedText: NSAttributedString
   @State private var height: CGFloat = .zero

   var body: some View {
       InternalTextView(attributedText: attributedText, dynamicHeight: $height)
           .frame(minHeight: height)
   }

   struct InternalTextView: UIViewRepresentable {

       var attributedText: NSAttributedString
       @Binding var dynamicHeight: CGFloat

       func makeUIView(context: Context) -> UITextView {
           let textView = UITextView()
           textView.textAlignment = .justified
           textView.isScrollEnabled = false
           textView.isUserInteractionEnabled = false
           textView.showsVerticalScrollIndicator = false
           textView.showsHorizontalScrollIndicator = false
           textView.allowsEditingTextAttributes = false
           textView.backgroundColor = .clear
           textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
           textView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
           return textView
       }

       func updateUIView(_ uiView: UITextView, context: Context) {
           uiView.attributedText = attributedText
           DispatchQueue.main.async {
               dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
           }
       }
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
