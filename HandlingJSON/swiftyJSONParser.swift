//
//  swiftyJSONParser.swift
//  HandlingJSON
//
//  Created by Irem Karaoglu on 1.03.2022.
//

import Foundation
import SwiftyJSON

// Get name of the Pokemon
func getName(data: Data) {
    if let json = try? JSON(data: data) {
        let name = json["name"].string ?? "N/A"
        print("Name: \(name)")
    }
}

// Get abilities of the Pokemon
func getAbilities(data: Data) {
    if let json = try? JSON(data: data) {
        for (_, abilities) in json["abilities"] {
            let ability = abilities["ability"]["name"].string ?? "N/A"
            print("Ability: \(ability)")
        }
    }
}

// Get type of the Pokemon
func getType(data: Data) {
    if let json = try? JSON(data: data) {
        for (_, types) in json["types"] {
            let type = types["type"]["name"].string ?? "N/A"
            print("Type: \(type)")
        }
    }
}
