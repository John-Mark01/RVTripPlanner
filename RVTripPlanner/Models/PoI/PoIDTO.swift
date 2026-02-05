//
//  PoIDTO.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import Foundation

nonisolated
struct PoIDTO: Codable {
    let pois: [PoIModel]
    let total: Total
}

nonisolated
struct Total: Codable {
    let value: Int
    let relation: String
}
