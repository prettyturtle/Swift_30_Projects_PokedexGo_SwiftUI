//
//  PokemonSearchListCell.swift
//  Swift_30_Projects_PokedexGo
//
//  Created by yc on 2023/05/07.
//

import SwiftUI

struct PokemonSearchListCell: View {
    
    @Binding var pokemon: Pokemon
    @State var pokemonImage: UIImage?
    
    var body: some View {
        HStack {
            VStack(spacing: 16) {
                Text(pokemon.convertedID)
                    .font(.system(size: 14))
                Text(pokemon.name)
                    .font(.system(size: 18, weight: .medium))
            }
            
            Spacer()
            
            if let pokemonImage = pokemonImage {
                Image(uiImage: pokemonImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
        }
        .onAppear {
            if let url = URL(string: pokemon.pokeImgURL) {
                
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    if let data = data {
                        self.pokemonImage = UIImage(data: data)
                        return
                    }
                }
                .resume()
            }
        }
    }
}

struct PokemonSearchListCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSearchListCell(pokemon: .constant(Pokemon.mocks.first!))
            .previewLayout(.sizeThatFits)
        PokemonSearchListCell(pokemon: .constant(Pokemon.mocks[1]))
            .previewLayout(.sizeThatFits)
    }
}
