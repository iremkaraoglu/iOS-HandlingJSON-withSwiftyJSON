//
//  main.swift
//  HandlingJSON
//
//  Created by Irem Karaoglu on 16.01.2022.
//

import Foundation

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
                    print(error!)
                    group.leave()
                    return
                }
                
                if let safeData = data {
                    // Call functions with JSONDecoder
                    print("Outputs with JSONDecoder")
                    let charmander = parseJSON(pokemonData: safeData)!
                    getName(data: charmander)
                    getAbilities(data: charmander)
                    getType(data: charmander)
                    
                    // Call functions with SwiftyJSON
                    print("Outputs with SwiftyJSON")
                    getName(data: safeData)
                    getAbilities(data: safeData)
                    getType(data: safeData)
                }
                
                group.leave()
            }
            
            task.resume()
            
        } else{
            group.leave()
            
        }
    }
    
}



