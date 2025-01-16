//
//  Orders.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 1/16/25.
//

import SwiftUI
import SwiftData

@Model
class Order: Hashable {
    var barcodeNumber: Int
    var date: Date
    var size: String
    var clothingItem: String
    init(barcodeNumber: Int, date: Date, size: String, clothingItem: String) {
        self.barcodeNumber = barcodeNumber
        self.date = date
        self.size = size
        self.clothingItem = clothingItem
    }
}
