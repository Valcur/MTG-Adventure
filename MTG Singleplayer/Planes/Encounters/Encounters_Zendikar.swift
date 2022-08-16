//
//  Encounters_Zendikar.swift
//  MTG Singleplayer
//
//  Created by Loic D on 14/08/2022.
//

import Foundation

// All encounters
extension Encounters {
    
    static let plane_zendikar = [
        "Zendikar_": Encounter(title: "AAA", id: "AAA", artistName: "AAAA",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "AAAAA")
                                    ]),
    ]
    
    static let plane_zendikar_double = [
        

    ]
    
    static let plane_zendikar_ending = [


    ]
    
    static let plane_zendikar_direct = [
        
        "Zendikar_Intro": Encounter(title: "Zendikar", id: "Zendikar_Intro", artistName: "Cristi Balanescu",
                                    choices: [
                                        EncounterChoice(title: "Fight", encounterId: EncounterChoice.randomEncounter, deckToFight: "Kamigawa_Shrine"),//Kamigawa_Shrine //Kamigawa_Swamp
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Shop": Encounter(title: "Shop", id: "Zendikar_Shop", artistName: "Philip Straub",
                                    offer: [.gold(45, .booster, .repeatable)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Adventure Ondu
        
        "Zendikar_Adventure_Hub": Encounter(title: "AAA", id: "Zendikar_Adventure_Hub", artistName: "Billy Christian",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Intro")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Intro": Encounter(title: "Ondu", id: "Zendikar_Adventure_Ondu_Intro", artistName: "Sam Burley",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Kor_Attack")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Kor_Attack": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Kor_Attack", artistName: "Ekaterina Burmak",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Progress")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Progress": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Progress", artistName: "Denman Rooke",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Angel_Attack_01")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Attack_01": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Angel_Attack_01", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: "Fight", encounterId: "Zendikar_Adventure_Ondu_Angel_Success"),
                                        EncounterChoice(title: "Run", encounterId: "Zendikar_Adventure_Ondu_Angel_Run")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Success": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Angel_Success", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Ruins_Entry")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Run": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Angel_Run", artistName: "James Paick",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Angel_Attack_02")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Attack_02": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Angel_Attack_02", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Ruins_Entry")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Ruins_Entry": Encounter(title: "Approcahing the ruins", id: "Zendikar_Adventure_Ondu_Ruins_Entry", artistName: "Chase Stone",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Boss")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Boss": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Boss", artistName: "Ryan Pancoast",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Plains
        
        "Zendikar_Plains_Intro": Encounter(title: "AAA", id: "Zendikar_Plains_Intro", artistName: "Grady Frederick",
                                    choices: [
                                        EncounterChoice(title: "Climb the rocky path", encounterId: "Zendikar_Plains_Fight_01"),
                                        EncounterChoice(title: "Stay in the plains", encounterId: "Zendikar_Plains_Fight_02")
                                    ]),
        
        "Zendikar_Plains_Fight_01": Encounter(title: "AAA", id: "Zendikar_Plains_Fight_01", artistName: "Ilse Gort",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Progress_01")
                                    ]),
        
        "Zendikar_Plains_Fight_02": Encounter(title: "AAA", id: "Zendikar_Plains_Fight_02", artistName: "Ilse Gort",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Progress_01")
                                    ]),
        
        "Zendikar_Plains_Progress_01": Encounter(title: "AAA", id: "Zendikar_Plains_Progress_01", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Fight_03")
                                    ]),
        
        "Zendikar_Plains_Fight_03": Encounter(title: "AAA", id: "Zendikar_Plains_Fight_03", artistName: "Jesper Ejsing",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Progress_02")
                                    ]),
        
        "Zendikar_Plains_Progress_02": Encounter(title: "AAA", id: "Zendikar_Plains_Progress_02", artistName: "Johan Grenier",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Boss")
                                    ]),
        
        "Zendikar_Plains_Boss": Encounter(title: "AAA", id: "Zendikar_Plains_Boss", artistName: "G-host Lee",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Mushrooms
        
        "Zendikar_Mushrooms_Intro": Encounter(title: "AAA", id: "Zendikar_Mushrooms_Intro", artistName: "Nicholas Gregory",
                                    choices: [
                                        EncounterChoice(title: "Follow his plan and go for mushrooms", encounterId: "Zendikar_Mushrooms_Fight"),
                                        EncounterChoice(title: "Ignore him and continue", encounterId: "Zendikar_Mushrooms_Beast_Fight")
                                    ]),
        
        "Zendikar_Mushrooms_Fight": Encounter(title: "AAA", id: "Zendikar_Mushrooms_Fight", artistName: "Nicholas Gregory",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Mushrooms_Beast_Calm")
                                    ]),
        
        "Zendikar_Mushrooms_Beast_Calm": Encounter(title: "AAA", id: "Zendikar_Mushrooms_Beast_Calm", artistName: "Grzegorz Rutkowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Mushrooms_Beast_Fight": Encounter(title: "AAA", id: "Zendikar_Mushrooms_Beast_Fight", artistName: "Grzegorz Rutkowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Old house
        
        "Zendikar_Old_House_Intro": Encounter(title: "AAA", id: "Zendikar_Old_House_Intro", artistName: "Lucas Staniec",
                                    choices: [
                                        EncounterChoice(title: "Enter the house", encounterId: "Zendikar_Old_House"),
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Old_House": Encounter(title: "AAA", id: "Zendikar_Old_House", artistName: "Lucas Staniec",
                                    reward: [.life(1)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
    ]
}
