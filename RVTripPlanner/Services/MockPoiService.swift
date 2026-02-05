//
//  MockPoiService.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 5.02.26.
//

import Foundation

final class MockPoiService: POIService {
    func getPoIs() async throws -> Result<PoIDTO, HTTPError> {
        try await Task.sleep(for: .seconds(2))
        return .failure(.serverError)
    }
    
    private func loadStubbedPOI() -> [PoIDTO] {
        return []
    }
}
