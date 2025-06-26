//
//  VerticalCardView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import SwiftUI

struct VerticalCardView: View {
    var model: NewsModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                ImageArticleView(model: model, style: ImageArticleStyle.verticalCard)
                VStack(alignment: .leading, spacing: 4) {
                    TitleArticleView(model: model, style: TitleArticleStyle.titleSmall)
                    HStack {
                        AuthorsView(model: model)
                        Spacer()
                        DateArticleView(model: model)
                    }
                }
            }
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}

#Preview {
    VStack(spacing: 24) {
        VerticalCardView(
            model: NewsModel.init(
                id: 1,
                title: "Global Summit on Climate Change: Historic Agreement Reached",
                authors: .init(),
                imageUrl: "https://www.nasa.gov/wp-content/uploads/2025/06/nasa-astronaut-nicole-ayers-on-iss-june-25-advisory.jpg",
                publishedAt: .now,
                summary: ""
            )
        )
        VerticalCardView(
            model: NewsModel.init(
                id: 1,
                title: "Global Summit on Climate Change: Historic Agreement Reached",
                authors: .init(),
                imageUrl: "https://www.nasa.gov/wp-content/uploads/2025/06/nasa-astronaut-nicole-ayers-on-iss-june-25-advisory.jpg",
                publishedAt: .now,
                summary: ""
            )
        )
        VerticalCardView(
            model: NewsModel.init(
                id: 1,
                title: "Global Summit on Climate Change: Historic Agreement Reached",
                authors: .init(),
                imageUrl: "https://www.nasa.gov/wp-content/uploads/2025/06/nasa-astronaut-nicole-ayers-on-iss-june-25-advisory.jpg",
                publishedAt: .now,
                summary: ""
            )
        )
        VerticalCardView(
            model: NewsModel.init(
                id: 1,
                title: "Global Summit on Climate Change: Historic Agreement Reached",
                authors: .init(),
                imageUrl: "https://www.nasa.gov/wp-content/uploads/2025/06/nasa-astronaut-nicole-ayers-on-iss-june-25-advisory.jpg",
                publishedAt: .now,
                summary: ""
            )
        )
    }
    .padding()
}

