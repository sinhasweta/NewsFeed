//
//  NetworkService.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 12/05/2025.
//

import Foundation

protocol NetworkService {

    func fetchDataAsync<T: Decodable>(from url: URL) async throws -> T

    func fetchDataAsync<T: Decodable>(from url: URL, completionHandler: @escaping (Result<T, Error>) -> Void)

}
