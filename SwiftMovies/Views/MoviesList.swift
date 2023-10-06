//
//  ContentView.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var coordinator: MainCoordinator
    var body: some View {
        NavigationStack {
            VStack {
                if coordinator.fetching {
                    ProgressView()
                } else {
                    if let movies = coordinator.moviesList?.movies {
                        List {
                            ForEach(movies, id: \.id) { movie in
                                NavigationLink {
                                    let coordinator = MovieDetailsCoordinator(movieId: movie.id)
                                    MovieDetailedView(coordinator: coordinator)
                                } label: {
                                    MovieSimpleView(movie: movie)
                                }
                                .listRowSeparator(.hidden)
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            Text("An error occured...")
                            Button("Retry") {
                                coordinator.fetchTapped()
                            }
                            .padding()
                            .font(.title2)
                            Spacer()
                        }
                    }
                }
            }
            .padding(0)
            .navigationTitle("Movies")
        }
    }
}

//#Preview {
//    //MoviesListView(coordinator: nil)
//}
