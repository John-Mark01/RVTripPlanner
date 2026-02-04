//
//  VehicleType.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import Foundation

enum VehicleType: String, CaseIterable, Hashable {
    case car
    case truck
    case motorcycle
    case other
    
    var systemImage: String {
        switch self {
        case .car:
            "car.side"
        case .truck:
            "truck.pickup.side"
        case .motorcycle:
            "motorcycle"
        case .other:
            "bicycle"
        }
    }
}
