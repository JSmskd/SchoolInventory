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
    @State private var items: [String] = ["Blanks", "Shirts", "Sweatpants", "Hoodies", "Crewnecks"]
    @State private var newItemName: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Dynamically displaying the items
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: Text("\(item) View")) {
                            Text(item)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(item == "Shirts" || item == "Hoodies" ? Color.darkOrange : Color.darkBrown)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    // TextField for adding a new item
                    TextField("Enter new item name", text: $newItemName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // Button to add the new item
                    Button(action: {
                        if !newItemName.isEmpty {
                            items.append(newItemName)
                            newItemName = "" // Clear the text field after adding
                        }
                    }) {
                        Text("Add Item")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
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
