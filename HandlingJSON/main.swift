//
//  main.swift
//  HandlingJSON
//
//  Created by Irem Karaoglu on 16.01.2022.
//

import Foundation
import SwiftyJSON

let pokemon = PokemonManager()
pokemon.fetchData()

struct PokemonManager {
    
    let charmanderURL = "https://pokeapi.co/api/v2/pokemon/charmander"
    let group = DispatchGroup()
    
    
    func fetchData() {
        performRequest(urlsString: charmanderURL)
        group.wait()
    }
    
    func performRequest(urlsString: String) {
        group.enter()
        if let url = URL(string: urlsString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                
                if error != nil {
                    // if there is an error we return early so we need to notify our task is complete
                    print(error!)
                    group.leave()
                    return
                }
                
                if let safeData = data {
                    // Call functions with JSONDecoder
                    print("Outputs with JSONDecoder")
                    let charmander = parseJSON(pokemonData: safeData)!
                    print("Name: \(charmander.name)")
                    print("Ability: \(charmander.abilities)")
                    print("Type: \(charmander.types)")
                    
                    // Call functions with SwiftyJSON
                    print("Outputs with SwiftyJSON")
                    getName(data: safeData)
                    getAbilities(data: safeData)
                    getType(data: safeData)
                }
                // notify that task is complete
                group.leave()
                
                
            }
            // don't forget to start the task
            task.resume()
        }else{
            group.leave()
            
        }
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
    
    //MARK: - Handle with SwiftyJSON
    // Get name of the Pokemon with SwiftyJSON
    func getName(data: Data) {
        let json = try! JSON(data: data)
        let name = json["name"].string ?? "N/A"
        print("Name: \(name)")
    }
    
    // Get abilities of the Pokemon with SwiftyJSON
    func getAbilities(data: Data) {
        let json = try! JSON(data: data)
        for (_, abilities) in json["abilities"] {
            let ability = abilities["ability"]["name"].string ?? "N/A"
            print("Ability: \(ability)")
        }
    }
    
    // Get type of the Pokemon with SwiftyJSON
    func getType(data: Data) {
        let json = try! JSON(data: data)
        for (_, types) in json["types"] {
            let type = types["type"]["name"].string ?? "N/A"
            print("Type: \(type)")
        }
    }
    
    
    
}


struct Charmander: Codable {
    let name: String
    let abilities: [AbilityList]
    let types: [TypeElement]
}

// MARK: - AbilityList
struct AbilityList: Codable {
    let ability: Ability
//    Crash case:
//    let isHidden: Bool
    let slot: Int
}

// MARK: - Ability
struct Ability: Codable {
    let name: String
    let url: String
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Ability
}
