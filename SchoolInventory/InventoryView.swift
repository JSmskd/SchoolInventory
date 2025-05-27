//
//  InventoryView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

extension Color {
    static let darkBrown = Color(red: 92/255, green: 64/255, blue: 51/255)
    
}


struct InventoryView: View {
    var body: some View {
      
            NavigationStack {
                ScrollView{
                VStack(spacing: 20) {
                    NavigationLink(destination: BlanksView()) {
                        Text("Blanks")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: ShirtView()) {
                        Text("Shirts")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.darkOrange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SweatpantsView()) {
                        Text("Sweatpants")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.darkBrown)
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
                            .background(Color.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .navigationTitle("Inventory")
                
            }
        }
    }
    }

#Preview {
    InventoryView()
}
