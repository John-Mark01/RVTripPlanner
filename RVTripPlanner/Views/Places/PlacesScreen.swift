//
//  PlacesScreen.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 3.02.26.
//

import SwiftUI

struct PlacesScreen: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: PlacesScreenViewModel
    @State private var selectedPOI: PoIModel?
    
    init(poiService: POIService) {
        self.viewModel = PlacesScreenViewModel(poiService: poiService)
    }
    
    var body: some View {
        NavigationStack {
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
                }
            }
            .navigationDestination(item: $selectedPOI) { poi in
                PoIDetailsScreen(poi: poi, onSave: {_ in})
            }
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
}
