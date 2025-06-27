//
//  DateArticleView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import SwiftUI

struct DateArticleView: View {
    var model: NewsModel
    var color: Color
    var fontWeight: Font.Weight?
    
    var body: some View {
        Text(model.publishedAt.formatted(date: .abbreviated, time: .omitted))
            .font(.system(.caption, weight: fontWeight))
            .foregroundStyle(color)
    }
}
