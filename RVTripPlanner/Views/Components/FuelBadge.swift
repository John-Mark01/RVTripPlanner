//
//  FuelBadge.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import SwiftUI

struct FuelBadge: View {
    let fuel: FuelType
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: fuelIcon)
                .font(.system(size: 10, weight: .semibold))
            
            Text(fuel.rawValue.uppercased())
                .applyFont(.body)
                .applyTextConfiguration(
                    .multiline(
                        alignment: .leading,
                        lines: 1
                    ),
                    descrLabel: "Vehicle's fuel type"
                )
        }
        .foregroundStyle(Color.textPrimary)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(fuelColor.opacity(0.9))
                .shadow(color: fuelColor.opacity(0.4), radius: 4, y: 2)
        )
    }
    
    private var fuelIcon: String {
        switch fuel {
        case .electric:
            return "bolt.fill"
        case .hybrid:
            return "leaf.fill"
        case .diesel, .gas:
            return "fuelpump.fill"
        }
    }
    
    private var fuelColor: Color {
        switch fuel {
        case .electric:
            return Color.green
        case .hybrid:
            return Color.yellow
        case .diesel:
            return Color.orange
        case .gas:
            return Color.blue
        }
    }
}
