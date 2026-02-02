//
//  PoIDTO.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 2.02.26.
//

import Foundation

struct PoIDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let url: String
    let rating: Double?
    let largeImageURL: String?
    let combinedRatingAvg: Double?
    let loc: [Double] // [longitude, latitude]
    let primaryCategory: String
    let primaryCategoryDisplayName: String
    let categoryGroup: String?
    let tags: [String]
    let thumbnailURL: String?
    let mediumImageURL: String?
    let price: Int?
    let bookingPrice: Double?
    let uberRating: Int?
    let combinedAvgRating: Double?
    let engagementScore: Double?
    let bookingURL: String?
    let reviewsCount: Int?
    let openNow: Bool?
    let bookable: Bool
    let isChain: Bool
    let tpcID: String?
    let allowsPets: Bool
    let searchablePrice: Double?
    let bookingProviders: [String]
    let travelRank: String?
    let branding: String?
    let segments: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case rating
        case largeImageURL = "large_image_url"
        case combinedRatingAvg = "combined_rating_avg"
        case loc
        case primaryCategory = "primary_category"
        case primaryCategoryDisplayName = "primary_category_display_name"
        case categoryGroup = "category_group"
        case tags
        case thumbnailURL = "v_145x145_url"
        case mediumImageURL = "v_320x320_url"
        case price
        case bookingPrice = "booking_price"
        case uberRating = "uber_rating"
        case combinedAvgRating = "combined_avg_rating"
        case engagementScore = "engagement_score"
        case bookingURL = "booking_url"
        case reviewsCount = "reviews_count"
        case openNow = "open_now"
        case bookable
        case isChain = "is_chain"
        case tpcID = "tpc_id"
        case allowsPets = "allows_pets"
        case searchablePrice = "searchable_price"
        case bookingProviders = "booking_providers"
        case travelRank = "travel_rank"
        case branding
        case segments
    }
}
