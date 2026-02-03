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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Vehicle.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeScreenTabBar()
        }
        .modelContainer(sharedModelContainer)
    }
}
