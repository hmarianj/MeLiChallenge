//
//  HomeViewModel.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var searchResult: SearchResult?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var searchText: String = ""
    @Published var navigationPath: [HomeNavigationPath] = []
    
    private let searchService: SearchService
    private var cancellables: [AnyCancellable] = []
    
    init(searchService: SearchService = SpaceNewsSearchService()) {
        self.searchService = searchService
        setUpSubscribers()
    }
    
    func search(query: String?) async {
        defer { isLoading = false }
        do {
            error = nil
            isLoading = true
            self.searchResult = try await searchService.search(query: query)
        } catch {
            self.error = error
        }
    }
}

private extension HomeViewModel {
    func setUpSubscribers() {
        $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self else { return }
                Task {
                    await self.search(query: newValue)
                }
            }
            .store(in: &cancellables)
    }
}

enum HomeNavigationPath: Hashable {
    case newsDetail(NewsModel)
}
