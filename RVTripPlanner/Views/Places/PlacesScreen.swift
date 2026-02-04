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
    
    init(poiService: POIService) {
        self.viewModel = PlacesScreenViewModel(poiService: poiService)
    }
    
    var body: some View {
        NavigationStack {
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
                            POIViewRow(poi: poi)
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
        .navigationTitle("Places")
        .task { await viewModel.fetchPOIs() }
        //LOADING
        .disabled(viewModel.isLoadingState)
        .overlay(alignment: .center) {
            if viewModel.isLoadingState {
                ProgressView()
                    .scaleEffect(2)
            }
        }
        //ALERT
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Text("Dismiss")
                .renderAsButton(action: {viewModel.showAlert = false})
        } message: {
            Text(viewModel.alertMessage)
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
}
