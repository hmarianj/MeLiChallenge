//
//  HomeViewModelTests.swift
//  HomeViewModelTests
//
//  Created by MH on 26/06/2025.
//

import XCTest
@testable import MeLiChallenge

@MainActor
final class HomeViewModelTests: XCTestCase {
    func testSearchSuccess() async {
        // Given
        let sut = HomeViewModel(searchService: SearchServiceMock(throwsError: nil))
        // When
        await sut.search(query: nil)
        // Then
        XCTAssertEqual(sut.loadedNews?.count, 2)
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.isFirstLoading)
        XCTAssertFalse(sut.hasMorePages)
    }
    
    func testSearchFailure() async {
        // Given
        let mockError = NSError(domain: "Mock", code: 1)
        let sut = HomeViewModel(searchService: SearchServiceMock(throwsError: mockError))
        // When
        await sut.search(query: nil)
        // Then
        XCTAssertEqual(sut.loadedNews, [])
        XCTAssertEqual(sut.error as? NSError, mockError)
        XCTAssertFalse(sut.isFirstLoading)
    }
}

struct SearchServiceMock: SearchService {
    var throwsError: Error?
    
    func search(query: String?, size: Int, offset: Int) async throws -> SearchResult {
        if let throwsError {
            throw throwsError
        }
        return .init(
            count: 2,
            results: [
                .mock(id: 0),
                .mock(id: 1)
            ]
        )
    }
}
