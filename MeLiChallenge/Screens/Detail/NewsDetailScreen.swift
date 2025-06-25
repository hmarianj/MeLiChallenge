//
//  NewsDetailScreen.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import SwiftUI

struct NewsDetailScreen: View {
    var model: NewsModel
    
    var body: some View {
        ScrollView {
            Text(model.title)
            
            // TODO: Add more info
        }
        .navigationTitle("TODO")
    }
}
