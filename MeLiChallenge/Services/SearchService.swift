import Foundation

protocol SearchService {
    func search(query: String?) async throws -> SearchResult
}

struct SpaceNewsSearchService: SearchService {
    func search(query: String?) async throws -> SearchResult {
        try await HTTPClient.shared.execute(
            urlString: "https://api.spaceflightnewsapi.net/v4/articles/",
            method: .get(
                buildQueryParams(searchQuery: query)
            ),
            responseType: SearchResult.self
        )
    }
    
    private func buildQueryParams(searchQuery: String?) -> [URLQueryItem] {
        var items: [URLQueryItem] = [
            .init(name: "format", value: "json"),
            .init(name: "limit", value: "10"),
        ]
        if let searchQuery {
            items.append(.init(name: "search", value: searchQuery))
        }
        return items
    }
}
