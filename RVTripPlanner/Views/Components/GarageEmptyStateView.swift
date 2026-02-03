//
//  GarageEmptyStateView.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import SwiftUI

struct GarageEmptyStateView<Content: View>: View {
    let condition: Bool
    @ViewBuilder let content: Content
    
    var body: some View {
        if condition {
            ContentUnavailableView(
                "No vehicles in the garage.",
                systemImage: "car.2.fill",
                description: Text("To add new vehice, tap the + button above.")
            )
            .containerRelativeFrame(.vertical, alignment: .center)
        } else {
            content
        }
    }
}
