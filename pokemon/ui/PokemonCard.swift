//
//  PokemonCard.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import SwiftUI
import Kingfisher

struct PokemonCard: View {
    let pokemon: Pokemon
    var body: some View {
        VStack {
            KFImage(pokemon.imageUrl)
                .resizable()
                .frame(width: 50, height: 50)
            Spacer(minLength: 12)
            Text(pokemon.name.capitalized)
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
        .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80)
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(pokemon.color)
        .cornerRadius(8.0)
        .shadow(color: pokemon.color, radius:24, x: 0, y: 4)
        .padding(.horizontal, 8)
    }
}

struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCard(pokemon: Pokemon(id: 1, name: "bulbasaur", height: 69, weight: 69, stats: [], types: ["grass", "poison"]))
            .previewLayout(.sizeThatFits)
            .frame(width: 160, height: 90)
            .padding()
    }
}
