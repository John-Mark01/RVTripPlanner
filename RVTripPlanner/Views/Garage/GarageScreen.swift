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
    @State private var selectedVehicle: Vehicle?
    
    private let columns = [
        GridItem(.adaptive(minimum: 160, maximum: 200), spacing: AppConstants.vstackSpacing)
    ]
    
    var body: some View {
        GarageEmptyStateView(condition: vehicles.isEmpty) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: AppConstants.vstackSpacing) {
                    ForEach(vehicles) { vehicle in
                        VehicleViewRow(
                            vehicle: vehicle,
                            onEdit: { selectedVehicle = $0 },
                            onDelete: { modelContext.delete($0) }
                        )
                    }
                }
            }
        }
        .applyViewPaddings(.all)
        .applyBackground()
        .animation(.bouncy, value: vehicles)
        .navigationTitle("Garage")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "plus")
                    .renderAsButton(
                        action: { openSheet.toggle() },
                        addHaptic: true
                    )
            }
        }
        .sheet(isPresented: $openSheet) {
            NavigationStack {
                AddVehicleSheet()
            }
        }
        .sheet(item: $selectedVehicle) { vehicle in
            NavigationStack {
                EditVehicleSheet(vehicle: vehicle)
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
