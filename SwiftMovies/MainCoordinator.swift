//
//  MainCoordinator.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import Combine
import Foundation

class MainCoordinator: ObservableObject {
    private var cancellable: AnyCancellable?

    @Published var fetching = true

    @Published var moviesList: MoviesList? = nil

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.fetchMovies()
        }
    }

    private func fetchMovies() {
        fetching = true

        cancellable = BaseAPI.fetchMovies().sink(
            receiveCompletion: { [weak self] result in
                switch result {
                case let .failure(err):
                    print("--- fetch Error: \(err)")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self?.fetchMovies()
                    }

                case .finished:
                    print("--- fetch completed")
                }

                DispatchQueue.main.async {
                    self?.fetching = false
                }
            },
            receiveValue: { [weak self] moviesList in
                DispatchQueue.main.async {
                    self?.moviesList = moviesList
                }
            }
        )
    }

    func fetchTapped() {
        fetchMovies()
    }

    deinit {
        cancellable = nil
        moviesList = nil
    }
}
