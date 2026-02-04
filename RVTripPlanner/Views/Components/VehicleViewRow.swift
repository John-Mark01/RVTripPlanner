//
//  VehicleViewRow.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import SwiftUI

struct VehicleViewRow: View {
    let vehicle: Vehicle
    
    var onEdit: (Vehicle) -> Void
    var onDelete: (Vehicle) -> Void
    
    private var vehicleImage: UIImage? {
        guard let data = vehicle.imageData else { return nil }
        return UIImage(data: data)
    }
    
    private var fuelType: FuelType {
        FuelType(rawValue: vehicle.fuelType) ?? .hybrid
    }
    
    private var vehicleType: VehicleType {
        VehicleType(rawValue: vehicle.type) ?? .car
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Image Section
            ZStack(alignment: .topTrailing) {
                //Car Image
                Group {
                    if let image = vehicleImage {
                        Image(uiImage: image)
                            .resizable()
                    } else {
                        Image(systemName: vehicleType.systemImage)
                            .resizable()
                            .padding(16)
                    }
                }
                .frame(height: 120)
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20,
                    style: .continuous)
                )
                
                // Fuel Badge
                FuelBadge(fuel: fuelType)
                    .padding(12)
            }
            
            
            VStack(alignment: .leading, spacing: 6) {
                // Make
                Text(vehicle.make)
                    .applyFont(.title)
                    .applyTextConfiguration(
                        .multiline(
                            alignment: .leading,
                            lines: 1
                        ),
                        descrLabel: "Vehicle's make"
                    )
                    .foregroundColor(.textSecondary)
                
                // Model
                Text(vehicle.model)
                    .applyFont(.headline)
                    .applyTextConfiguration(
                        .multiline(
                            alignment: .leading,
                            lines: 1
                        ),
                        descrLabel: "Vehicle's brand model"
                    )
                    .foregroundColor(.textPrimary)
                
                // Year
                Text(vehicle.year.formatToYearString())
                    .applyFont(.subheadline)
                    .applyTextConfiguration(
                        .multiline(
                            alignment: .leading,
                            lines: 1
                        ),
                        descrLabel: "Vehicle's production date"
                    )
                    .foregroundColor(.textTertiary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
        .contextMenu {
            
            //Edit
            Label("Edit", systemImage: "pencil")
                .renderAsButton(action: { onEdit(vehicle) })
            
            //Delete
            Label("Delete", systemImage: "trash")
                .tint(Color.red)
                .renderAsButton(action: { onDelete(vehicle) }, addHaptic: true)
        }
    }
}

#Preview {
    let vehicle = Vehicle(
        type: VehicleType.motorcycle.rawValue,
        make: "Ford",
        model: "Focus 1.6",
        year: Date(),
        fuelType: FuelType.gas.rawValue
    )
    VStack {
        VehicleViewRow(
            vehicle: vehicle,
            onEdit: {_ in},
            onDelete: {_ in}
        )
    }
    .applyViewPaddings(.all)
    .applyBackground()
}
