//
//  Extensions+Data.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import SwiftUI

struct EditVehicleSheet: View {
    @Environment(\.dismiss) private var dismiss

    @Bindable var vehicle: Vehicle
    
    //Focus Fields
    @FocusState private var makeIsFocused: Bool
    @FocusState private var modelIsFocused: Bool
    @FocusState private var nicknameIsFocused: Bool
    
    //Inputs
    @State private var vehicleType: VehicleType = .other
    
    var body: some View {
        Form {
            Section("Basic Information") {
                
                //Vehicle Type
                Picker("Vehicle Type", selection: Binding(
                    get: { VehicleType(rawValue: vehicle.type) ?? .other },
                    set: { vehicle.fuelType = $0.rawValue })
                ) {
                    ForEach(VehicleType.allCases, id: \.self) { type in
                        Label(
                            type.rawValue.capitalized,
                            systemImage: type.systemImage
                        )
                        .symbolEffect(.bounce, value: vehicleType)
                    }
                }
                
                //Make
                CustomTextField(
                    isFocused: _makeIsFocused,
                    input: $vehicle.make,
                    prompt: "Enter vehicle make"
                )
                
                //Model
                CustomTextField(
                    isFocused: _modelIsFocused,
                    input: $vehicle.model,
                    prompt: "Enter vehicle model"
                )
                
                //Production Date
                DatePicker(
                    "Production Date",
                    selection: $vehicle.year,
                    displayedComponents: .date
                )
            }
            
            Section("Additional Infomation") {
                
                //Fuel Type
                Picker("Fuel Type", selection: Binding(
                    get: { FuelType(rawValue: vehicle.fuelType.lowercased()) ?? .gas},
                    set: { vehicle.fuelType = $0.rawValue })
                ) {
                    ForEach(FuelType.allCases, id: \.self) { type in
                        Label(type.rawValue.capitalized, systemImage: type.fuelIcon)
                            .tint(type.fuelColor)
                    }
                }
                
                //Nickname
                CustomTextField(
                    isFocused: _nicknameIsFocused,
                    input: Binding(
                        get: { vehicle.nickname ?? "" },
                        set: { vehicle.nickname = $0 }
                    ),
                    prompt: "Enter vehicle nickname"
                )
                
                //Photos Picker
                HStack(alignment: .top) {
                    Label("Vehicle's picture", systemImage: "camera")
                    
                    Spacer()
                    
                    CustomPhotosPicker(vehiclePhotoData: $vehicle.imageData)
                }
                
            }
        }
        .applyBackground()
        .animation(.smooth, value: vehicle)
        .onSubmit { moveToNextField() }
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Image(systemName: "xmark")
                    .renderAsButton(action: { dismiss() })
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Image(systemName: "checkmark")
                    .renderAsButton(
                        action: { dismiss() },
                        addHaptic: true
                    )
                    .buttonStyle(.borderedProminent)
            }
        }
    }
    
    private func moveToNextField() {
        if makeIsFocused {
            modelIsFocused = true
        }
    }
}

#Preview {
    @Previewable @State var vehicle = Vehicle(
        type: VehicleType.car.rawValue,
        make: "Toyota",
        model: "Camry",
        year: Date(),
        fuelType: "diesel"
    )
    NavigationStack {
        EditVehicleSheet(vehicle: vehicle)
    }
}
