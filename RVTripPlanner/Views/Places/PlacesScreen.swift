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
    @Query private var favourites: [FavouritePoI]
    
    @State private var viewModel: PlacesScreenViewModel
    @State private var selectedPOI: PoIModel?
    
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
                    Section {
                        ForEach(viewModel.pois, id: \.id) { poi in
                            PoIViewRow(poi: poi)
                                .overlay(alignment: .topLeading) {
                                    if favourites.contains(where: { $0.id == poi.id }) {
                                        Image(systemName: "star.circle")
                                            .font(.largeTitle)
                                            .foregroundStyle(.yellow)
                                            .padding(10)
                                    }
                                }
                                .onTapGesture { selectedPOI = poi }
                        }
                    } header: {
                        Text("New")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundStyle(.textPrimary)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowSpacing(AppConstants.vstackSpacing / 2)
                .applyBackground()
                
            case .map:
                EmptyView()
                
                Spacer()
            }
        }
        .navigationDestination(item: $selectedPOI) { poi in
            let isSaved = favourites.contains(where: { $0.id == poi.id })
            PoIDetailsScreen(poi: poi, isSaved: isSaved)
        }
        .navigationTitle("Places")
        .task { await viewModel.fetchPOIs() }
        .toolbarBackground(.hidden, for: .navigationBar)
        .applyLoadingDialog(when: viewModel.isLoadingState)
        .applyAlertHandling(
            isPresented: $viewModel.showAlert,
            title: viewModel.alertTitle,
            message: viewModel.alertMessage
        )
        
        
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
