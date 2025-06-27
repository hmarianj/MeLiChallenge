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
                reportsSection
                articlesSection
            }
            .scrollIndicators(.hidden)
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
    var reportsSection: some View {
        if !isSearching {
            titleSectionView(title: "Reports")
            ReportsCarousel(
                onReportTap: { report in
                    viewModel.navigationPath.append(.newsDetail(report))
                }
            )
        }
    }
    
    @ViewBuilder
    var articlesSection: some View {
        if viewModel.isFirstLoading {
            loadingView
        } else if viewModel.error != nil {
            errorView
        } else if let news = viewModel.loadedNews {
            loadedView(news: news)
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
    
    func titleSectionView(title: String) -> some View {
        Text(title)
            .font(.system(.title2, weight: .semibold))
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func loadedView(news: [NewsModel]) -> some View {
        if news.isEmpty {
            Text("No results")
        } else {
            LazyVStack(spacing: 8) {
                if !isSearching {
                    titleSectionView(title: "Articles")
                }
                ForEach(news, id: \.uniqueIdentifier) { newsModel in
                    Button {
                        viewModel.navigationPath.append(.newsDetail(newsModel))
                    } label: {
                        VerticalCardView(model: newsModel)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityHint("Double tap to open")
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
        ErrorView {
            Task {
                await viewModel.search(query: viewModel.searchText)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
