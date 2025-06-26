//
//  HomeScreen.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ScrollView {
                if !isSearching {
                    ReportsCarousel()
                }
                articlesSection
            }
            .navigationTitle("Space News")
            .searchable(text: $viewModel.searchText, isPresented: $isSearching)
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
    @ViewBuilder
    var articlesSection: some View {
        if viewModel.isFirstLoading {
            loadingView
        } else if let news = viewModel.loadedNews {
            loadedView(news: news)
        } else if viewModel.error != nil {
            errorView
        } else {
            EmptyView()
        }
    }
    
    var loadingView: some View {
        loadedView(news: [
            .mock(id: 0),
            .mock(id: 1),
            .mock(id: 2)
        ])
        .redacted(reason: .placeholder) // Skeleton loading
    }
    
    @ViewBuilder
    func loadedView(news: [NewsModel]) -> some View {
        if news.isEmpty {
            // TODO: Empty State
            Text("No results")
        } else {
            LazyVStack(spacing: 8) {
                if !isSearching {
                    Text("Articles")
                        .font(.system(.title2, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                ForEach(news, id: \.uniqueIdentifier) { newsModel in
                    Button {
                        viewModel.navigationPath.append(.newsDetail(newsModel))
                    } label: {
                        VerticalCardView(model: newsModel)
                    }
                    .buttonStyle(.plain)
                    Divider()
                }
                .padding(.horizontal, 16)
                
                if viewModel.hasMorePages {
                    ProgressView()
                        .frame(height: 60)
                        .task {
                            await viewModel.loadNextPageIfNeeded()
                        }
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
