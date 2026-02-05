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
    
    init(httpClient: HTTPClient, urlString: String) {
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
