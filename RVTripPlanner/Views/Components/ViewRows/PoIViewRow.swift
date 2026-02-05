//
//  PoIViewRow.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import SwiftUI

struct PoIViewRow: View {
    let poi: PoIModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            //POI Image + Badge
            ZStack(alignment: .topTrailing) {
                
                AsyncImage(url: URL(string: poi.imageURL ?? "")) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image(systemName: "tree.circle")
                        .resizable()
                        .padding(16)
                }
                .frame(height: 200)
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20,
                    style: .continuous)
                )
                
                //Badge
                OpenClosedBadge(isOpen: poi.isOpen)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                
                // Name
                Text(poi.name)
                    .applyFont(.title)
                    .applyTextConfiguration(
                        .multiline(
                            alignment: .leading,
                            lines: 1
                        ),
                        descrLabel: "Point of Interest's name"
                    )
                    .foregroundColor(.textSecondary)
                
                // Category
                Text(poi.primaryCategoryDisplayName)
                    .applyFont(.headline)
                    .applyTextConfiguration(
                        .multiline(
                            alignment: .leading,
                            lines: 1
                        ),
                        descrLabel: "Point of Interest's category"
                    )
                    .foregroundColor(.textPrimary)
                
                //Rating stars
                if let rating = poi.rating {
                    RatingStarsRow(rating: rating)
                        .padding(.top, 4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    let poi = PoIModel(
        id: 1,
        name: "Alaska",
        url: "fkjdslja",
        primaryCategoryDisplayName: "America's coldest wonders",
        rating: 3,
        imageURL: nil,
        coordinates: [],
        isOpen: false
    )
    
    VStack {
        PoIViewRow(poi: poi)
    }
    .applyViewPaddings(.all)
    .applyBackground()
}
