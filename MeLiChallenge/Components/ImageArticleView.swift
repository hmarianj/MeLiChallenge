//
//  ImageArticleView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import Nuke
import NukeUI
import SwiftUI

struct ImageArticleView: View {
    let model: NewsModel
    let style: ImageArticleStyle
    
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
        // Resize image to improve render time
        .processors([
            ImageProcessors.Resize(
                size: CGSize(
                    width: style.size.width * UIScreen.main.scale,
                    height: style.size.height * UIScreen.main.scale
                ),
                unit: .pixels,
                contentMode: .aspectFill // TODO: Check for horizontal card
            )
        ])
        .priority(.normal)
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
            return CGSize(width: UIScreen.main.bounds.width, height: 260)
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
