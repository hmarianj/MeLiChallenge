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
            HStack(alignment: .top, spacing: 16) {
                ImageArticleView(
                    model: model,
                    style: ImageArticleStyle.verticalCard
                )
                VStack(alignment: .leading, spacing: 6) {
                    TitleArticleView(
                        model: model,
                        style: TitleArticleStyle.titleSmall,
                        color: .blackText
                    )
                    .lineLimit(3)
                    Spacer()
                    HStack(alignment: .center) {
                        AuthorsView(model: model)
                        Spacer()
                        DateArticleView(model: model, color: .gray)
                    }
                }
            }
        }
        .padding(.vertical, 4)
        .cornerRadius(8)
    }
}

#Preview {
    VStack {
        VerticalCardView(
            model: .mock(id: 1)
        )
        VerticalCardView(
            model: .mock(id: 2)
        )
    }
    .padding()
}
