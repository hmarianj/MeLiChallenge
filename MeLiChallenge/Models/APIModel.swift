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
}

struct Author: Codable, Equatable, Hashable {
    let name: String
}
