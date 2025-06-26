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
    }
    
    var hasMorePages: Bool {
        guard let loadedNews else { return false }
        return loadedNews.count < totalCount
    }
    
    func search(query: String?) async {
        guard !isFirstLoading else { return }
        isFirstLoading = true
        error = nil
        currentOffset = 0
        totalCount = 0
        loadedNews = []
        
        do {
            let result = try await searchService.search(query: query, size: pageSize, offset: currentOffset)
            loadedNews = result.results
            totalCount = result.count
            currentOffset += result.results.count
        } catch {
            self.error = error
        }
        
        isFirstLoading = false
    }
    
    func loadNextPageIfNeeded() async {
        guard !isLoadingNextPage, hasMorePages else {
            return
        }
        
        await loadNextPage()
    }
    
    private func loadNextPage() async {
        isLoadingNextPage = true
        defer { isLoadingNextPage = false }

        do {
            let result = try await searchService.search(query: searchText, size: pageSize, offset: currentOffset)
            loadedNews?.append(contentsOf: result.results)
            currentOffset += result.results.count
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
                // TODO: Fix the bug where this is called twice the first time
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
