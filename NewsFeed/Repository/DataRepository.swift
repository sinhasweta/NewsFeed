//
//  DataRepository.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 12/05/2025.
//

import Foundation

protocol DataRepository {

    func fetchNewsFeed() async throws -> NewsFeedModel

    func fetchNewsFeed(completion: @escaping (Result<NewsFeedModel, Error>) -> Void)
}
