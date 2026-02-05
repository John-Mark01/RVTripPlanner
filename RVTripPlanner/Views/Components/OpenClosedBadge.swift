//
//  OpenClosedBadge.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 5.02.26.
//

import SwiftUI

struct OpenClosedBadge: View {
    let isOpen: Bool
    
    var body: some View {
        let color = isOpen ? Color(.systemGreen) : Color(.systemRed)
        
        Text(isOpen ? "Open now" : "Closed")
            .applyFont(.headline)
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(
                Capsule()
                    .fill(color.opacity(0.9))
                    .shadow(color: color.opacity(0.4), radius: 4, y: 2)
            )
            .padding(12)
    }
}
