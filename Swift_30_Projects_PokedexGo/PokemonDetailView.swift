//
//  PokemonDetailView.swift
//  Swift_30_Projects_PokedexGo
//
//  Created by yc on 2023/05/07.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @Binding var pokemon: Pokemon
    @State var pokemonImage: UIImage?
    
    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 16) {
                Text(pokemon.name)
                    .font(.system(size: 18, weight: .medium))
                Text(pokemon.convertedID)
                    .font(.system(size: 14))
            }
            
            HStack(spacing: 16) {
                if let pokemonImage = pokemonImage {
                    Image(uiImage: pokemonImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                } else {
                    ProgressView()
                        .frame(width: 200, height: 200)
                }
                
                Text(pokemon.detailInfo)
                    .font(.system(size: 18))
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(pokemon.name)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: pokemon) {
            fetchImage(urlString: $0.pokeImgURL)
        }
        .onAppear {
            fetchImage(urlString: pokemon.pokeImgURL)
        }
    }
    
    private func fetchImage(urlString: String) {
        if let url = URL(string: urlString) {
            
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

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: .constant(Pokemon.mocks.first!))
    }
}
