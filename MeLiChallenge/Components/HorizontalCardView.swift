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
    
    var body: some View {
        VStack(spacing: 16) {
            tagView
            TitleArticleView(
                model: model,
                style: TitleArticleStyle.titleSmall,
                color: .white
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                Spacer()
                DateArticleView(
                    model: model,
                    color: .grayLight,
                    fontWeight: .semibold
                )
            }
        }
        .frame(width: 140, height: 160)
        .padding(12)
        .background(.blueMedium)
        .cornerRadius(10)
    }
}

private extension HorizontalCardView {
    var tagView: some View {
        Text(model.newsSite)
            .font(.system(.caption, weight: .semibold))
            .foregroundStyle(.blueMedium)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(.white)
            .cornerRadius(12)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HStack {
        HorizontalCardView(
            model: .mock(id: 1)
        )
        HorizontalCardView(
            model: .mock(id: 2)
        )
    }
}
