//
//  NewsDetailScreen.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import SwiftUI

struct NewsDetailScreen: View {
    var model: NewsModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ImageArticleView(model: model, style: ImageArticleStyle.detailsCard)
                DateArticleView(model: model)
                TitleArticleView(model: model, style: TitleArticleStyle.titleLarge)
                AuthorsView(model: model)
                summaryView
            }
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                // TODO: Fix the UI of this button
                ZStack {
                    Circle()
                        .frame(width: 44, height: 44)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 4)
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.ligthBlue)
                }
                .padding()
            }
        }
    }
}

private extension NewsDetailScreen {
    var summaryView: some View {
        Text(model.summary) // TODO: add styles
    }
}

#Preview {
    NewsDetailScreen(
        model: .init(
            id: 1,
            title: "Global Summit on Climate Change: Historic Agreement Reached",
            authors: .init(),
            imageUrl: "https://www.nasa.gov/wp-content/uploads/2025/06/nasa-astronaut-nicole-ayers-on-iss-june-25-advisory.jpg",
            publishedAt: .now,
            summary: "Following a series of contract protests, the Space Development Agency again awarded SpaceX a $149 million contract and L3Harris a $193.5 million contract to each build four satellites to detect and track ballistic and hypersonic missiles"
        )
    )
}
