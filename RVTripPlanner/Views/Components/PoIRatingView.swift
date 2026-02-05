//
//  PoIRatingView.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 5.02.26.
//

import SwiftUI

struct PoIRatingView: View {
    let ratingScore: Double?
    
    var body: some View {
        HStack(spacing: AppConstants.vstackSpacing / 2) {
            if let rating = ratingScore {
                Text("Rating Score:")
                    .applyFont(.title)
                    .foregroundStyle(Color.textPrimary)
                
                Spacer()
                
                
                RatingStarsRow(rating: rating)
            }
        }
    }
}
