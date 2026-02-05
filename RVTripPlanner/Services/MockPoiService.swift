//
//  MockPoiService.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 5.02.26.
//

import Foundation

final class MockPoiService: POIService {
    
    func getPoIs() async throws -> Result<PoIDTO, HTTPError> {
        try await Task.sleep(for: .seconds(2))
        return .success(loadStubbedDTO())
    }
    
    private func loadStubbedDTO() -> PoIDTO {
        PoIDTO(
            pois:[
                PoIModel(
                    id: 22606,
                    name: "Cincinnati Museum Center",
                    url: "https://maps.roadtrippers.com",
                    primaryCategoryDisplayName: "Attractions & Culture",
                    rating: 4.5,
                    imageURL: "https://atlas-assets.roadtrippers.com",
                    coordinates: [-84.537158, 39.109946],
                    isOpen: true
                ),
                PoIModel(
                    id: 6291,
                    name: "National Underground Railroad Freedom Center",
                    url: "https://maps.roadtrippers.com",
                    primaryCategoryDisplayName: "Attractions & Culture",
                    rating: 4.5,
                    imageURL: "https://upload.wikimedia.org",
                    coordinates: [-84.5111032, 39.0970834],
                    isOpen: false
                ),
                PoIModel(
                    id: 6283,
                    name: "Cincinnati Music Hall",
                    url: "https://maps.roadtrippers.com",
                    primaryCategoryDisplayName: "Attractions & Culture",
                    rating: 4.5,
                    imageURL: "https://atlas-assets.roadtrippers.com",
                    coordinates: [-84.5190132, 39.1093508],
                    isOpen: false
                ),
                PoIModel(
                    id: 62489,
                    name: "Contemporary Arts Center",
                    url: "https://maps.roadtrippers.com",
                    primaryCategoryDisplayName: "Attractions & Culture",
                    rating: 4.1,
                    imageURL: "https://atlas-assets.roadtrippers.com",
                    coordinates: [-84.5120318, 39.1027114],
                    isOpen: true
                )
            ], total: .init(value: 2, relation: "eq")
        )
    }
}
