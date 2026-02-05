//
//  RatingStarsRow.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 5.02.26.
//

import SwiftUI

struct RatingStarsRow: View {
    let count: Int = 5
    let rating: Double
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count) { i in
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundStyle(i <= Int(rating) ? .appSecondary : .gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
