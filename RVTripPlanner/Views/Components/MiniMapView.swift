//
//  MiniMapView.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 5.02.26.
//

import SwiftUI
import MapKit

struct MiniMapView: View {
    let longitude: CLLocationDegrees
    let latitude: CLLocationDegrees
    
    
    private var position: MapCameraPosition {
        MapCameraPosition.region(
            .init(
                center: .init(
                    latitude: latitude,
                    longitude: longitude
                ),
                latitudinalMeters: 50,
                longitudinalMeters: 50
            )
        )
    }
    
    private var coordinate: CLLocationCoordinate2D {
        return .init(latitude: latitude, longitude: longitude)
    }
    
    var body: some View {
        Map(initialPosition: position) {
            Marker("", systemImage: "", coordinate: coordinate)
                .mapOverlayLevel(level: .aboveLabels)
        }
        .disabled(true)
        .frame(height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
