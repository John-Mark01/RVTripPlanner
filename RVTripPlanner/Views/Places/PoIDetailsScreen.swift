//
//  PoIDetailsScreen.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 5.02.26.
//

import SwiftUI
import SwiftData

struct PoIDetailsScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    let poi: PoIModel
    @State var isSaved: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: AppConstants.vstackSpacing) {
            
            //Description
            Text(poi.primaryCategoryDisplayName)
                .applyFont(.headline)
                .foregroundStyle(Color.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //Mini-Map
            MiniMapView(
                longitude: poi.coordinates[0],
                latitude: poi.coordinates[1]
            )
            
            
            //Rating
            HStack(spacing: AppConstants.vstackSpacing / 2) {
                if let rating = poi.rating {
                    Text("Rating Score:")
                        .applyFont(.title)
                        .foregroundStyle(Color.textPrimary)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        ForEach(0..<5) { i in
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundStyle(i <= Int(rating) ? .appSecondary : .gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            //Save to Favourites
            Toggle(
                "Add to Favourites",
                isOn: $isSaved
            )
            .applyFont(.title)
            
            Spacer()
            
            //Open in Browser button
            Button {
                if let url = URL(string: poi.url) {
                    UIApplication.shared.open(url)
                }
            } label: {
                Label("Open in Browser", systemImage: "network")
            }
            .buttonStyle(.borderless)
            
        }
        .applyViewPaddings(.all)
        .applyBackground()
        .navigationTitle(poi.name)
        .onChange(of: isSaved) { _, newValue in
            let model = createFavoutirePoI()
            if newValue {
                modelContext.insert(model)
            } else {
                modelContext.delete(model)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                OpenClosedBadge(isOpen: poi.isOpen)
            }
        }
    }
    
    private func toggleAction(_ isTurningOn: Bool) {
        let model = createFavoutirePoI()
        if isTurningOn {
            modelContext.insert(model)
        } else {
            modelContext.delete(model)
        }
    }
    
    private func createFavoutirePoI() -> FavouritePoI {
        return FavouritePoI(
            id: poi.id,
            name: poi.name,
            url: poi.url,
            primaryCategoryDisplayName: poi.primaryCategoryDisplayName,
            rating: poi.rating,
            imageURL: poi.imageURL,
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
        coordinates: [-84.5186503, 39.084502],
        isOpen: true
    )
    NavigationStack {
        PoIDetailsScreen(
            poi: poi,
            isSaved: true
        )
    }
    .modelContainer(for: FavouritePoI.self, inMemory: true)
}
