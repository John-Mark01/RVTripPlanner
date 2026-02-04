//
//  Extensions+Data.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import UIKit

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
