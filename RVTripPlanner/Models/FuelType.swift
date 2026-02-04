//
//  FuelType.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import SwiftUI

enum FuelType: String, CaseIterable {
    case gas
    case diesel
    case hybrid
    case electric
    
    var fuelIcon: String {
        switch self {
        case .electric:
            return "bolt.fill"
        case .hybrid:
            return "leaf.fill"
        case .diesel, .gas:
            return "fuelpump.fill"
        }
    }
    
    var fuelColor: Color {
        switch self {
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
