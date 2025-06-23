//
//  SwiftMoviesApp.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import Combine
import SwiftUI

@main
struct SwiftMoviesApp: App {
    let coordinator = MainCoordinator()

    var body: some Scene {
        WindowGroup {
            MoviesListView(coordinator: coordinator)
        }
    }
}
