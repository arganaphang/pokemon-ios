//
//  PokemonCardSkeleton.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import SwiftUI

struct PokemonCardSkeleton: View {
    var body: some View {
        Spacer()
            .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(Color(.lightGray).opacity(0.5))
            .cornerRadius(8.0)
            .padding(.horizontal, 8)
    }
}

struct PokemonCardSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCardSkeleton()
    }
}
