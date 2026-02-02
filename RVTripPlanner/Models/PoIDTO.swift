//
//  PoIDTO.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 2.02.26.
//

import Foundation

public struct PoIDTO: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let url: String
    public let rating: Double?
    public let largeImageURL: String?
    public let combinedRatingAvg: Double?
    public let loc: [Double] // [longitude, latitude]
    public let primaryCategory: String
    public let primaryCategoryDisplayName: String
    public let categoryGroup: String?
    public let tags: [String]
    public let thumbnailURL: String?
    public let mediumImageURL: String?
    public let price: Int?
    public let bookingPrice: Double?
    public let uberRating: Int?
    public let combinedAvgRating: Double?
    public let engagementScore: Double?
    public let bookingURL: String?
    public let reviewsCount: Int?
    public let openNow: Bool?
    public let bookable: Bool
    public let isChain: Bool
    public let tpcID: String?
    public let allowsPets: Bool
    public let searchablePrice: Double?
    public let bookingProviders: [String]
    public let travelRank: String?
    public let branding: String?
    public let segments: [String]
    
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
