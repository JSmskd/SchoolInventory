//
//  ContentView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 12/5/24.
//


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
            

            SearchBarView().tabItem {
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
            TotalOrdersView().tabItem {
                            Image(systemName: "text.page.fill")
                            Text("Total Orders")
                        }


        }
    }
}
