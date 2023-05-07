//
//  PokemonSearchView.swift
//  Swift_30_Projects_PokedexGo
//
//  Created by yc on 2023/05/07.
//

import SwiftUI

struct PokemonSearchView: View {
    
    private var originPokemonList = Pokemon.mocks
    
    @State var searchText = ""
    
    @State var pokemonList = Pokemon.mocks
    
    @State var selectedPokemon: Pokemon?
    
    @State var columnVisible = NavigationSplitViewVisibility.all
    
    var body: some View {
        
        NavigationSplitView(columnVisibility: $columnVisible) {
            
            List(
                $pokemonList,
                id: \.id,
                selection: $selectedPokemon,
                rowContent: { pokemon in
                    ZStack {
                        NavigationLink {
                            PokemonDetailView(pokemon: pokemon)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                        
                        PokemonSearchListCell(pokemon: pokemon)
                    }
                    .listRowInsets(
                        EdgeInsets(
                            top: 16,
                            leading: 16,
                            bottom: 16,
                            trailing: 16
                        )
                    )
                }
            )
            .listStyle(.plain)
            
            .navigationTitle("Pokemon")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer,
                prompt: Text("Search Pokemon...")
            )
            .onChange(of: searchText) { text in
                if !text.isEmpty {
                    pokemonList = originPokemonList.filter {
                        $0.id.description == text || $0.name.contains(text)
                    }
                } else {
                    pokemonList = originPokemonList
                }
            }
        } detail: {}
        .navigationSplitViewStyle(.balanced)
    }
}

struct PokemonSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSearchView()
    }
}
