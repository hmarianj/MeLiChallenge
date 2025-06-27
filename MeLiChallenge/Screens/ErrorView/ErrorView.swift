//
//  ErrorView.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import SwiftUI

struct ErrorView: View {
    var onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "xmark.icloud")
                .font(.system(size: 60))
                .foregroundColor(.red)
            Text("Something went wrong")
                .font(.system(.title2))
            Button {
                onRetry()
            } label: {
                Text("Retry")
                    .font(.system(.title3, weight: .semibold))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(.blueMedium)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    ErrorView {
        print("Retry")
    }
}
