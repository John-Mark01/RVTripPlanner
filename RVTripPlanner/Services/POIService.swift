//
//
// POIService.swift
// RVTripPlanner
//     
// Created by John-Mark Iliev on 3.02.26
//

import Foundation
import Alamofire

protocol POIService {
    func getPoIs() async throws -> Result<PoIDTO, HTTPError>
}

final class POIServiceImpl: POIService {
    let client: HTTPClient
    let urlString: String
    
    init(httpClient: HTTPClient = .init(), urlString: String) {
        self.client = httpClient
        self.urlString = urlString
    }
    
    func getPoIs() async throws -> Result<PoIDTO, HTTPError> {
        return await client.request(
            method: .get,
            url: urlString,
            of: PoIDTO.self
        )
        .mapError { error in
            switch error {
            case .responseSerializationFailed(_):
                return .decodingError
            default:
                return .serverError
            }
        }
    }
}

final class MockPoiService: POIService {
    func getPoIs() async throws -> Result<PoIDTO, HTTPError> {
        try await Task.sleep(for: .seconds(2))
//        return .success(.init(pois: [.init(id: 1, name: "Name", url: "fjkaldlskj", primaryCategoryDisplayName: "Country road", rating: nil, imageURL: nil, loc: []), .init(id: 2, name: "Name", url: "fjkaldlskj", primaryCategoryDisplayName: "Country road", rating: nil, imageURL: nil, loc: [])], total: .init(value: 2, relation: "")))
        return .failure(.serverError)
    }
    
    private func loadStubbedPOI() -> [PoIDTO] {
        return []
    }
}
