//
//  FavouritePoI.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 5.02.26.
//

import Foundation
import SwiftData

@Model
final class FavouritePoI: Identifiable {
    @Attribute(.unique) var id: Int
    var name: String
    var url: String
    var primaryCategoryDisplayName: String
    var rating: Double?
    var imageURL: String?
    var isOpen: Bool?
    
    init(id: Int, name: String, url: String, primaryCategoryDisplayName: String, rating: Double? = nil, imageURL: String? = nil, isOpen: Bool? = nil) {
        self.id = id
        self.name = name
        self.url = url
        self.primaryCategoryDisplayName = primaryCategoryDisplayName
        self.rating = rating
        self.imageURL = imageURL
        self.isOpen = isOpen
    }
}


