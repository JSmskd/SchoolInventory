//
//  ContentView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 12/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack(spacing: 0) { // Set spacing to 0
            Image("DawgPound")
                .resizable()
                .frame(width: 300, height: 175)
            Text("INVENTORY")
                .font(.custom("Impact", size: 70))
                .foregroundColor(.darkOrange)
        }
        
        .padding()
        
        TabView {
            BarcodeView().tabItem {
                Text("Barcode")
            }
            
            InventoryView().tabItem {
                Text("Inventory")
            }
            
            ManuallyEnterView().tabItem {
                Text("Manually Enter")
            }
            
            StudentOrdersView().tabItem {
                Text("Online")
            }
            
            WalkUpView().tabItem {
                Text("Walk Up")
            }
        }
    }
}

extension Color {
    static let darkOrange = Color(red: 244/255, green: 108/255, blue: 44/255)
}
    
#Preview {
    ContentView()
}
