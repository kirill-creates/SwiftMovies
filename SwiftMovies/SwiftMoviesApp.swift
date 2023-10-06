//
//  SwiftMoviesApp.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import SwiftUI
import Combine

@main
struct SwiftMoviesApp: App {
    let coordinator = MainCoordinator()
    
    var body: some Scene {
        WindowGroup {
            MoviesListView(coordinator: coordinator)
        }
    }
}
