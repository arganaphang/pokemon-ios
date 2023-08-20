//
//  HomeScreen.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var homeVM = HomeViewModel()
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                switch homeVM.state {
                case .idle:
                    Text("Error").frame(minHeight: 240)
                case .loading:
                    LazyVGrid(columns: layout, spacing: 20) {
                        ForEach(0..<10) { _ in
                            PokemonCardSkeleton()
                        }
                    }.padding(.horizontal, 24)
                    
                case let .failed(error):
                    Text(error.localizedDescription)
                case let .loaded(pokemons):
                    LazyVGrid(columns: layout, spacing: 20) {
                        ForEach(pokemons) { pokemon in
                            NavigationLink(destination: DetailScreen(pokemon: pokemon)) {
                                PokemonCard(pokemon: pokemon)
                            }
                        }
                    }.padding(.horizontal, 24)
                }
            }.navigationTitle("Pokemon List")
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
