//
//  APIModel.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

struct SearchResult: Codable {
    var count: Int // TODO: mostrar en la UI
    var results: [NewsModel]
    // TODO: Add the rest of the fields
    
    struct NewsModel: Codable {
        var id: Int
        var title: String
        // TODO: Complete more info
    }
}
