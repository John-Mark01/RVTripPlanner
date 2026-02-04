//
//  PoIModel.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 2.02.26.
//

import Foundation

nonisolated
struct PoIModel: Codable, Hashable {
    let id: Int
    let name: String
    let url: String
    let primaryCategoryDisplayName: String
    let rating: Double?
    let imageURL: String?
    let coordinates: [Double] // [longitude, latitude]
    let isOpen: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case primaryCategoryDisplayName = "primary_category_display_name"
        case rating
        case imageURL = "v_320x320_url"
        case coordinates = "loc"
        case isOpen = "open_now"
    }
}
