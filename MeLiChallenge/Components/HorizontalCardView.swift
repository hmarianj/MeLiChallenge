//
//  HorizontalCardView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import SwiftUI

struct HorizontalCardView: View {
    var model: NewsModel

    // TODO: check paddings and spacings
    var body: some View {
        VStack(spacing: 16) {
            ImageArticleView(model: model, style: ImageArticleStyle.horizontalCard)
            TitleArticleView(model: model, style: TitleArticleStyle.titleMedium)
            HStack {
                AuthorsView(model: model)
                Spacer()
                DateArticleView(model: model)
            }
        }
        .frame(width: 240, height: 260)
        .padding(12)
        .background(Color.ligthBlue)
        .cornerRadius(10)
    }
}

#Preview {
    HorizontalCardView(
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
