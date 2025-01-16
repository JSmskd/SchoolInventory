//
//  ContentView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 12/5/24.
//

//working on moving app to playgrounds
//getting rid of playgrounds errors 

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
                HStack{
                    Text("Barcode")
                    Image(systemName: "barcode")
                }
            }
            
            InventoryView().tabItem {
                HStack{
                    Text("Inventory")
                    Image(systemName: "shippingbox")
                }
            }
            
            ManuallyEnterView().tabItem {
                HStack{
                    Text("Manually Enter")
                    Image(systemName: "square.and.pencil")
                }
            }
            
            StudentOrdersView().tabItem {
                HStack{
                    Text("Online")
                    Image(systemName: "desktopcomputer")
                }
            }
            
            WalkUpView().tabItem {
                HStack{
                    Text("Walk Up")
                    Image(systemName: "figure.walk")
                }
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
