//
//  SectionTitleView.swift
//  MeLiChallenge
//
//  Created by MH on 27/06/2025.
//

import Foundation
import SwiftUI

struct SectionTitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(.title2, weight: .semibold))
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
