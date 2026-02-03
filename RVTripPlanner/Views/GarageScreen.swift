//
//  GarageScreen.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import SwiftUI
import SwiftData

struct GarageScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var vehicles: [Vehicle]
    @State private var openSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(vehicles) { vehicle in
                        VehicleViewRow(
                            vehicle: vehicle,
                            onEdit: { _ in},
                            onDelete: { modelContext.delete($0) }
                        )
                    }
                }
                .padding(16)
            }
            .animation(.bouncy, value: vehicles)
            .navigationTitle("Garage")
            .background(Color.appBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        modelContext.insert(
                            Vehicle(
                                make: "Ford",
                                model: "Focus 1.6",
                                year: "2003",
                                fuelType: FuelType.diesel.rawValue
                            )
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GarageScreen()
    }
    .modelContainer(for: Vehicle.self, inMemory: true)
}


