//
//  DatarepositoryImpl.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 12/05/2025.
//

import Foundation

class DatarepositoryImpl: DataRepository {

    let networkService: NetworkService

    init(networkService: NetworkService) {

        self.networkService = networkService
    }

    func fetchNewsFeed() async throws -> NewsFeedModel {

        try await networkService.fetchDataAsync(from: URL(string: "https://api.slingacademy.com/v1/sample-data/photos?offset=5&limit=100")!)
    }

    func fetchNewsFeed(completion: @escaping (Result<NewsFeedModel, any Error>) -> Void) {

        networkService.fetchDataAsync(from: URL(string: "https://api.slingacademy.com/v1/sample-data/photos?offset=5&limit=100")!, completionHandler: completion)
    }

}
