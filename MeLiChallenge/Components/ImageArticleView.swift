//
//  ImageArticleView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import SwiftUI

struct ImageArticleView: View {
    var model: NewsModel
    var style: ImageArticleStyle
    
    var body: some View {
        AsyncImage(url: URL(string: model.imageUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: style.contentMode)
                .frame(width: style.size.width, height: style.size.height)
                .cornerRadius(style.cornerRadius)
        } placeholder: {
            ProgressView()
                .frame(width: style.size.width, height: style.size.height)
        }
    }
}

enum ImageArticleStyle {
    case verticalCard
    case horizontalCard
    case detailsCard
    
    var size: CGSize {
        switch self {
        case .verticalCard:
            return CGSize(width: 90, height: 86)
        case .horizontalCard:
            return CGSize(width: 220, height: 120)
        case .detailsCard:
            return CGSize(width: UIScreen.main.bounds.width, height: 260) // TODO: max width
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .verticalCard, .horizontalCard:
            return 8
        case .detailsCard:
            return 0
        }
    }
    
    var contentMode: ContentMode {
        switch self {
        case .verticalCard, .detailsCard:
            return .fill
        case .horizontalCard:
            return .fit
        }
    }
}
