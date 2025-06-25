//
//  HomeScreen.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ScrollView {
                if let searchResult = viewModel.searchResult {
                    loadedView(searchResult: searchResult)
                } else if viewModel.isLoading {
                    loadingView
                } else if viewModel.error != nil {
                    errorView
                } else {
                    initialView
                }
            }
            .navigationTitle("Space News")
            .searchable(text: $viewModel.searchText)
            .navigationDestination(for: HomeNavigationPath.self) { route in
                switch route {
                case let .newsDetail(newsModel):
                    NewsDetailScreen(model: newsModel)
                }
            }
        }
    }
    
    // TODO: Remove this, is here just for testing temporarily
    func getData() {
        Task {
            await viewModel.search(query: "NASA")
        }
    }
}

private extension HomeScreen {
    // TODO: Implement a Initial View
    var initialView: some View {
        VStack {
            Text("Initial State")
            Button("Search") {
                getData()
            }
        }
    }
    
    var loadingView: some View {
        // TODO: ProgressView custom
        ProgressView()
    }
    
    @ViewBuilder
    func loadedView(searchResult: SearchResult) -> some View {
        if searchResult.results.isEmpty {
            // TODO: Empty State
            Text("No results")
        } else {
            // TODO: Real cell + Navigation
            VStack(spacing: 8) {
                ForEach(searchResult.results, id: \.id) { result in
                    Text(result.title)
                        .onTapGesture {
                            viewModel.navigationPath.append(.newsDetail(result))
                        }
                    Divider()
                }
            }
        }
    }
    
    var errorView: some View {
        // TODO: UI + Retry
        Text("error")
    }
}

#Preview {
    HomeScreen()
}
