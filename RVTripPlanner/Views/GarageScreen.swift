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
           GridItem(.adaptive(minimum: 160, maximum: 200), spacing: 16)
       ]
    
    var body: some View {
        NavigationStack {
            GarageEmptyStateView(condition: vehicles.isEmpty) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
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
            .padding(16)
            .animation(.bouncy, value: vehicles)
            .navigationTitle("Garage")
            .background(Color.appBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        openSheet.toggle()
                    }
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
}

#Preview {
    NavigationStack {
        GarageScreen()
    }
    .modelContainer(for: Vehicle.self, inMemory: true)
}
