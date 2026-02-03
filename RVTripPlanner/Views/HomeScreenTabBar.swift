//
//  HomeScreenTabBar.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import SwiftUI

struct HomeScreenTabBar: View {
    
    var body: some View {
        TabView {
            GarageScreen()
                .tabItem {
                    Label("Garage", systemImage: "car.top.door.front.left.open")
                }
            PlacesScreen()
                .tabItem {
                    Label("Places", systemImage: "mappin.and.ellipse")
                }
        }
    }
}

#Preview {
    HomeScreenTabBar()
}
