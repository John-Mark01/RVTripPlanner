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
    private let poiService = POIServiceImpl(urlString: AppConstants.httpClientURL)
    
    var body: some Scene {
        WindowGroup {
            HomeScreenTabBar(poiService: poiService)
        }
        .modelContainer(for: [Vehicle.self, FavouritePoI.self])
    }
}
