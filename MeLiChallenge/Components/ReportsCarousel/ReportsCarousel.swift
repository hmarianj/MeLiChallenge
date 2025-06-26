//
//  ReportsCarousel.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import SwiftUI

struct ReportsCarousel: View {
    @StateObject private var viewModel: ReportsCarouselViewModel = ReportsCarouselViewModel()
    var onReportTap: (NewsModel) -> Void
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let reports = viewModel.reports {
                reportsView(reports: reports)
            } else if viewModel.error != nil {
                EmptyView() // If there is an error, we hide the carousel
            } else {
                HStack{} // Just here as the initial state
            }
        }
        .task {
            await viewModel.loadReports()
        }
    }
    
    private var loadingView: some View {
        reportsView(reports: [
            .mock(id: 0),
            .mock(id: 1),
            .mock(id: 2),
        ])
        .redacted(reason: .placeholder) // Skeleton loading
    }
    
    @ViewBuilder
    private func reportsView(reports: [NewsModel]) -> some View {
        if reports.isEmpty {
            EmptyView()
        } else {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(reports, id: \.uniqueIdentifier) { report in
                        Button {
                            onReportTap(report)
                        } label: {
                            HorizontalCardView(model: report)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
