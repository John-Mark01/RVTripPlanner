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
    @Attribute(.unique) var id: UUID
    var type: String
    var make: String
    var model: String
    var year: Date
    var fuelType: String
    var imageData: Data?
    var nickname: String?
    
    init(
        id: UUID = UUID(),
        type: String,
        make: String,
        model: String,
        year: Date,
        fuelType: String,
        imageData: Data? = nil,
        nickname: String? = nil
    ) {
        self.id = id
        self.type = type
        self.make = make
        self.model = model
        self.year = year
        self.fuelType = fuelType
        self.imageData = imageData
        self.nickname = nickname
    }
}
