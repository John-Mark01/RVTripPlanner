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
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                
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
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(vehicle.make)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.textPrimary)
                    
                    Text(vehicle.model)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.textSecondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    
                    Label(
                        vehicle.fuelType.capitalized,
                        systemImage: "fuelpump.fill"
                    )
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.textPrimary)
                    
                    
                    Text(vehicle.year)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.textPrimary)
                }
            }
        }
        .padding(16)
        .background(Color.appSecondary.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 8))
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
        fuelType: FuelType.diesel.rawValue
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
