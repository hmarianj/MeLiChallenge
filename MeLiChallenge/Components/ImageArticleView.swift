//
//  ImageArticleView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import NukeUI
import SwiftUI

struct ImageArticleView: View {
    var model: NewsModel
    var style: ImageArticleStyle
    
    var body: some View {
        LazyImage(url: URL(string: model.imageUrl)) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: style.contentMode)
            } else if state.error != nil {
                Color.gray
            } else {
                ProgressView()
            }
        }
        .frame(width: style.size.width, height: style.size.height)
        .cornerRadius(style.cornerRadius)
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
