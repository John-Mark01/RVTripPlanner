//
//  CustomPhotosPicker.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import SwiftUI
import PhotosUI

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
