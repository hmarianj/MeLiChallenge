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
    
    var body: some View {
        Text(model.publishedAt.formatted(date: .abbreviated, time: .omitted))
            .font(.caption)
            .foregroundStyle(.gray)
    }
}
