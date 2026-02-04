//
//  Extensions+Data.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import Foundation

extension Date {
    func formatToYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        return formatter.string(from: self)
    }
}
