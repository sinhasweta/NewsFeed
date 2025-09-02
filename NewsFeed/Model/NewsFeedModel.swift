//
//  NewsFeedModel.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 08/05/2025.
//

struct NewsFeedModel: Codable {

    let success: Bool

    let total_photos: Int?

    let photos: [Photo]
}


struct Photo: Codable {

    let id: Int
    
    let title: String
    
    let description: String

    let url: String

    init(id: Int, title: String, description: String, url: String) {
        self.id = id
        self.title = title
        self.description = description
        self.url = url
    }
}
