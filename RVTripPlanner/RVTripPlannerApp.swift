//
//  RVTripPlannerApp.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 2.02.26.
//

import SwiftUI
import SwiftData

@main
struct RVTripPlannerApp: App {
    private let poiService = POIServiceImpl(
        urlString: "https://api2.roadtrippers.com/api/v2/pois/discover?sw_corner=-84.540499,39.079888&ne_corner=-84.494260,39.113254&page_size=50"
    )
    
    var body: some Scene {
        WindowGroup {
            HomeScreenTabBar(poiService: poiService)
        }
        .modelContainer(for: Vehicle.self)
    }
}
