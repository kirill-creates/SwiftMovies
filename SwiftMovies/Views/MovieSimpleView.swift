//
//  MovieSimpleView.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import SwiftUI

struct MovieSimpleView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            if let url = BaseAPI.posterUrl(with: movie.posterPath) {
                Spacer()
                AsyncImage(url: url) { image in
                         image.resizable()
                     } placeholder: {
                         ProgressView()
                     }
                     .frame(width: 100, height: 150)
                Spacer()
            }
            
            VStack {
                Text(movie.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                    .padding(.top)
                    .padding(.leading)
                Text(movie.releaseDate)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .padding(.leading)
                Spacer()
            }
        }
    }
}

//#Preview {
//    MovieSimpleView()
//}
