//
//  BaseAPI.swift
//  SwiftMovies
//
//  Created by Kirill on 6.10.2023.
//

import Combine
import Foundation

struct Agent {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    func send<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                // TODO: handle failed response code
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
}

enum BaseAPI {
    static let agent = Agent()

    static let apiKey = "afd546f1dc614c6c19a53dab9ce71f6f"
    static let moviesListUrl = "https://api.themoviedb.org/3/discover/movie"
    static let imageUrl = "https://image.tmdb.org/t/p/w200"

    static func movieDetailsUrl(with movieId: String) -> String {
        "https://api.themoviedb.org/3/movie/\(movieId)"
    }

    static func baseRequest(urlString: String) -> URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError()
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        return request
    }

    static func posterUrl(with posterPath: String) -> URL? {
        return URL(string: imageUrl + posterPath)
    }
}

extension BaseAPI {
    enum State {
        case fetching
        case fetched
        case error(Error)
    }

    static func fetchMovies() -> AnyPublisher<MoviesList, Error> {
        let request = baseRequest(urlString: "\(moviesListUrl)?api_key=\(apiKey)")
        return agent.send(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func fetchMovieDetails(with movieId: Int) -> AnyPublisher<Movie, Error> {
        let urlString = movieDetailsUrl(with: "\(movieId)") + "?api_key=\(apiKey)"
        let request = baseRequest(urlString: urlString)
        return agent.send(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
