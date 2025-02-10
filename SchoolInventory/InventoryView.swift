//
//  InventoryView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

struct InventoryView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: ShirtView()) {
                    Text("Shirts")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.darkOrange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SweatpantsView()) {
                    Text("Sweats")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: HoodiesView()) {
                    Text("Hoodies")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.darkOrange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: CrewnecksView()) {
                    Text("Crewnecks")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Inventory")
         
        }
    }
}
