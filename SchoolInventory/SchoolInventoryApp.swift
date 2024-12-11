//
//  SchoolInventoryApp.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 12/5/24.
//

import SwiftUI
import Firebase

@main
struct SchoolInventoryApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
