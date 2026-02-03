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
                        Image(systemName: "suv.side")
                            .resizable()
                    }
                }
                .frame(maxHeight: 120)
                .clipped()
                .padding(16)
                
                // Fuel Badge
                FuelBadge(fuel: fuelType)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 12)
            }
            
            
            VStack(alignment: .leading, spacing: 6) {
                // Make
                Text(vehicle.make)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(.textSecondary)
                    .lineLimit(1)
                
                // Model
                Text(vehicle.model)
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)
                
                // Year
                Text(vehicle.year)
                    .font(.system(.subheadline, design: .rounded, weight: .regular))
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
            Button(action: {
                onEdit(vehicle)
            }) {
                Label("Edit", systemImage: "pencil")
            }
            
            //Delete
            Button(action: {
                onDelete(vehicle)
            }) {
                Label("Delete", systemImage: "trash")
                    .tint(Color.red)
            }
        }
    }
}

#Preview {
    let vehicle = Vehicle(
        make: "Ford",
        model: "Focus 1.6",
        year: "2003",
        fuelType: FuelType.gas.rawValue
    )
    VStack {
        VehicleViewRow(
            vehicle: vehicle,
            onEdit: {_ in},
            onDelete: {_ in}
        )
    }
    .padding(16)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.appBackground)
}
