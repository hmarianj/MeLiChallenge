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
    @Published var loadedNews: [NewsModel]?
    @Published var isLoadingNextPage: Bool = false
    @Published var isFirstLoading: Bool = false
    @Published var error: Error?
    @Published var searchText: String = ""
    @Published var navigationPath: [HomeNavigationPath] = []
    
    private var currentOffset: Int = 0
    private let pageSize: Int = 20
    private var totalCount: Int = 0
    
    private let searchService: SearchService
    private var cancellables: [AnyCancellable] = []
    
    init(searchService: SearchService = SpaceNewsSearchService()) {
        self.searchService = searchService
        setUpSubscribers()
        // Search without a query when the view model is instantiated.
        Task { [weak self] in
            await self?.search(query: nil)
        }
    }
    
    // True if there are more pages to load from the backend.
    var hasMorePages: Bool {
        guard let loadedNews else { return false }
        return loadedNews.count < totalCount
    }
    
    // Search the articles for the given query from the backend.
    func search(query: String?) async {
        guard !isFirstLoading else { return }
        // Reset the current state when a new search is performed.
        isFirstLoading = true
        error = nil
        currentOffset = 0
        totalCount = 0
        loadedNews = []
        
        do {
            let result = try await searchService.search(query: query, size: pageSize, offset: currentOffset)
            loadedNews = result.results
            totalCount = result.count // Update the total count of articles (necessary for pagination)
            currentOffset += result.results.count // Update the pagination offset
        } catch {
            self.error = error
        }
        
        isFirstLoading = false
    }
    
    // Pagination handling mechanism
    func loadNextPageIfNeeded() async {
        guard !isLoadingNextPage, hasMorePages else {
            return
        }
        
        await loadNextPage()
    }
}

private extension HomeViewModel {
    // Only start a new search after the search text has changed
    // (with a 1 second debouncer to avoid multiple requests to the backend)
    func setUpSubscribers() {
        $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] newValue in // Use [weak self] to avoid memory leaks
                Task { [weak self] in
                    await self?.search(query: newValue)
                }
            }
            .store(in: &cancellables)
    }
    
    func loadNextPage() async {
        isLoadingNextPage = true
        defer { isLoadingNextPage = false }
        
        do {
            let result = try await searchService.search(query: searchText, size: pageSize, offset: currentOffset)
            loadedNews?.append(contentsOf: result.results) // Append the new result to the current articles loaded
            currentOffset += result.results.count // Update the pagination offset
        } catch {
            self.error = error
        }
    }
}

enum HomeNavigationPath: Hashable {
    case newsDetail(NewsModel)
}
