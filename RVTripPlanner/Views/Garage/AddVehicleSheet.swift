//
//  Extensions+Data.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import SwiftUI
import SwiftData

struct AddVehicleSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    //Focus Fields
    @FocusState private var makeIsFocused: Bool
    @FocusState private var modelIsFocused: Bool
    @FocusState private var nicknameIsFocused: Bool
    
    //Inputs
    @State private var vehicleType: VehicleType = .other
    @State private var vehicleMake: String = ""
    @State private var vehicleModel: String = ""
    @State private var vehicleNickname: String = ""
    @State private var vehicleYear: Date = Date().baseCarProductionyear()
    @State private var vehicleFuelType: FuelType = .gas
    @State private var vehiclePhotoData: Data?
    
    //Validation alerts
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        Form {
            Section("Basic Information") {
                
                //Vehicle Type
                Picker("Vehicle Type", selection: $vehicleType) {
                    ForEach(VehicleType.allCases, id: \.self) { type in
                        Label(type.rawValue.capitalized, systemImage: type.systemImage)
                            .symbolEffect(.bounce, value: vehicleType)
                    }
                }
                
                //Make
                CustomTextField(
                    isFocused: _makeIsFocused,
                    input: $vehicleMake,
                    prompt: "Enter vehicle make"
                )
                
                //Model
                CustomTextField(
                    isFocused: _modelIsFocused,
                    input: $vehicleModel,
                    prompt: "Enter vehicle model"
                )
                
                //Production Date
                DatePicker(
                    "Production Date",
                    selection: $vehicleYear,
                    displayedComponents: .date
                )
            }
            
            Section("Additional Infomation") {
                
                //Fuel Type
                Picker("Fuel Type", selection: $vehicleFuelType) {
                    ForEach(FuelType.allCases, id: \.self) { type in
                        Label(type.rawValue.capitalized, systemImage: type.fuelIcon)
                            .tint(type.fuelColor)
                    }
                }
                .tint(vehicleFuelType.fuelColor)
                
                //Nickname
                CustomTextField(
                    isFocused: _nicknameIsFocused,
                    input: $vehicleNickname,
                    prompt: "Enter vehicle nickname"
                )
                
                //Photos Picker
                HStack(alignment: .top) {
                    Label("Vehicle's picture", systemImage: "camera")
                    
                    Spacer()
                    
                    CustomPhotosPicker(
                        vehiclePhotoData: $vehiclePhotoData
                    )
                }
                
            }
        }
        .applyBackground()
        .applyAlertHandling(
            isPresented: $showAlert,
            title: alertTitle,
            message: alertMessage
        )
        .onSubmit { moveToNextField() }
        .animation(.smooth, value: vehiclePhotoData)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
                    if validateFields() {
                        let vehicle = createVehicle()
                        modelContext.insert(vehicle)
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    private func moveToNextField() {
        if makeIsFocused {
            modelIsFocused = true
        }
    }
    
    private func createVehicle() -> Vehicle {
        return Vehicle(
            type: self.vehicleType.rawValue,
            make: self.vehicleMake,
            model: self.vehicleModel,
            year: self.vehicleYear,
            fuelType: self.vehicleFuelType.rawValue,
            imageData: self.vehiclePhotoData,
            nickname: self.vehicleNickname
        )
    }
    
    private func validateFields() -> Bool{
        let vehicle = createVehicle()
        
        if vehicle.make.isEmpty {
            presentAlert(saying: "Vehicle's make is required")
            makeIsFocused = true
            return false
        } else if vehicle.model.isEmpty {
            modelIsFocused = true
            presentAlert(saying: "Vehicle's model is required")
            return false
        } else if vehicle.year == Date().baseCarProductionyear() {
            presentAlert(saying: "Vehicle's year is required")
            return false
        }
        
        return true
    }
    
    private func presentAlert(saying message: String) {
        self.showAlert = true
        self.alertTitle = "Warning"
        self.alertMessage = message
    }
}

#Preview {
    NavigationStack {
        AddVehicleSheet()
    }
    .modelContainer(for: Vehicle.self, inMemory: true)
}
