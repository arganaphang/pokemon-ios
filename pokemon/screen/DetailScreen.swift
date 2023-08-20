//
//  DetailScreen.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import SwiftUI
import Kingfisher

struct DetailScreen: View {
    let pokemon: Pokemon
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading) {
                    KFImage(pokemon.imageUrl)
                        .resizable()
                        .frame(width: geo.size.width-72, height: geo.size.width-72)
                        .padding(.vertical, 64)
                        .background(pokemon.color.opacity(0.5))
                        .cornerRadius(24)
                    Spacer(minLength: 24)
                    // About
                    Text("About")
                        .font(.headline.bold())
                        .foregroundColor(pokemon.color)
                    Spacer()
                    Text("Height : \(pokemon.height)")
                        .font(.subheadline)
                    Spacer()
                    Text("Weight : \(pokemon.weight)")
                        .font(.subheadline)
                    Spacer(minLength: 24)
                    // Stats
                    Text("Stats")
                        .font(.headline.bold())
                        .foregroundColor(pokemon.color)
                    ForEach(pokemon.stats, id: \.self) { item in
                        let width = geo.size.width-200
                        let label = item.key.split(separator: "-").joined(separator: " ").capitalized
                        HStack(alignment: .center) {
                            Text("\(label)")
                                .font(.caption.bold())
                                .lineLimit(1)
                                .foregroundColor(item.color.opacity(0.75))
                                .frame(width: 75)
                            Text("\(item.value)")
                                .font(.subheadline.bold())
                                .foregroundColor(item.color.opacity(0.75))
                                .frame(width: 20)
                            ProgressBar(value: item.value, width: width, color: item.color)
                        }
                        
                    }
                    
                }.frame(maxWidth: .infinity)
            }
        }.navigationTitle(pokemon.name.capitalized)
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(pokemon: Pokemon(
            id: 1,
            name: "bulbasaur",
            height: 69,
            weight: 69,
            stats: [
                Stat(key: "special-attack", value: 65)
            ],
            types: ["grass", "poison"]))
    }
}
