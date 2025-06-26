//
//  ReportService.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

protocol ReportService {
    func getReports() async throws -> SearchResult
}

struct SpaceNewsReportService: ReportService {
    func getReports() async throws -> SearchResult {
        try await HTTPClient.shared.execute(
            urlString: "https://api.spaceflightnewsapi.net/v4/reports/",
            method: .get([.init(name: "format", value: "json")]),
            responseType: SearchResult.self
        )
    }
}
