//
//  ContentView.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 08.07.22.
//

import SwiftUI

struct MoviesView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                Text("A List Item")
                Text("A Second List Item")
                Text("A Third List Item")
            }
            .navigationBarTitle("Movies")
        }.navigationViewStyle(StackNavigationViewStyle())
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)).onSubmit {
                
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
