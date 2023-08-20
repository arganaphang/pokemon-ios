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
                case .idle, .loading:
                    LazyVGrid(columns: layout, spacing: 20) {
                        ForEach(0..<10) { _ in
                            PokemonCardSkeleton()
                        }
                    }.padding(.horizontal, 10)
                case let .failed(error):
                    Text(error.localizedDescription)
                case let .loaded(pokemons):
                    LazyVGrid(columns: layout, spacing: 20) {
                        ForEach(pokemons) { pokemon in
                            NavigationLink(destination: DetailScreen(pokemon: pokemon)) {
                                PokemonCard(pokemon: pokemon)
                            }
                        }
                    }.padding(.horizontal, 10)
                }
            }
            .searchable(text: $homeVM.search, prompt: "Search pokemon")
            .onChange(of: homeVM.search) { searchText in
                homeVM.search(text: searchText)
            }
            .navigationTitle("Pokemon List")
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
