//
//  MovieDetailedView.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import SwiftUI

struct MovieDetailedView: View {
    let coordinator: MovieDetailsCoordinator

    var body: some View {
        VStack {
            if coordinator.fetching {
                ProgressView()
            } else {
                if let movie = coordinator.movie {
                    HStack {
                        Spacer()
                        if let url = BaseAPI.posterUrl(with: movie.posterPath) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 300)
                        }
                        Spacer()
                    }

                    VStack {
                        Text(movie.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)

                        Text(movie.releaseDate)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3)

                        Text(movie.overview)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.callout)
                    }
                    .padding()

                    Spacer()

                } else {
                    VStack {
                        Spacer()
                        Image(systemName: "icloud.slash")
                            .imageScale(.large)
                        Spacer()
                    }
                }
            }
        }
    }
}
