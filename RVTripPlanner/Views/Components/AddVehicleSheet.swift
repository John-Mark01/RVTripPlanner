import SwiftUI
import PhotosUI

struct AddVehicleSheet: View {
    @Environment(\.dismiss) private var dismiss

    //Focus Fields
    enum FocusedFields {
        case make, model, nickname
    }
    @FocusState private var focusedField: FocusedFields?
    
    //PhotosUI
    @State private var photoStream: PhotosPickerItem?
    @State private var vehiclePhotoData: Data?
    
    //Inputs
    @State private var vehicleMake: String = ""
    @State private var vehicleModel: String = ""
    @State private var vehicleNickname: String = ""
    @State private var vehicleYear: Date = Date(timeIntervalSince1970: 918131995)
    @State private var vehicleFuelType: FuelType = .gas
    @State private var vehicleType: VehicleType = .other
    
    var body: some View {
        Form {
            Section("Basic Information") {
                Picker("Vehicle Type", selection: $vehicleType) {
                    ForEach(VehicleType.allCases, id: \.self) { type in
                        Label(type.rawValue.capitalized, systemImage: type.systemImage)
                            .symbolEffect(.bounce, value: vehicleType)
                    }
                }
                TextField("", text: $vehicleMake, prompt: Text("Enter vehicle make"))
                    .focused($focusedField, equals: .make)
                    .onTapGesture { focusedField = .make }
                
                TextField("", text: $vehicleModel, prompt: Text("Enter vehicle model"))
                    .focused($focusedField, equals: .model)
                    .onTapGesture { focusedField = .model }
                
                DatePicker("Production Date", selection: $vehicleYear, displayedComponents: .date)
            }
            
            Section("Additional Infomation") {
                Picker("Fuel Type", selection: $vehicleFuelType) {
                    ForEach(FuelType.allCases, id: \.self) { type in
                        Label(type.rawValue.capitalized, systemImage: type.fuelIcon)
                            .tint(type.fuelColor)
                    }
                }
                .tint(vehicleFuelType.fuelColor)

                TextField("", text: $vehicleNickname, prompt: Text("Enter vehicle nickname"))
                    .focused($focusedField, equals: .nickname)
                    .onTapGesture { focusedField = .nickname }

                HStack(alignment: .top) {
                    Label("Vehicle's picture", systemImage: "camera")
                    
                    Spacer()
                    
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
                }
                
            }
        }
        .animation(.smooth, value: vehiclePhotoData)
        .padding(.vertical)
        .onSubmit { moveToNextField() }
        .scrollBounceBehavior(.basedOnSize)
        .background(.ultraThickMaterial)
        .onChange(of: photoStream) {
            Task {
                let newValue = try? await photoStream?.loadTransferable(type: Data.self)
                guard let newValue, !newValue.isEmpty else { return }
                guard let transformedData = newValue.transformIntoImageData() else { return }
                
                self.photoStream = nil
                self.vehiclePhotoData = transformedData
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
                    let vehicle = createVehicle()
                    //save to modelContext
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    private func moveToNextField() {
        switch focusedField {
        case .make:
            focusedField = .model
        default:
            break
        }
    }
    
    private func createVehicle() -> Vehicle {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        print(formatter.string(from: self.vehicleYear))
        return Vehicle(
            make: self.vehicleMake,
            model: self.vehicleModel,
            year: formatter.string(from: self.vehicleYear),
            fuelType: self.vehicleFuelType.rawValue,
            imageData: self.vehiclePhotoData,
            nickname: self.vehicleNickname
        )
    }
    
}

extension Data {
    func transformIntoImageData() -> Data? {
        let image = UIImage(data: self)
        let size = CGSize(width: 300, height: 300)
        if let thumb = image?.preparingThumbnail(of: size) {
            return thumb.jpegData(compressionQuality: 1.0)
        }
        return nil
    }
}

#Preview {
    NavigationStack {
        AddVehicleSheet()
    }
}

enum VehicleType: String, CaseIterable, Hashable {
    case car
    case truck
    case motorcycle
    case other
    
    var systemImage: String {
        switch self {
        case .car:
            "car.side"
        case .truck:
            "truck.pickup.side"
        case .motorcycle:
            "motorcycle"
        case .other:
            "bicycle"
        }
    }
}

enum FuelType: String, CaseIterable {
    case gas
    case diesel
    case hybrid
    case electric
    
    var fuelIcon: String {
        switch self {
        case .electric:
            return "bolt.fill"
        case .hybrid:
            return "leaf.fill"
        case .diesel, .gas:
            return "fuelpump.fill"
        }
    }
    
    var fuelColor: Color {
        switch self {
        case .electric:
            return Color.green
        case .hybrid:
            return Color.yellow
        case .diesel:
            return Color.orange
        case .gas:
            return Color.blue
        }
    }
}
