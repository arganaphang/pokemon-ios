//
//  HomeViewModel.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published private(set) var state = ViewState<[Pokemon]>.idle
    @Published var search = ""
    
    init() {
        state = .loading
        Task.init {
            do {
                let pokemons = try await PokemonService().getPokemons()
                DispatchQueue.main.async {
                    self.state = .loaded(pokemons)
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .failed(error)
                }
            }
        }
    }
    
    // TODO: Make new Request to PokeAPI with debounce
    func search(text: String) {
        debugPrint(text)
    }
}
