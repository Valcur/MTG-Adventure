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
        "Zendikar_Mushrooms_Intro": Encounter(title: "Forest", id: "Zendikar_Mushrooms_Intro", artistName: "Nicholas Gregory",
                                    choices: [
                                        EncounterChoice(title: "Follow his plan and go for mushrooms", encounterId: "Zendikar_Mushrooms_Fight"),
                                        EncounterChoice(title: "Ignore him and continue", encounterId: "Zendikar_Mushrooms_Beast_Fight")
                                    ]),
        
        "Zendikar_Old_House_Intro": Encounter(title: "Forest", id: "Zendikar_Old_House_Intro", artistName: "Lucas Staniec",
                                    choices: [
                                        EncounterChoice(title: "Enter the house", encounterId: "Zendikar_Old_House"),
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Jerboa_Intro": Encounter(title: "A furry friend", id: "Zendikar_Jerboa_Intro", artistName: "Antonio José Manzanedo",
                                    choices: [
                                        EncounterChoice(title: "Pet the cute little jerboa", encounterId: "Zendikar_Jerboa_Success"),
                                        EncounterChoice(title: "Ignore the jerboa", encounterId: "Zendikar_Jerboa")
                                    ]),
        
        "Zendikar_Spider_Intro": Encounter(title: "In the Web", id: "Zendikar_Spider_Intro", artistName: "Johannes Voss",
                                    choices: [
                                        EncounterChoice(title: "Prepare and wait for them", encounterId: "Zendikar_Spider_Prepare"),
                                        EncounterChoice(title: "Try to escape", encounterId: [EncounterChoice.randomEncounter, "Zendikar_Spider_Fight", "Zendikar_Spider_Fight"])
                                    ]),
        
    ]
    
    static let plane_zendikar_double = [
        
        "Zendikar_Forest_Shortcut_Intro": Encounter(title: "Forest", id: "Zendikar_Forest_Shortcut_Intro", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Forest_Shortcut_Fight_01")
                                    ]),

        "Zendikar_Branches_Intro": Encounter(title: "Forest", id: "Zendikar_Branches_Intro", artistName: "Andreas Rocha",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Branches_Insect")
                                    ]),
        
        "Zendikar_Plains_Intro": Encounter(title: "Plains", id: "Zendikar_Plains_Intro", artistName: "Grady Frederick",
                                    choices: [
                                        EncounterChoice(title: "Climb the rocky path", encounterId: "Zendikar_Plains_Fight_01"),
                                        EncounterChoice(title: "Stay in the plains", encounterId: "Zendikar_Plains_Fight_02")
                                    ]),
        
        "Zendikar_Vampire_Intro": Encounter(title: "Vampire", id: "Zendikar_Vampire_Intro", artistName: "Vance Kovacs",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Vampire_Fight_01")
                                    ]),
        
        "Zendikar_Goblin_Intro": Encounter(title: "Goblin", id: "Zendikar_Goblin_Intro", artistName: "Piotr Dura",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Goblin_Fight_01")
                                    ]),
    ]
    
    static let plane_zendikar_ending = [

        "Zendikar_Silundi_Intro": Encounter(title: "Silundi isle", id: "Zendikar_Silundi_Intro", artistName: "Randy Vargas",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Silundi_Crab")
                                    ]),
        
        "Zendikar_Valakut_Intro": Encounter(title: "Mount Valakut", id: "Zendikar_Valakut_Intro", artistName: "Campbell White",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Valakut_Fight_01")
                                    ]),
        
    ]
    
    static let plane_zendikar_direct = [
        
        "Zendikar_Intro": Encounter(title: "Zendikar", id: "Zendikar_Intro", artistName: "Tianhua X",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: [EncounterChoice.randomEncounter, EncounterChoice.randomEncounter, "Zendikar_Adventure_Hub"])
                                        //EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Vampire_Fight_01")
                                    ]),
        
        "Zendikar_Shop": Encounter(title: "Shop", id: "Zendikar_Shop", artistName: "Philip Straub",
                                    offer: [.gold(45, .booster, .repeatable)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Adventure Ondu
        
        "Zendikar_Adventure_Hub": Encounter(title: "Going on an adventure", id: "Zendikar_Adventure_Hub", artistName: "Billy Christian",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Intro")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Intro": Encounter(title: "Ondu", id: "Zendikar_Adventure_Ondu_Intro", artistName: "Sam Burley",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Kor_Attack")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Kor_Attack": Encounter(title: "Ondu", id: "Zendikar_Adventure_Ondu_Kor_Attack", artistName: "Ekaterina Burmak",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Progress", deckToFight: "Zendikar_Ondu_Kor")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Progress": Encounter(title: "Ondu", id: "Zendikar_Adventure_Ondu_Progress", artistName: "Denman Rooke",
                                    reward: [.life(1)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Angel_Attack_01")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Attack_01": Encounter(title: "Ondu", id: "Zendikar_Adventure_Ondu_Angel_Attack_01", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: "Fight", encounterId: "Zendikar_Adventure_Ondu_Angel_Success", deckToFight: "Zendikar_Ondu_Angel"),
                                        EncounterChoice(title: "Run", encounterId: "Zendikar_Adventure_Ondu_Angel_Run")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Success": Encounter(title: "Ondu", id: "Zendikar_Adventure_Ondu_Angel_Success", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Boss")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Run": Encounter(title: "Close escape", id: "Zendikar_Adventure_Ondu_Angel_Run", artistName: "James Paick",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Angel_Attack_02")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Angel_Attack_02": Encounter(title: "Ondu", id: "Zendikar_Adventure_Ondu_Angel_Attack_02", artistName: "Matt Stewart",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Boss", deckToFight: "Zendikar_Ondu_Angel")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Boss": Encounter(title: "Ondu", id: "Zendikar_Adventure_Ondu_Boss", artistName: "Ryan Pancoast",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Adventure_Ondu_Ruins", deckToFight: "Zendikar_Ondu_Boss")
                                    ]),
        
        "Zendikar_Adventure_Ondu_Ruins": Encounter(title: "Approcahing the ruins", id: "Zendikar_Adventure_Ondu_Ruins_Entry", artistName: "Chase Stone",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Plains
        
        "Zendikar_Plains_Fight_01": Encounter(title: "Plains", id: "Zendikar_Plains_Fight_01", artistName: "Ilse Gort",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Progress_01", deckToFight: "Zendikar_Ox")
                                    ]),
        
        "Zendikar_Plains_Fight_02": Encounter(title: "Plains", id: "Zendikar_Plains_Fight_02", artistName: "Ilse Gort",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Progress_01", deckToFight: "Zendikar_Plains_Cat")
                                    ]),
        
        "Zendikar_Plains_Progress_01": Encounter(title: "Mounting camp", id: "Zendikar_Plains_Progress_01", artistName: "Adam Paquette",
                                    reward: [.life(1)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Plains_Fight_03")
                                    ]),
        
        "Zendikar_Plains_Fight_03": Encounter(title: "Plains", id: "Zendikar_Plains_Fight_03", artistName: "Jesper Ejsing",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Plains_Bird")
                                    ]),
        
        // MARK: Mushrooms
        
        "Zendikar_Mushrooms_Fight": Encounter(title: "Forest", id: "Zendikar_Mushrooms_Fight", artistName: "Nicholas Gregory",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Mushrooms_Beast_Calm", deckToFight: "Zendikar_Fungus")
                                    ]),
        
        "Zendikar_Mushrooms_Beast_Calm": Encounter(title: "Picking mushrooms", id: "Zendikar_Mushrooms_Beast_Calm", artistName: "Grzegorz Rutkowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Mushrooms_Beast_Fight": Encounter(title: "Forest", id: "Zendikar_Mushrooms_Beast_Fight", artistName: "Grzegorz Rutkowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Beast")
                                    ]),
        
        // MARK: Old house
        
        "Zendikar_Old_House": Encounter(title: "Forest", id: "Zendikar_Old_House", artistName: "Lucas Staniec",
                                    reward: [.life(1)],
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        // MARK: Silundi
        
        "Zendikar_Silundi_Crab": Encounter(title: "Silundi isle", id: "Zendikar_Silundi_Crab", artistName: "Simon Dominic",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Silundi_Entrance", deckToFight: "Zendikar_Crab")
                                    ]),
        
        "Zendikar_Silundi_Entrance": Encounter(title: "Silundi isle", id: "Zendikar_Silundi_Entrance", artistName: "Adam Paquette",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Silundi_Boss")
                                    ]),
        
        "Zendikar_Silundi_Boss": Encounter(title: "Silundi isle", id: "Zendikar_Silundi_Boss", artistName: "Svetlin Velinov",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Silundi_End", deckToFight: "Zendikar_Silundi_Boss")
                                    ]),
        
        "Zendikar_Silundi_End": Encounter(title: "Silundi isle", id: "Zendikar_Silundi_End", artistName: "Bryan Sola",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.planeEnd)
                                    ]),
        
        // MARK: Branches
        
        "Zendikar_Branches_Insect": Encounter(title: "Forest", id: "Zendikar_Branches_Insect", artistName: "Simon Dominic",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Branches_Progress", deckToFight: "Zendikar_Branches_Insect")
                                    ]),
        
        "Zendikar_Branches_Progress": Encounter(title: "Forest", id: "Zendikar_Branches_Progress", artistName: "Titus Lunter",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Branches_Boss")
                                    ]),
        
        "Zendikar_Branches_Boss": Encounter(title: "Forest", id: "Zendikar_Branches_Boss", artistName: "Victor Adame Minguez",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Branches_02")
                                    ]),
        
        // MARK: Valakut
        
        "Zendikar_Valakut_Fight_01": Encounter(title: "Mount Valakut", id: "Zendikar_Valakut_Fight_01", artistName: "Billy Christian",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Valakut_Forge_01", deckToFight: "Zendikar_Valakut_01")
                                    ]),
        
        "Zendikar_Valakut_Forge_01": Encounter(title: "Mount Valakut", id: "Zendikar_Valakut_Forge_01", artistName: "Campbell White",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Valakut_Fight_02")
                                    ]),
        
        "Zendikar_Valakut_Fight_02": Encounter(title: "Mount Valakut", id: "Zendikar_Valakut_Fight_02", artistName: "Bryan Sola",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Valakut_Forge_02", deckToFight: "Zendikar_Valakut_02")
                                    ]),
        
        "Zendikar_Valakut_Forge_02": Encounter(title: "Mount Valakut", id: "Zendikar_Valakut_Forge_02", artistName: "Campbell White",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.planeEnd)
                                    ]),
        
        // MARK: Forest Shortcut
        
        "Zendikar_Forest_Shortcut_Fight_01": Encounter(title: "Forest", id: "Zendikar_Forest_Shortcut_Fight_01", artistName: "Grzegorz Rutkowski",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Forest_Shortcut_Progress", deckToFight: "Zendikar_Forest_Shortcut_01")
                                    ]),
        
        "Zendikar_Forest_Shortcut_Progress": Encounter(title: "Forest", id: "Zendikar_Forest_Shortcut_Progress", artistName: "Cristi Balanescu",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Forest_Shortcut_Fight_02")
                                    ]),
        
        "Zendikar_Forest_Shortcut_Fight_02": Encounter(title: "Forest", id: "Zendikar_Forest_Shortcut_Fight_02", artistName: "Simon Dominic",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Forest_Shortcut_02")
                                    ]),
        
        // MARK: Jerboa
        
        "Zendikar_Jerboa_Success": Encounter(title: "A furry friend", id: "Zendikar_Jerboa_Success", artistName: "Dominik Mayer",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
        
        "Zendikar_Jerboa": Encounter(title: "A furry friend", id: "Zendikar_Jerboa", artistName: "Tomasz Jedruszek",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Jerboa_Fight")
                                    ]),
        
        "Zendikar_Jerboa_Fight": Encounter(title: "A furry friend", id: "Zendikar_Jerboa_Fight", artistName: "Rudy Siswanto",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Minotaur")
                                    ]),
        
        // MARK: Spiders
        
        "Zendikar_Spider_Fight": Encounter(title: "In the Web", id: "Zendikar_Spider_Fight", artistName: "Brian Valeza",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Spider")
                                    ]),
        
        "Zendikar_Spider_Prepare": Encounter(title: "In the Web", id: "Zendikar_Spider_Prepare", artistName: "Brian Valeza",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Spider")
                                    ]),
        
        // MARK: Goblin
        
        "Zendikar_Goblin_Fight_01": Encounter(title: "Goblin", id: "Zendikar_Goblin_Fight_01", artistName: "Slawomir Maniak",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Goblin_Progress", deckToFight: "Zendikar_Goblin_01")
                                    ]),
        
        "Zendikar_Goblin_Progress": Encounter(title: "Goblin", id: "Zendikar_Goblin_Progress", artistName: "Andreas Rocha",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Goblin_Fight_02")
                                    ]),
        
        "Zendikar_Goblin_Fight_02": Encounter(title: "Goblin", id: "Zendikar_Goblin_Fight_02", artistName: "Kekai Kotaki",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter, deckToFight: "Zendikar_Goblin_02")
                                    ]),
        
        // MARK: Vampire
        
        "Zendikar_Vampire_Fight_01": Encounter(title: "Vampire", id: "Zendikar_Vampire_Fight_01", artistName: "Heonhwa Choe",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Vampire_Fight_02", deckToFight: "Zendikar_Vampire_01")
                                    ]),
        
        "Zendikar_Vampire_Fight_02": Encounter(title: "Vampire", id: "Zendikar_Vampire_Fight_02", artistName: "Caio Monteiro",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: "Zendikar_Vampire_End", deckToFight: "Zendikar_Vampire_02")
                                    ]),
        
        "Zendikar_Vampire_End": Encounter(title: "Vampire", id: "Zendikar_Vampire_End", artistName: "Titus Lunter",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.randomEncounter)
                                    ]),
    ]
}
