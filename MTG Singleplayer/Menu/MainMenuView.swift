//
//  MainMenuView.swift
//  MTG Singleplayer
//
//  Created by Loic D on 19/08/2022.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var mainMenuViewModel: MainMenuViewModel
    
    var body: some View {
        ZStack {
            Image("MainMenuImage")
                .resizable()

            ZStack {
                
                // ------------------- INTRO -------------------
                Group {
                    MainMenuIntroView()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: AnimationsDuration.average)) {
                                mainMenuViewModel.menuProgress = 1
                            }
                        }
                }
                .offset(x: getMenuOffset(menuNumber: 0))
                .opacity(mainMenuViewModel.menuProgress == 0 ? 1 : 0)
                
                // ------------------- SAVE -------------------
                Group {
                    MainMenuSaveChoiceView()
                }
                .offset(x: getMenuOffset(menuNumber: 1))
                .opacity(mainMenuViewModel.menuProgress == 1 ? 1 : 0)
                
                // ------------------- CONFIG -------------------
                Group {
                    Button(action: {
                        withAnimation(.easeInOut(duration: AnimationsDuration.average)) {
                            mainMenuViewModel.menuProgress = 1
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 15, height: 25)
                            TextParagraph("Return")
                        }
                    }).position(x: MenuViewSize.mainMenuWidth / 3, y: 80)
                    MainMenuConfigView()
                }
                .offset(x: getMenuOffset(menuNumber: 2))
                .opacity(mainMenuViewModel.menuProgress == 2 ? 1 : 0)
            }.frame(width: UIScreen.main.bounds.width)
            TextParagraph("Art by Emrah Elmasli").position(x: 100, y: UIScreen.main.bounds.height - 35)
        }.ignoresSafeArea().opacity(mainMenuViewModel.hideMenu ? 0 : 1)
    }
    
    func getMenuOffset(menuNumber: Int) -> CGFloat {
        return CGFloat(menuNumber - mainMenuViewModel.menuProgress) * MenuViewSize.mainMenuWidth
    }
}

struct MainMenuIntroView: View {
    var body: some View {
        VStack {
            TextLargeTitle("Title")
            Spacer()
            Spacer()
            TextParagraph("[Title of your Fan Content] is unofficial Fan Content permitted under the Fan Content Policy. Not approved/endorsed by Wizards. Portions of the materials used are property of Wizards of the Coast. ©Wizards of the Coast LLC. All arts authors are credited.")
            Spacer()
            TextSubTitle("Press anywhere to continue")
        }.padding(MenuViewSize.mainMenuPadding).frame(width: MenuViewSize.mainMenuWidth)
    }
}

struct MainMenuSaveChoiceView: View {
    var body: some View {
        VStack(spacing: 80) {
            Spacer()
            TextTitle("Choose a save slot")
            HStack(spacing: 0) {
                MainMenuSaveSlotView(saveNumber: 1)
                Spacer()
                MainMenuSaveSlotView(saveNumber: 2)
                Spacer()
                MainMenuSaveSlotView(saveNumber: 3)
            }
            Spacer()
        }.padding(MenuViewSize.mainMenuPadding).frame(width: MenuViewSize.mainMenuWidth)
    }
    
    struct MainMenuSaveSlotView: View {
        @EnvironmentObject var mainMenuViewModel: MainMenuViewModel
        @EnvironmentObject var adventureViewModel: AdventureViewModel
        let saveNumber: Int
        let saveExist: Bool
        var gold: Int?
        var life: Int?
        var progress: CGFloat?
        var numberOfPlayer: Int?
        
        var numberOfPlayerImage: Image? {
            if numberOfPlayer == nil {
                return nil
            }
            if numberOfPlayer == 1 {
                return Image(systemName: "person.fill")
            } else if numberOfPlayer == 2 {
                return Image(systemName: "person.2.fill")
            } else {
                return Image(systemName: "person.3.fill")
            }
        }
        
        var numberOfPlayerImageWidth: CGFloat {
            if numberOfPlayer == nil {
                return MenuViewSize.saveSlotImageSize
            }
            if numberOfPlayer == 1 {
                return MenuViewSize.saveSlotImageSize
            } else if numberOfPlayer == 2 {
                return MenuViewSize.saveSlotImageSize * 1.5
            } else {
                return MenuViewSize.saveSlotImageSize * 2
            }
        }
        
        init(saveNumber: Int) {
            let saveInfo = SaveManager.getSaveInfoFor(saveNumber: saveNumber)
            self.saveNumber = saveNumber
            if saveNumber == 1 {
                self.gold = 10
                self.life = 3
                self.progress = 40
                self.numberOfPlayer = 2
            }
            self.saveExist = saveInfo.currentEncounter != "Unset"
            if saveExist {
                self.gold = saveInfo.gold
                self.life = saveInfo.life
                self.progress = CGFloat(saveInfo.fightCompleted) / 11
                self.numberOfPlayer = saveInfo.numberOfPlayer
                self.numberOfPlayer = saveNumber
            }
        }
        
        var body: some View {
            Button(action: {
                // If deck exist -> load, else, show config
                if saveExist {
                    withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                        mainMenuViewModel.hideMenu = true
                        adventureViewModel.loadSave(saveNumber: saveNumber)
                    }
                } else {
                    withAnimation(.easeInOut(duration: AnimationsDuration.average)) {
                        mainMenuViewModel.menuProgress = 2
                    }
                }
                mainMenuViewModel.saveSelected = saveNumber
            }, label: {
                VStack {
                    TextSubTitle("Save \(saveNumber)")
                    if numberOfPlayerImage != nil {
                        numberOfPlayerImage!
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: numberOfPlayerImageWidth, height: MenuViewSize.saveSlotImageSize)
                    }
                    Spacer()
                    
                    HStack {
                        if gold != nil {
                            TextParagraph("x \(gold!)")
                            Image("Gold")
                                .resizable()
                                .frame(width: MenuViewSize.saveSlotImageSize, height: MenuViewSize.saveSlotImageSize)
                        }
                    }
                    HStack {
                        if life != nil {
                            TextParagraph("x \(life!)")
                            Image("Life")
                                .resizable()
                                .frame(width: MenuViewSize.saveSlotImageSize, height: MenuViewSize.saveSlotImageSize)
                        }
                    }
                    
                    Spacer()
                    
                    if progress != nil {
                        ZStack {
                            CircleProgressView(progress: progress!)
                            TextParagraph("\(Int(progress!))")
                        }
                        
                    } else {
                        TextParagraph("Press to start")
                    }
                }
                .frame(width: MenuViewSize.saveSlotWidth, height: MenuViewSize.saveSlotHeight)
                .padding(30)
                .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))).cornerRadius(15)
            })
        }
        
        struct CircleProgressView: View {
            let progress: Double
            let lineWidth: CGFloat = 5
            
            var body: some View {
                ZStack {
                    Circle()
                        .stroke(
                            Color.white.opacity(0.5),
                            lineWidth: lineWidth
                        )
                    Circle()
                        // 2
                        .trim(from: 0, to: progress / 100)
                        .stroke(
                            Color.white,
                            style: StrokeStyle(
                                lineWidth: lineWidth,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                }.frame(width: 50, height: 50)
            }
        }
    }
}

struct MainMenuConfigView: View {
    @EnvironmentObject var mainMenuViewModel: MainMenuViewModel
    @EnvironmentObject var adventureViewModel: AdventureViewModel
    @State var currentGameStyle: GameStyle = .edh
    @State var currentNumberOfPlayer: Int = 1
    @State var currentDifficulty: Int = 0
    
    var body: some View {
        VStack(spacing: 40) {
            TextTitle("Configuration")
            Spacer()
            Group {
                HStack {
                    TextParagraph("Number of player")
                    NumberOfPlayerConfigView(numberOfPlayer: 1, currentnumberOfPlayer: $currentNumberOfPlayer)
                    NumberOfPlayerConfigView(numberOfPlayer: 2, currentnumberOfPlayer: $currentNumberOfPlayer)
                    NumberOfPlayerConfigView(numberOfPlayer: 3, currentnumberOfPlayer: $currentNumberOfPlayer)
                    Spacer()
                }
            }
            Group {
                HStack {
                    Spacer()
                    GameStyleConfigView(gameStyle: .edh, currentGameStyle: $currentGameStyle)
                    GameStyleConfigView(gameStyle: .classic, currentGameStyle: $currentGameStyle)
                    Spacer()
                }
                TextParagraph(currentGameStyle.getParagraph(numberOfPlayer: currentNumberOfPlayer))
            }
            Group {
                HStack {
                    TextParagraph("Difficulty")
                    DifficultyConfigView(difficulty: 0, currentDifficulty: $currentDifficulty)
                    DifficultyConfigView(difficulty: 1, currentDifficulty: $currentDifficulty)
                    Spacer()
                }
                TextParagraph("Increase the diffuiculty if your find the game too easy")
            }
            Spacer()
            Button(action: {
                withAnimation(.easeInOut(duration: AnimationsDuration.long)) {
                    mainMenuViewModel.hideMenu = true
                    mainMenuViewModel.createNewSave(numberOfPlayer: currentNumberOfPlayer, gameStyle: currentGameStyle, difficulty: currentDifficulty)
                    adventureViewModel.loadSave(saveNumber: mainMenuViewModel.saveSelected)
                }
            }, label: {
                TextSubTitle("Press here to start")
            })
        }.padding(MenuViewSize.mainMenuPadding).frame(width: MenuViewSize.mainMenuWidth)
    }
    
    struct GameStyleConfigView: View {
        let gameStyle: GameStyle
        @Binding var currentGameStyle: GameStyle
        
        var isSelected: Bool {
            return gameStyle == currentGameStyle
        }
        
        var body: some View {
            Button(action: {
                withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                    currentGameStyle = gameStyle
                }
            }, label: {
                TextSubTitle(gameStyle.getTitle(), color: isSelected ? .white : .gray)
                    .scaleEffect(isSelected ? 1 : 0.8)
            }).frame(width: 150, height: 60)
        }
    }
    
    struct NumberOfPlayerConfigView: View {
        let numberOfPlayer: Int
        @Binding var currentnumberOfPlayer: Int
        
        var isSelected: Bool {
            return numberOfPlayer == currentnumberOfPlayer
        }
        
        var body: some View {
            Button(action: {
                withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                    currentnumberOfPlayer = numberOfPlayer
                }
            }, label: {
                TextSubTitle("\(numberOfPlayer)", color: isSelected ? .white : .gray)
                    .scaleEffect(isSelected ? 1 : 0.8)
            }).frame(width: 40, height: 60)
        }
    }
    
    struct DifficultyConfigView: View {
        let difficulty: Int
        @Binding var currentDifficulty: Int
        
        var isSelected: Bool {
            return difficulty == currentDifficulty
        }
        
        var difficultyTitle: String {
            if difficulty == 0 {
                return "Normal"
            }
            return "Hard"
        }
        
        var body: some View {
            Button(action: {
                withAnimation(.easeInOut(duration: AnimationsDuration.short)) {
                    currentDifficulty = difficulty
                }
            }, label: {
                TextSubTitle(difficultyTitle, color: isSelected ? .white : .gray)
                    .scaleEffect(isSelected ? 1 : 0.8)
            }).frame(width: 100, height: 60)
        }
    }
}

enum GameStyle {
    case edh
    case classic
    
    func getTitle() -> String {
        switch self {
        case .edh:
            return "EDH"
        case .classic:
            return "Classic"
        }
    }
    
    func getParagraph(numberOfPlayer: Int) -> String {
        switch self {
        case .edh:
            return "Requirements: \(6 * numberOfPlayer) boosters and a pile of random commanders\n\nEach players draw 2 random commanders. Draft the boosters between the \(numberOfPlayer). Each player discard one of the 2 random commanders and keep the other one."
        case .classic:
            return "Requirements: \(6 * numberOfPlayer) boosters\n\nDraft the boosters between the \(numberOfPlayer)."
        }
    }
}

struct MenuViewSize {
    static let mainMenuPadding: CGFloat = 60
    static let mainMenuWidth: CGFloat = UIScreen.main.bounds.width / 1.6
    static let saveSlotImageSize: CGFloat = 25
    static let saveSlotHeight: CGFloat = UIScreen.main.bounds.height / 4
    static let saveSlotWidth: CGFloat = UIScreen.main.bounds.width / 9
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            MainMenuView()
                .environmentObject(MainMenuViewModel())
                .environmentObject(AdventureViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            MainMenuView()
        }
    }
}