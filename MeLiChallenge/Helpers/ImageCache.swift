//
//  ImageCache.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Nuke

/// Configures the cache for the images using Nuke.
func configureImageCache() {
    let pipeline = ImagePipeline {
        let dataCache = try? DataCache(name: "marian.MeLiChallenge")
        dataCache?.sizeLimit = 100 * 1024 * 1024 // 100 MB
        $0.dataCache = dataCache
    }
    ImagePipeline.shared = pipeline
}
