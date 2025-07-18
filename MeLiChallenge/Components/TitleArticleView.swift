//
//  TitleArticleView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import SwiftUI

struct TitleArticleView: View {
    var model: NewsModel
    var style: TitleArticleStyle
    var color: Color
    
    var body: some View {
        Text(model.title)
            .font(style.font)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(color)
    }
}

enum TitleArticleStyle {
    case titleLarge
    case titleMedium
    case titleSmall
    
    var font: Font {
        switch self {
        case .titleLarge:
            return .system(.title, weight: .semibold)
        case .titleMedium:
            return .system(.title2, weight: .semibold)
        case .titleSmall:
            return .system(.callout, weight: .semibold)
        }
    }
}
