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

    var body: some Scene {
        WindowGroup {
            HomeScreenTabBar()
        }
        .modelContainer(for: Vehicle.self)
    }
}
