//
//  PokemonManager.swift
//  who is that pokemon
//
//  Created by Andrea Stefanny Garcia Mejia on 19/01/23.
//

import Foundation

protocol PokemonManagerDelegate{
    func didUpdatePokemon(pokemons:[PokemonModel])
    func didFailWithError(error:Error)
}



struct PokemonManager{
    let pokemonUrl: String = "https://pokeapi.co/api/v2/pokemon?limit=898"
    var delegate: PokemonManagerDelegate?
    
    func fetchManager(){
    pokemonRequest(with: pokemonUrl)
    }
   
    private func pokemonRequest ( with urlString: String){
        //1.create url
        if let url = URL(string: urlString){
            //2. create url session
            let session = URLSession(configuration: .default)
            //3. give the session a task
            let task = session.dataTask(with: url){data,response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data{
                    if let pokemon = self.parseJSON(pokemonData: safeData ){
                        self.delegate?.didUpdatePokemon(pokemons: pokemon)
                    }
                }
            }
            // 4. start task
            task.resume()
        }
    }
    
    private func parseJSON(pokemonData: Data) -> [PokemonModel]?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map{
                PokemonModel(name: $0.name ?? " ", imageUrl: $0.url ?? " ")
            }
            return pokemon
        }catch{
            return nil
        }
    }
}
