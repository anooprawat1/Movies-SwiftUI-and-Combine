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
                }.frame(width: 70, height: 70)

                VStack(alignment:.leading, spacing: 5){
                    Text(viewModel.title).bold().font(.system(size: 20)).lineLimit(2)
                    Text(viewModel.description).lineLimit(2)
                }
            }
        
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(viewModel: MovieRowViewModel(id: 12321,title: "Best Movie", imageUrl:  "/nPW5AkzoQSO8dWhE8WZMFvC41iW.jpg", description:"This is the best movie"))
    }
}

