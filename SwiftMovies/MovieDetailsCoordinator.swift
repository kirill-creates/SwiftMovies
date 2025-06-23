//
//  MovieDetailsCoordinator.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import Combine
import Foundation

class MovieDetailsCoordinator: ObservableObject {
    private var cancellable: AnyCancellable?

    let movieId: Int

    @Published var fetching = false

    @Published var movie: Movie? = nil

    init(movieId: Int) {
        self.movieId = movieId

        fetchMovieDetails()
    }

    private func fetchMovieDetails() {
        fetching = true

        cancellable = BaseAPI.fetchMovieDetails(with: movieId).sink(
            receiveCompletion: { [weak self] result in
                switch result {
                case let .failure(err):
                    print("--- fetch Error: \(err)")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self?.fetchMovieDetails()
                    }

                case .finished:
                    print("--- fetch completed")
                }

                DispatchQueue.main.async {
                    self?.fetching = false
                }
            },
            receiveValue: { [weak self] movie in
                DispatchQueue.main.async {
                    self?.movie = movie
                }
            }
        )
    }

    func fetchTapped() {
        fetchMovieDetails()
    }

    deinit {
        cancellable = nil
        movie = nil
    }
}
