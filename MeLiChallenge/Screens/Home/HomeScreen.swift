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
                if viewModel.isLoading {
                    loadingView
                } else if let news = viewModel.loadedNews {
                    loadedView(news: news)
                } else if viewModel.error != nil {
                    errorView
                } else {
                    initialView
                }
            }
            .task {
                await viewModel.search(query: nil)
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
}

private extension HomeScreen {
    // TODO: Implement a Initial View
    var initialView: some View {
        VStack {
            Text("Initial State")
        }
    }
    
    var loadingView: some View {
        // TODO: ProgressView custom
        ProgressView()
    }
    
    @ViewBuilder
    func loadedView(news: [NewsModel]) -> some View {
        if news.isEmpty {
            // TODO: Empty State
            Text("No results")
        } else {
            LazyVStack(spacing: 8) {
                Text("Articles")
                    .font(.system(.title2, weight: .semibold))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(news, id: \.id) { newsModel in
                    VerticalCardView(model: newsModel)
                        .onTapGesture {
                            viewModel.navigationPath.append(.newsDetail(newsModel))
                        }
                        .task {
                            await viewModel.loadNextPageIfNeeded(currentItem: newsModel)
                        }
                    Divider()
                }
                .padding(.horizontal, 16)
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
