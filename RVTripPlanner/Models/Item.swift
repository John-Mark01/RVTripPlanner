//
//  Item.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 2.02.26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
