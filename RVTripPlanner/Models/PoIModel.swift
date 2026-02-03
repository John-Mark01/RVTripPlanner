//
//  PoIModel.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 2.02.26.
//

import Foundation

nonisolated
struct PoIModel: Codable {
    let id: Int
    let name: String
    let url: String
    let primaryCategoryDisplayName: String
    let rating: Int?
    let imageURL: String?
    let loc: [Double] // [longitude, latitude]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case primaryCategoryDisplayName = "primary_category_display_name"
        case rating
        case imageURL = "large_image_url"
        case loc
    }
}
