//
//  ReportsCarouselViewModelTests.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import XCTest
@testable import MeLiChallenge

@MainActor
final class ReportsCarouselViewModelTests: XCTestCase {
    func testLoadReportsSuccess() async {
        // Given
        let sut = ReportsCarouselViewModel(service: ReportsServiceMock(throwsError: nil))
        // When
        await sut.loadReports()
        // Then
        XCTAssertEqual(sut.reports?.count, 2)
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testLoadReportsFailure() async {
        // Given
        let mockError = NSError(domain: "Mock", code: 1)
        let sut = ReportsCarouselViewModel(service: ReportsServiceMock(throwsError: mockError))
        // When
        await sut.loadReports()
        // Then
        XCTAssertNil(sut.reports)
        XCTAssertEqual(sut.error as? NSError, mockError)
        XCTAssertFalse(sut.isLoading)
    }
}

struct ReportsServiceMock: ReportService {
    var throwsError: Error?
    
    func getReports() async throws -> SearchResult {
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
