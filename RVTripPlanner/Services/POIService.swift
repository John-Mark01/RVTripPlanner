//
//
// POIService.swift
// RVTripPlanner
//     
// Created by John-Mark Iliev on 3.02.26
//

import Foundation
import Alamofire

final class POIService {
    let client: HTTPClient
    let urlString: String
    
    init(httpClient: HTTPClient = .init(), urlString: String) {
        self.client = httpClient
        self.urlString = urlString
    }
    
    func getPoIs() async throws -> Result<PoIModel, HTTPError> {
        return await client.request(
            method: .get,
            url: urlString,
            of: PoIModel.self
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
