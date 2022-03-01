//
//  JSONDecoderParser.swift
//  HandlingJSON
//
//  Created by Irem Karaoglu on 1.03.2022.
//

import Foundation


struct Charmander: Codable {
    let name: String
    let abilities: [AbilityList]
    let types: [TypeElement]
}

struct AbilityList: Codable {
    let ability: Ability
    //    Crash case:
    //    let isHidden: Bool
    let slot: Int
}

struct Ability: Codable {
    let name: String
    let url: String
}

struct TypeElement: Codable {
    let slot: Int
    let type: Ability
}

func parseJSON(pokemonData: Data) -> Charmander? {
    let decoder = JSONDecoder()
    
    do {
        let decodedData = try decoder.decode(Charmander.self, from: pokemonData)
        return decodedData
    } catch {
        print(error)
    }
    return nil
}
