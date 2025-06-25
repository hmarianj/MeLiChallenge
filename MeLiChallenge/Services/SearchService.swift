import Foundation

protocol SearchService {
    func search(query: String) async throws -> SearchResult
}

struct SpaceNewsSearchService: SearchService {
    func search(query: String) async throws -> SearchResult {
        try await HTTPClient.shared.execute(
            urlString: "https://api.spaceflightnewsapi.net/v4/articles/",
            method: .get(
                [
                    .init(name: "search", value: query),
                    .init(name: "format", value: "json"),
                    .init(name: "limit", value: "10"),
                ]
            ),
            responseType: SearchResult.self
        )
    }
}
