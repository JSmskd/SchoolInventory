//
//  BarcodeTextApp.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 12/13/24.
//

import SwiftUI

@main
struct BarcodeTextApp: App {
    
    @StateObject private var vm = BarcodeAppViewModel()
    var body: some Scene {
        WindowGroup {
            BarcodeView()
                .environmentObject(vm)
                .task {
                    await vm.requestDataScannerAccessStatus()
                }
        }
    }
}
