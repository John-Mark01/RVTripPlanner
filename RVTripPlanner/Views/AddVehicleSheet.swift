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
    @State private var vehicleYear: Date = Date(timeIntervalSince1970: 918131995)
    @State private var vehicleFuelType: FuelType = .gas
    @State private var vehiclePhotoData: Data?
    
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
        .animation(.smooth, value: vehiclePhotoData)
        .padding(.vertical)
        .onSubmit { moveToNextField() }
        .scrollBounceBehavior(.basedOnSize)
        .background(.ultraThickMaterial)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
                    let vehicle = createVehicle()
                    modelContext.insert(vehicle)
                    dismiss()
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
    
}

#Preview {
    NavigationStack {
        AddVehicleSheet()
    }
    .modelContainer(for: Vehicle.self, inMemory: true)
}
