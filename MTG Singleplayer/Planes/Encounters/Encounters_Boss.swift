//
//  EncountersBoss.swift
//  MTG Singleplayer
//
//  Created by Loic D on 12/08/2022.
//

import Foundation

extension Encounters {
    
    static let introEncounter = Encounter(title: "Once upon a time", id: "Intro", artistName: "Alix Branwyn",
                                          choices: [
                                              EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.planeEnd)
                                          ])
    
    static let victoryEncounter = Encounter(title: "Victory", id: "Victory", artistName: "Johannes Voss",
                                          choices: [
                                              EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.returnToMenu)
                                          ])
    
    static let defeatEncounter = Encounter(title: "Defeat", id: "Defeat", artistName: "Johann Bodin",
                                          choices: [
                                              EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.returnToMenu)
                                          ])
    
    static let bosses =
    [
        "Boss_Garruk": Encounter(title: "The end", id: "Boss_Garruk", artistName: "Chase Stone",
                                    choices: [
                                        EncounterChoice(title: EncounterChoice.defaultTitle, encounterId: EncounterChoice.victory, deckToFight: "Boss_Garruk")
                                    ]),
    ]
    
    static let bosses_shop = Encounter(title: "One last stop", id: "Boss_Shop", artistName: "Jonas de Ro",
                                       offer: [.gold(10, .life(1), .repeatable), .gold(45, .booster, .repeatable)],
                                       choices: [
                                           EncounterChoice(title: EncounterChoice.planeEnd, encounterId: EncounterChoice.planeEnd)
                                       ])
}
