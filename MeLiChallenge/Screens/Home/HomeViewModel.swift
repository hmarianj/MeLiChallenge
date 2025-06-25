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
    @Published var isPaginating: Bool = false
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var searchText: String = ""
    @Published var navigationPath: [HomeNavigationPath] = []
    
    private var currentOffset: Int = 0
    private let pageSize: Int = 10
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
        guard !isLoading else { return }
        isLoading = true
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

        isLoading = false
    }
    
    func loadNextPageIfNeeded(currentItem: NewsModel) async {
        guard !isPaginating,
              hasMorePages,
              let loadedNews,
              currentItem.id == loadedNews.last?.id else {
            return
        }

        isPaginating = true
        defer { isPaginating = false }

        do {
            let result = try await searchService.search(query: searchText, size: pageSize, offset: currentOffset)
            let existingIDs = Set(loadedNews.map { $0.id })
            let newItems = result.results.filter { !existingIDs.contains($0.id) }
            self.loadedNews?.append(contentsOf: newItems)
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
