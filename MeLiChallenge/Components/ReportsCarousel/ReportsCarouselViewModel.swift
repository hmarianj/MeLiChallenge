//
//  ReportsCarouselViewModel.swift
//  MeLiChallenge
//
//  Created by MH on 26/06/2025.
//

import Foundation
import SwiftUI

@MainActor
final class ReportsCarouselViewModel: ObservableObject {
    @Published var reports: [NewsModel]?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private let service: ReportService
    
    init(service: ReportService = SpaceNewsReportService()) {
        self.service = service
    }
    
    func loadReports() async {
        if reports != nil { return }
        do {
            isLoading = true
            error = nil
            let results = try await service.getReports().results
            withAnimation {
                reports = results
                isLoading = false
            }
        } catch {
            self.error = error
        }
    }
}
