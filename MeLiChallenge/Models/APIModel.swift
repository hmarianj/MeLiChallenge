//
//  APIModel.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import Foundation

struct SearchResult: Codable {
    let count: Int
    let results: [NewsModel]
}

struct NewsModel: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let authors: [Author]
    let imageUrl: String
    let publishedAt: Date
    let summary: String
    let newsSite: String
    
    // Given there are models with the same id, this identifier disambiguates.
    var uniqueIdentifier: String {
        "\(id)-\(title)-\(publishedAt.description)-\(summary)"
    }
}

struct Author: Codable, Equatable, Hashable {
    let name: String
}

extension NewsModel {
    static func mock(
        id: Int = 0,
        title: String = "Some Title",
        authors: [Author] = [.init(name: "Mock Author")],
        imageUrl: String = "https://www.nasa.gov/wp-content/uploads/2025/06/nasa-astronaut-nicole-ayers-on-iss-june-25-advisory.jpg",
        publishedAt: Date = .now,
        summary: String = "Some summary",
        newsSite: String = "Some site"
    ) -> NewsModel {
        NewsModel(
            id: id,
            title: title,
            authors: authors,
            imageUrl: imageUrl,
            publishedAt: publishedAt,
            summary: summary,
            newsSite: newsSite
        )
    }
}
