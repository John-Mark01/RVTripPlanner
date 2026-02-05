//
//
// HTTPClient.swift
// RVTripPlanner
//     
// Created by John-Mark Iliev on 3.02.26
//

import Foundation
import Alamofire


protocol HTTPClient {
    func request<T: Decodable & Sendable>(method: HTTPMethod, url: String, of: T.Type) async -> Result<T, AFError>
}

actor HTTPClientImpl: HTTPClient {
    func request<T: Decodable>(
        method: HTTPMethod,
        url: String,
        of type: T.Type
    ) async -> Result<T, AFError> {
        
        let response = await
        AF.request(
            url,
            method: method
        )
        .serializingDecodable(T.self)
        .response
        
        log(response.data)
        return response.result
    }
    
    private func log(_ response: Data?) {
        if let response {
            let message = String(data: response, encoding: .utf8) ?? "/NULL/"
            print("🛜 HTTPClient:\n\(message)")
        }
    }
}
