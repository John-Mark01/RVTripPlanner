//
//  PlacesScreen.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import SwiftUI
import SwiftData

struct PlacesScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .smooth) private var favourites: [FavouritePoI]
    
    @State private var viewModel: PlacesScreenViewModel
    
    init(poiService: POIService) {
        self.viewModel = PlacesScreenViewModel(poiService: poiService)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            //Segments
            Picker("", selection: $viewModel.selectedTab) {
                ForEach(PlacesTabs.allCases, id: \.self) { tab in
                    Text(tab.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .applyViewPaddings(.all)
            
            switch viewModel.selectedTab {
            case .list:
                List {
                    //Favourites/Saved Section
                    if !favourites.isEmpty {
                        Section {
                            ForEach(favourites, id: \.id) { savedPoi in
                                PoIViewRow(
                                    imageURLString: savedPoi.imageURL,
                                    name: savedPoi.name,
                                    categoryName: savedPoi.primaryCategoryDisplayName,
                                    isOpen: savedPoi.isOpen,
                                    rating: savedPoi.rating
                                )
                            }
                            .onDelete { deleteFavouritePOI(at: $0) }
                            
                        } header: {
                            Text("Favourites")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundStyle(.textPrimary)
                        }
                    }
                    
                    //Recieved from Server Section
                    Section {
                        ForEach(viewModel.pois, id: \.id) { poi in
                            if !favourites.contains(where: { $0.id == poi.id }) {
                                PoIViewRow(
                                    imageURLString: poi.imageURL,
                                    name: poi.name,
                                    categoryName: poi.primaryCategoryDisplayName,
                                    isOpen: poi.isOpen,
                                    rating: poi.rating
                                )
                                .onTapGesture { viewModel.selectedPOI = poi }
                            }
                        }
                    } header: {
                        Text("New")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundStyle(.textPrimary)
                    }
                }
                .listStyle(.plain)
                .listSectionSpacing(AppConstants.vstackSpacing * 2)
                .listRowSpacing(AppConstants.vstackSpacing / 2)
                .listRowSeparator(.hidden)
                .scrollContentBackground(.hidden)
                
            case .map:
                EmptyView()
                
                Spacer()
            }
        }
        .applyBackground()
        .applyLoadingDialog(when: viewModel.isLoadingState)
        .applyAlertHandling(
            isPresented: $viewModel.showAlert,
            title: viewModel.alertTitle,
            message: viewModel.alertMessage
        )
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationTitle("Places")
        .navigationDestination(item: $viewModel.selectedPOI) { poi in
            let isSaved = favourites.contains(where: { $0.id == poi.id })
            PoIDetailsScreen(poi: poi, isSaved: isSaved)
        }
        .task { await viewModel.fetchPOIs() }
    }
    
    private func deleteFavouritePOI(at indexSet: IndexSet) {
        for i in indexSet {
            modelContext.delete(favourites[i])
        }
    }
}

enum PlacesTabs: String, CaseIterable {
    case list
    case map
}

#Preview {
    NavigationStack {
        PlacesScreen(
            poiService: MockPoiService()
        )
    }
    .modelContainer(for: FavouritePoI.self, inMemory: true)
}
