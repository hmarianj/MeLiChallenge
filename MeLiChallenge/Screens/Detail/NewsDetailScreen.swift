//
//  NewsDetailScreen.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import SwiftUI

struct NewsDetailScreen: View {
    var model: NewsModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ImageArticleView(model: model, style: ImageArticleStyle.detailsCard)
                datePostView
                TitleArticleView(model: model, style: TitleArticleStyle.titleLarge)
                AuthorsView(model: model)
                summaryView
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .top)
    }
}

private extension NewsDetailScreen {
    
    var datePostView: some View {
        Text("04 Abril, 2025")
            .font(.subheadline)
            .foregroundStyle(Color.gray.opacity(0.8)) // TODO: create color
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
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
