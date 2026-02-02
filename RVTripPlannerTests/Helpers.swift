//
//  Helpers.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 2.02.26.
//

class TestHelpers {
    static func makePOI() -> PoIDTO {
        return PoIDTO(
            id: 6291,
            name: "National Underground Railroad Freedom Center",
            url: "https://maps.roadtrippers.com/us/cincinnati-oh/attractions/national-underground-railroad-freedom-center",
            rating: 4.5,
            largeImageURL: "https://upload.wikimedia.org/wikipedia/commons/6/6d/NationalUndergroundRailroadFreedomCenter.jpg",
            combinedRatingAvg: nil,
            loc: [-84.5111032, 39.0970834],
            primaryCategory: "attractions",
            primaryCategoryDisplayName: "Attractions & Culture",
            categoryGroup: "history",
            tags: ["history-museum"],
            thumbnailURL: "https://upload.wikimedia.org/wikipedia/commons/6/6d/NationalUndergroundRailroadFreedomCenter.jpg",
            mediumImageURL: "https://upload.wikimedia.org/wikipedia/commons/6/6d/NationalUndergroundRailroadFreedomCenter.jpg",
            price: 1,
            bookingPrice: nil,
            uberRating: 20953500,
            combinedAvgRating: 4.5,
            engagementScore: nil,
            bookingURL: nil,
            reviewsCount: 5,
            openNow: false,
            bookable: false,
            isChain: false,
            tpcID: "56958113",
            allowsPets: false,
            searchablePrice: nil,
            bookingProviders: [],
            travelRank: "3.786",
            branding: nil,
            segments: ["museums"]
        )
    }
}
