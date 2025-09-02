//
//  NetworkServiceImpl.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 12/05/2025.
//

import Foundation

enum NewsFeedError: Error {

    case invalidResponse

    case deserialisationFailed

    case generic
}

class NetworkServiceImpl: NetworkService {

    func fetchDataAsync<T: Decodable>(from url: URL) async throws -> T {

        do {

           let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let decoder = JSONDecoder()
                    return try decoder.decode(T.self, from: data)
                } else {
                    throw NewsFeedError.deserialisationFailed
                }
            } else {
                throw NewsFeedError.invalidResponse
            }

        } catch {
            throw NewsFeedError.generic
        }
    }

    func fetchDataAsync<T: Decodable>(from url: URL, completionHandler: @escaping (Result<T, Error>) -> Void) {

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {

                completionHandler(.failure(error))
                return
            }

            do {

                let resource = try JSONDecoder().decode(T.self, from: data!)
                completionHandler(.success(resource))

            } catch {

                completionHandler(.failure(error))
            }
        }

        task.resume()
    }

}
