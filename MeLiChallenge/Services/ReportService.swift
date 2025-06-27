//
//  ReportService.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation

// Protocol to enable Dependency Injection.
protocol ReportService {
    func getReports() async throws -> SearchResult
}

struct SpaceNewsReportService: ReportService {
    // Production backend implementation of the ReportService protocol
    func getReports() async throws -> SearchResult {
        try await HTTPClient.shared.execute(
            urlString: "https://api.spaceflightnewsapi.net/v4/reports/",
            method: .get(nil),
            headers: [
                "Accept": "application/json",
                "User-Agent": "iOSApp/1.0"
            ],
            responseType: SearchResult.self
        )
    }
}
