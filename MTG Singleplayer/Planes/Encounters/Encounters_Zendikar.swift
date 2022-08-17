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
        /*
        "Zendikar_": Encounter(title: "AAA", id: "AAA", artistName: "AAAA",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "AAAAA")
                                    ]),
        */
        "Zendikar_Mushrooms_Intro": Encounter(title: "AAA", id: "Zendikar_Mushrooms_Intro", artistName: "Nicholas Gregory",
                                    choices: [
                                        EncounterChoice(title: "Follow his plan and go for mushrooms", encounterId: "Zendikar_Mushrooms_Fight"),
                                        EncounterChoice(title: "Ignore him and continue", encounterId: "Zendikar_Mushrooms_Beast_Fight")
                                    ]),
        
        "Zendikar_Old_House_Intro": Encounter(title: "AAA", id: "Zendikar_Old_House_Intro", artistName: "Lucas Staniec",
                                    choices: [
                                        EncounterChoice(title: "Enter the house", encounterId: "Zendikar_Old_House"),
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Jerboa_Intro": Encounter(title: "A wild jerboa", id: "Zendikar_Jerboa_Intro", artistName: "Antonio José Manzanedo",
                                    choices: [
                                        EncounterChoice(title: "Pet the cute little jerboa", encounterId: "Zendikar_Jerboa_Success"),
                                        EncounterChoice(title: "Ignore the jerboa", encounterId: "Zendikar_Jerboa")
                                    ]),
        
    ]
    
    static let plane_zendikar_double = [
        
        "Zendikar_Forest_Shortcut_Intro": Encounter(title: "AAA", id: "Zendikar_Forest_Shortcut_Intro", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Forest_Shortcut_Fight_01")
                                    ]),

        "Zendikar_Branches_Intro": Encounter(title: "AAA", id: "Zendikar_Branches_Intro", artistName: "Andreas Rocha",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Branches_Insect")
                                    ]),
    ]
    
    static let plane_zendikar_ending = [

        "Zendikar_Silundi_Intro": Encounter(title: "AAA", id: "Zendikar_Silundi_Intro", artistName: "Randy Vargas",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Silundi_Crab")
                                    ]),
        
        "Zendikar_Valakut_Intro": Encounter(title: "AAA", id: "Zendikar_Valakut_Intro", artistName: "Campbell White",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Valakut_Fight_01")
                                    ]),
        
    ]
    
    static let plane_zendikar_direct = [
        
        "Zendikar_Intro": Encounter(title: "Zendikar", id: "Zendikar_Intro", artistName: "Aleksi Briclot",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: [EncounterChoice.randomEncounter, EncounterChoice.randomEncounter, "Zendikar_Plains_Intro", "Zendikar_Adventure_Hub"])
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
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Progress", deckToFight: "Zendikar_Ondu_Kor")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Progress": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Progress", artistName: "Denman Rooke",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Angel_Attack_01")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Attack_01": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Angel_Attack_01", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: "Fight", encounterId: "Zendikar_Adventure_Ondu_Angel_Success", deckToFight: "Zendikar_Ondu_Angel"),
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
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Ruins_Entry", deckToFight: "Zendikar_Ondu_Angel")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Ruins_Entry": Encounter(title: "Approcahing the ruins", id: "Zendikar_Adventure_Ondu_Ruins_Entry", artistName: "Chase Stone",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Boss")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Boss": Encounter(title: "AAA", id: "Zendikar_Adventure_Ondu_Boss", artistName: "Ryan Pancoast",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Ondu_Boss")
                                    ]),
        
        // MARK: Plains
        
        "Zendikar_Plains_Intro": Encounter(title: "AAA", id: "Zendikar_Plains_Intro", artistName: "Grady Frederick",
                                    choices: [
                                        EncounterChoice(title: "Climb the rocky path", encounterId: "Zendikar_Plains_Fight_01"),
                                        EncounterChoice(title: "Stay in the plains", encounterId: "Zendikar_Plains_Fight_02")
                                    ]),
        
        "Zendikar_Plains_Fight_01": Encounter(title: "AAA", id: "Zendikar_Plains_Fight_01", artistName: "Ilse Gort",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Progress_01", deckToFight: "Zendikar_Ox")
                                    ]),
        
        "Zendikar_Plains_Fight_02": Encounter(title: "AAA", id: "Zendikar_Plains_Fight_02", artistName: "Ilse Gort",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Progress_01", deckToFight: "Zendikar_Plains_Cat")
                                    ]),
        
        "Zendikar_Plains_Progress_01": Encounter(title: "AAA", id: "Zendikar_Plains_Progress_01", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Fight_03")
                                    ]),
        
        "Zendikar_Plains_Fight_03": Encounter(title: "AAA", id: "Zendikar_Plains_Fight_03", artistName: "Jesper Ejsing",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Progress_02", deckToFight: "Zendikar_Plains_Bird")
                                    ]),
        
        "Zendikar_Plains_Progress_02": Encounter(title: "AAA", id: "Zendikar_Plains_Progress_02", artistName: "Johan Grenier",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Boss")
                                    ]),
        
        "Zendikar_Plains_Boss": Encounter(title: "AAA", id: "Zendikar_Plains_Boss", artistName: "G-host Lee",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Plains_Boss")
                                    ]),
        
        // MARK: Mushrooms
        
        "Zendikar_Mushrooms_Fight": Encounter(title: "AAA", id: "Zendikar_Mushrooms_Fight", artistName: "Nicholas Gregory",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Mushrooms_Beast_Calm", deckToFight: "Zendikar_Fungus")
                                    ]),
        
        "Zendikar_Mushrooms_Beast_Calm": Encounter(title: "AAA", id: "Zendikar_Mushrooms_Beast_Calm", artistName: "Grzegorz Rutkowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Mushrooms_Beast_Fight": Encounter(title: "AAA", id: "Zendikar_Mushrooms_Beast_Fight", artistName: "Grzegorz Rutkowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Beast")
                                    ]),
        
        // MARK: Old house
        
        "Zendikar_Old_House": Encounter(title: "AAA", id: "Zendikar_Old_House", artistName: "Lucas Staniec",
                                    reward: [.life(1)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Silundi
        
        "Zendikar_Silundi_Crab": Encounter(title: "AAA", id: "Zendikar_Silundi_Crab", artistName: "Simon Dominic",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Silundi_Entrance", deckToFight: "Zendikar_Crab")
                                    ]),
        
        "Zendikar_Silundi_Entrance": Encounter(title: "AAA", id: "Zendikar_Silundi_Entrance", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Silundi_Boss")
                                    ]),
        
        "Zendikar_Silundi_Boss": Encounter(title: "AAA", id: "Zendikar_Silundi_Boss", artistName: "Svetlin Velinov",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Silundi_End", deckToFight: "Zendikar_Silundi_Boss")
                                    ]),
        
        "Zendikar_Silundi_End": Encounter(title: "AAA", id: "Zendikar_Silundi_End", artistName: "Bryan Sola",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.planeEnd)
                                    ]),
        
        // MARK: Branches
        
        "Zendikar_Branches_Insect": Encounter(title: "AAA", id: "Zendikar_Branches_Insect", artistName: "Simon Dominic",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Branches_Progress", deckToFight: "Zendikar_Branches_Insect")
                                    ]),
        
        "Zendikar_Branches_Progress": Encounter(title: "AAA", id: "Zendikar_Branches_Progress", artistName: "Titus Lunter",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Branches_Boss")
                                    ]),
        
        "Zendikar_Branches_Boss": Encounter(title: "AAA", id: "Zendikar_Branches_Boss", artistName: "Victor Adame Minguez",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Branches_02")
                                    ]),
        
        // MARK: Valakut
        
        "Zendikar_Valakut_Fight_01": Encounter(title: "AAA", id: "Zendikar_Valakut_Fight_01", artistName: "Billy Christian",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Valakut_Forge_01", deckToFight: "Zendikar_Valakut_01")
                                    ]),
        
        "Zendikar_Valakut_Forge_01": Encounter(title: "AAA", id: "Zendikar_Valakut_Forge_01", artistName: "Campbell White",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Valakut_Fight_02")
                                    ]),
        
        "Zendikar_Valakut_Fight_02": Encounter(title: "AAA", id: "Zendikar_Valakut_Fight_02", artistName: "Bryan Sola",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Valakut_Forge_02", deckToFight: "Zendikar_Valakut_02")
                                    ]),
        
        "Zendikar_Valakut_Forge_02": Encounter(title: "AAA", id: "Zendikar_Valakut_Forge_02", artistName: "Campbell White",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.planeEnd)
                                    ]),
        
        // MARK: Forest Shortcut
        
        "Zendikar_Forest_Shortcut_Fight_01": Encounter(title: "AAA", id: "Zendikar_Forest_Shortcut_Fight_01", artistName: "Grzegorz Rutkowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Forest_Shortcut_Progress", deckToFight: "Zendikar_Forest_Shortcut_01")
                                    ]),
        
        "Zendikar_Forest_Shortcut_Progress": Encounter(title: "AAA", id: "Zendikar_Forest_Shortcut_Progress", artistName: "Cristi Balanescu",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Forest_Shortcut_Fight_02")
                                    ]),
        
        "Zendikar_Forest_Shortcut_Fight_02": Encounter(title: "AAA", id: "Zendikar_Forest_Shortcut_Fight_02", artistName: "Simon Dominic",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Forest_Shortcut_02")
                                    ]),
        
        // MARK: Jerboa
        
        "Zendikar_Jerboa_Success": Encounter(title: "AAA", id: "Zendikar_Jerboa_Success", artistName: "Dominik Mayer",
                                    choices: [
                                        EncounterChoice(title: "Ignore the jerboa", encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Jerboa": Encounter(title: "AAA", id: "Zendikar_Jerboa", artistName: "Tomasz Jedruszek",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Jerboa_Fight")
                                    ]),
        
        "Zendikar_Jerboa_Fight": Encounter(title: "AAA", id: "Zendikar_Jerboa_Fight", artistName: "Rudy Siswanto",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Minotaur")
                                    ]),
    ]
}
