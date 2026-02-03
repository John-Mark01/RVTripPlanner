//
//  Vehicle.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import Foundation
import SwiftData

@Model
final class Vehicle: Identifiable {
    @Attribute(.unique)
    var id: UUID
    var make: String
    var model: String
    var year: String
    var fuelType: String
    var imageData: Data?
    var nickname: String?
    
    init(
        id: UUID = UUID(),
        make: String,
        model: String,
        year: String,
        fuelType: String,
        imageData: Data? = nil,
        nickname: String? = nil
    ) {
        self.id = id
        self.make = make
        self.model = model
        self.year = year
        self.fuelType = fuelType
        self.imageData = imageData
        self.nickname = nickname
    }
}
