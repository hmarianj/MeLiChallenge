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
                ImageArticleView(
                    model: model,
                    style: ImageArticleStyle.detailsCard
                )
                VStack(spacing: 12) {
                    DateArticleView(model: model, color: .gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    TitleArticleView(
                        model: model,
                        style: TitleArticleStyle.titleMedium,
                        color: .blackText
                    )
                    AuthorsView(model: model)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    summaryView
                }
                .padding(.horizontal)
            }
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
    }
}

private extension NewsDetailScreen {
    var summaryView: some View {
        Text(model.summary)
            .font(.body)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.backward")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.blueMedium)
                .padding(8)
                .background(.grayDark)
                .clipShape(.circle)
        }
        .accessibilityLabel("Back button")
        .accessibilityHint("Double tap to back")
    }
    
}

#Preview {
    NewsDetailScreen(
        model: .mock(id: 1)
    )
}
