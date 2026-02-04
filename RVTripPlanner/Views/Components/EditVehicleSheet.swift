
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
                Picker("Vehicle Type", selection: $vehicleType) {
                    ForEach(VehicleType.allCases, id: \.self) { type in
                        Label(type.rawValue.capitalized, systemImage: type.systemImage)
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
        .animation(.smooth, value: vehicle)
        .padding(.vertical)
        .onSubmit { moveToNextField() }
        .scrollBounceBehavior(.basedOnSize)
        .background(.ultraThickMaterial)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
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
    
}

#Preview {
    @Previewable @State var vehicle: Vehicle = .init(make: "Toyota", model: "Camry", year: Date(), fuelType: "diesel")
    NavigationStack {
        EditVehicleSheet(vehicle: vehicle)
    }
}

struct CustomTextField: View {
    @FocusState var isFocused: Bool
    @Binding var input: String
    var title: any StringProtocol = ""
    var prompt: any StringProtocol
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(title, text: $input, prompt: Text(prompt))
            .focused($isFocused)
            .onTapGesture { isFocused = true }
            .keyboardType(keyboardType)
    }
}

struct CustomPhotosPicker: View {
    @State private var photoStream: PhotosPickerItem?
    @Binding var vehiclePhotoData: Data?
    
    var body: some View {
        PhotosPicker(selection: $photoStream) {
            if let imageData = vehiclePhotoData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .contextMenu {
                        Button(action: {
                            self.vehiclePhotoData = nil
                            self.photoStream = nil
                        }) {
                            Label("Remove Photo", systemImage: "trash")
                        }
                        .tint(.red)
                    }
            } else {
                Label("", systemImage: "plus")
            }
        }
        .onChange(of: photoStream) {
            Task {
                let newValue = try? await photoStream?.loadTransferable(type: Data.self)
                guard let newValue, !newValue.isEmpty else { return }
                guard let transformedData = newValue.transformIntoImageData() else { return }
                
                self.photoStream = nil
                vehiclePhotoData = transformedData
            }
        }
    }
}
