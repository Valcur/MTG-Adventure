//
//  Encounters.swift
//  MTG Singleplayer
//
//  Created by Loic D on 31/08/2022.
//

import Foundation

class Encounters {
    
    static func getArrayForPlane(_ planeName: String, array: PlaneEncounterArray) -> [String:Encounter] {
        switch(planeName) {
        case "Kamigawa":
            switch(array) {
            case .singleEncounter:
                return plane_kamigawa
            case .doubleEncounter:
                return plane_kamigawa_double
            case .endingEncounter:
                return plane_kamigawa_ending
            case .directEncounter:
                return plane_kamigawa_direct
            }
        case "Zendikar":
            switch(array) {
            case .singleEncounter:
                return plane_zendikar
            case .doubleEncounter:
                return plane_zendikar_double
            case .endingEncounter:
                return plane_zendikar_ending
            case .directEncounter:
                return plane_zendikar_direct
            }
        default:
            return bosses
        }
    }
    
    static func getEncounter(encounterId: String, planeName: String) -> Encounter? {
        var encounterArray = getArrayForPlane(planeName, array: .singleEncounter)
        var encounter = searchForPlaneInArray(encounterId: encounterId, array: encounterArray)
        if encounter != nil {
            return encounter
        }
        
        encounterArray = getArrayForPlane(planeName, array: .doubleEncounter)
        encounter = searchForPlaneInArray(encounterId: encounterId, array: encounterArray)
        if encounter != nil {
            return encounter
        }
        
        encounterArray = getArrayForPlane(planeName, array: .endingEncounter)
        encounter = searchForPlaneInArray(encounterId: encounterId, array: encounterArray)
        if encounter != nil {
            return encounter
        }
        
        encounterArray = getArrayForPlane(planeName, array: .directEncounter)
        encounter = searchForPlaneInArray(encounterId: encounterId, array: encounterArray)
        if encounter != nil {
            return encounter
        }
        
        encounterArray = bosses
        encounter = searchForPlaneInArray(encounterId: encounterId, array: encounterArray)
        if encounter != nil {
            return encounter
        }
        
        if encounterId == "Intro" {
            return introEncounter
        }
        
        if encounterId == "Victory" {
            return victoryEncounter
        }
        
        if encounterId == "Defeat" {
            return defeatEncounter
        }
        
        if encounterId == "Boss_Shop" {
            return bosses_shop
        }
        
        return nil
    }
    
    static private func searchForPlaneInArray(encounterId: String, array: [String:Encounter]) -> Encounter? {
        return array[encounterId]
    }
    
    enum PlaneEncounterArray {
        case singleEncounter
        case doubleEncounter
        case endingEncounter
        case directEncounter
    }
}
