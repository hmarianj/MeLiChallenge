import Foundation

// Protocol to enable Dependency Injection.
protocol SearchService {
    func search(query: String?, size: Int, offset: Int) async throws -> SearchResult
}

struct SpaceNewsSearchService: SearchService {
    // Production backend implementation of the SearchService protocol
    func search(query: String?, size: Int, offset: Int) async throws -> SearchResult {
        try await HTTPClient.shared.execute(
            urlString: "https://api.spaceflightnewsapi.net/v4/articles/",
            method: .get(
                buildQueryParams(searchQuery: query, size: size, offset: offset)
            ),
            headers: [
                "Accept": "application/json",
                "User-Agent": "iOSApp/1.0"
            ],
            responseType: SearchResult.self
        )
    }
    
    private func buildQueryParams(
        searchQuery: String?,
        size: Int,
        offset: Int
    ) -> [URLQueryItem] {
        var items: [URLQueryItem] = [
            .init(name: "limit", value: size.description),
            .init(name: "offset", value: offset.description),
        ]
        if let searchQuery, !searchQuery.isEmpty {
            items.append(.init(name: "search", value: searchQuery))
        }
        return items
    }
}
