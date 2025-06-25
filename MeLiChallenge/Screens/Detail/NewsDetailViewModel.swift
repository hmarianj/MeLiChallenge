//
//  NewsDetailViewModel.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import Foundation

@MainActor
final class NewsDetailViewModel: ObservableObject {
    let model: NewsModel
    // TODO: Use a service to fetch more info
    
    init(model: NewsModel) {
        self.model = model
    }
    
    // TODO: Add a method to fetch more info
}
