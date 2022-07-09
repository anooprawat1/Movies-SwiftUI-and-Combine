//
//  MovieRowView.swift
//  Movies-SwiftUI-and-Combine
//
//  Created by Anoop on 08.07.22.
//

import SwiftUI

struct MovieRowView: View {
    let viewModel: MovieRowViewModel
    
    init(viewModel: MovieRowViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
            HStack(alignment: .center, spacing: 10) {
                AsyncImage(url: viewModel.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 80, height: 70)

                VStack(alignment:.leading, spacing: 10){
                    Text(viewModel.title)
                    Text(viewModel.description)
                }
            }
        
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(viewModel: MovieRowViewModel(item: MovieResponse.Movie(id: 12321, isAdult: false, title: "Best Movie", overview: "This is the best movie", popularity: 2239.3, releaseDate: Date(), imageUrl:  "https://cf.geekdo-images.com/thumb/img/sD_qvrzIbvfobJj0ZDAaq-TnQPs=/fit-in/200x150/pic2649952.jpg", voteAverage: 8.9, voteCount: 8)))
    }
}

