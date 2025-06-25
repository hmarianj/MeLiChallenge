//
//  NewsDetailScreen.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import SwiftUI

struct NewsDetailScreen: View {
    @StateObject var viewModel: NewsDetailViewModel
    
    init(model: NewsModel) {
        _viewModel = StateObject(wrappedValue: .init(model: model))
    }
    
    var body: some View {
        ScrollView {
            Text(viewModel.model.title)
            
            // TODO: Add loading sections to display more info
        }
        .navigationTitle("TODO")
    }
}
