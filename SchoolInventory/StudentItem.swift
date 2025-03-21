//
//  StudentItem.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 3/19/25.
//


import SwiftUI


struct StudentItem: Identifiable {
    var id = UUID()
    var studentID: String
    var item: String
    var size: String
}
