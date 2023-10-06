//
//  MoviesList.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import Foundation

struct MoviesList: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
