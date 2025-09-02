//
//  FeedCollectionViewModel.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 15/05/2025.
//

import Foundation

class FeedCollectionViewModel {

    let repository: DataRepository!

    let networkService: NetworkService!

    var photos: [Photo] = []

    var onDataUpdated: (() -> Void)?

    init(networkService: NetworkService, repository: DataRepository) {

        self.networkService = networkService

        self.repository = repository

        loadNewsFeed()
    }

    func loadNewsFeed() {

        Task {
            do {
                let newsFeedResult = try await repository.fetchNewsFeed()

               // DispatchQueue.main.async {

                    self.photos = newsFeedResult.photos
                    self.onDataUpdated?()
             //   }

            } catch {
                print(error)
            }
        }

    }
}
