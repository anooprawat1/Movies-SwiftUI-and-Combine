//
//  ContentView.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 08.07.22.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var movieViewModel: MovieViewModel
    
    init(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
    }
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List(movieViewModel.movieList) { movie in
                MovieRowView(viewModel:movie)
            }
            .navigationBarTitle("Movies")
        }.navigationViewStyle(StackNavigationViewStyle())
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)).onSubmit {
                
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(movieViewModel: MovieViewModel(movieService: MovieService()))
    }
}
