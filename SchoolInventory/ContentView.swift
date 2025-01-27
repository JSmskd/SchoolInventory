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
        TabView {
            HomeView().tabItem{
                Text("Home")
                Image(systemName: "house.fill")
            }
            
            InventoryView().tabItem {
                HStack{
                    Text("Inventory")
                    Image(systemName: "shippingbox")
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
            SearchBarView().tabItem {
                HStack {
                    Text("Search Bar")
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
}
    
#Preview {
    ContentView()
}
