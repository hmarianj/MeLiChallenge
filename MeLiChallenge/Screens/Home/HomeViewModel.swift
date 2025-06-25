//
//  HomeViewModel.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var searchResult: SearchResult?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var searchText: String = ""
    @Published var navigationPath: [HomeNavigationPath] = []
    
    private let searchService: SearchService
    
    init(searchService: SearchService = SpaceNewsSearchService()) {
        self.searchService = searchService
    }
    
    func search(query: String) async {
        defer { isLoading = false }
        do {
            error = nil
            isLoading = true
            self.searchResult = try await searchService.search(query: query)
        } catch {
            self.error = error
        }
    }
    
    // TODO: Observe search text + debouncer
}

enum HomeNavigationPath: Hashable {
    case newsDetail(NewsModel)
}
