//
//  HomeScreenTabBar.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import SwiftUI

struct HomeScreenTabBar: View {
    private let poiService: POIService
    init(poiService: POIService) {
        self.poiService = poiService
    }
    
    var body: some View {
        TabView {
            GarageScreen()
                .tabItem {
                    Label("Garage", systemImage: "car.top.door.front.left.open")
                }
            PlacesScreen(poiService: poiService)
                .tabItem {
                    Label("Places", systemImage: "mappin.and.ellipse")
                }
        }
    }
}

#Preview {
    HomeScreenTabBar(
        poiService: MockPoiService()
    )
}
