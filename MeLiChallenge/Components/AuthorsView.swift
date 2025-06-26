//
//  AuthorsView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import SwiftUI

struct AuthorsView: View {
    var model: NewsModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(model.authors, id: \.self) { author in
                Text(author.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
