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
            } else if viewModel.error != nil {
                EmptyView() // If there is an error, we hide the carousel
            } else if let reports = viewModel.reports {
                reportsView(reports: reports)
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
            VStack(spacing: 8) {
                SectionTitleView(title: "Reports")
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        ForEach(reports, id: \.uniqueIdentifier) { report in
                            Button {
                                onReportTap(report)
                            } label: {
                                HorizontalCardView(model: report)
                            }
                            .buttonStyle(.plain)
                        }
                        .accessibilityHint("Double tap to open")
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}
