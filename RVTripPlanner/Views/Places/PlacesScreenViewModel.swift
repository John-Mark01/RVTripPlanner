//
//  PlacesScreenViewModel.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import Foundation

@Observable
final class PlacesScreenViewModel {
    let poiService: POIService
    
    init(poiService: POIService) {
        self.poiService = poiService
    }
    var pois: [PoIModel] = []
    
    var selectedTab: PlacesTabs = .list
    var isLoadingState: Bool = false
    var showAlert: Bool = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    
    func fetchPOIs() async  {
        isLoadingState = true
        defer { isLoadingState = false }
        
        do {
           let result = try await poiService.getPoIs()
            switch result {
            case let .success(dto):
                self.pois = dto.pois
            case let .failure(error):
                print("❌ Error in getting POIs: \(error)")
                showAlert(message: "Something went wrong. Please try again later.")
            }
        } catch {
            print("❌❗️Critical Error: \(error.localizedDescription)")
            showAlert(message: "Something went wrong. Please try again later.")
        }
    }
    
    private func showAlert(message: String) {
        self.showAlert = true
        self.alertTitle = "Error"
        self.alertMessage = message
    }
}
