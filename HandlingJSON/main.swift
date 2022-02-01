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
                    // it there is an error we return early so we need to notify our task is complete
                    print(error!)
                    group.leave()
                    return
                }
                
                if let safeData = data {
                    print("safeData", safeData)
                    if let result = self.parseJSON(pokemonData: safeData) {
                        print(result.name)
                    }
                }
                // notify that task is complete
                group.leave()
                
                
            }
            // dont forget to start the task
            task.resume()
        }else{
            group.leave()
            
        }
    }
    
    func parseJSON(pokemonData: Data) -> Charmander? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Charmander.self, from: pokemonData)
            print("decodedData", decodedData)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
    
}


struct Charmander: Codable {
    let name: String
}
