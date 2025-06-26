//
//  MeLiChallengeApp.swift
//  MeLiChallenge
//
//  Created by MH on 25/06/2025.
//

import SwiftUI

@main
struct MeLiChallengeApp: App {
    init() {
        configureImageCache()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}
