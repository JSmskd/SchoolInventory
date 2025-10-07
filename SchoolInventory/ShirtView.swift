//
//  ShirtView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/6/25.
//

import SwiftUI

struct ShirtView: View {
    @State private var isEditing = false
    @State private var showEditSheet = false
    @State private var selectedShirt: String = ""
    @State private var editedName: String = ""
    @State private var editedSmall: Int = 0
    @State private var editedMedium: Int = 0
    @State private var editedLarge: Int = 0
    
    @State private var gildanName = "Gildan5000"
    @State private var bellaName = "Bella3001CVC"
    @State private var gildanSmallQuantity = 0
    @State private var gildanMediumQuantity = 0
    @State private var gildanLargeQuantity = 0
    @State private var bellaSmallQuantity = 0
    @State private var bellaMediumQuantity = 0
    @State private var bellaLargeQuantity = 0
    
    @State private var stockAlertMessage = ""
    @State private var showStockAlert = false  
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        VStack {
                            ShirtItemView(
                                name: $gildanName,
                                small: $gildanSmallQuantity,
                                medium: $gildanMediumQuantity,
                                large: $gildanLargeQuantity,
                                imageName: "Gildan5000",
                                onEdit: {
                                    editShirt(name: gildanName, small: gildanSmallQuantity, medium: gildanMediumQuantity, large: gildanLargeQuantity)
                                }
                            )
                        }
                        VStack {
                            ShirtItemView(
                                name: $bellaName,
                                small: $bellaSmallQuantity,
                                medium: $bellaMediumQuantity,
                                large: $bellaLargeQuantity,
                                imageName: "Bella3001CVC",
                                onEdit: {
                                    editShirt(name: bellaName, small: bellaSmallQuantity, medium: bellaMediumQuantity, large: bellaLargeQuantity)
                                }
                            )
                        }
                    }
                    
                    
                    Button(action: checkStock) {
                        Text("Check Stock")
                            .font(.title2)
                            .padding()
                            .background(gbl.darkOrange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
                .navigationTitle("Shirts")
            }
            .sheet(isPresented: $showEditSheet) {
                VStack {
                    Text("Edit \(selectedShirt)")
                        .font(.title2)
                        .padding()
                    
                    TextField("Enter new name", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Stepper("Small: \(editedSmall)", value: $editedSmall, in: 0...100)
                        .padding()
                    Stepper("Medium: \(editedMedium)", value: $editedMedium, in: 0...100)
                        .padding()
                    Stepper("Large: \(editedLarge)", value: $editedLarge, in: 0...100)
                        .padding()
                    
                    Button(action: {
                        saveChanges()
                        showEditSheet = false
                    }) {
                        Text("Save")
                            .font(.title2)
                            .padding()
                            .background(gbl.darkOrange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        showEditSheet = false
                    }) {
                        Text("Cancel")
                            .font(.title2)
                            .padding()
                            .background(gbl.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            }
            .alert(isPresented: $showStockAlert) {
                Alert(
                    title: Text("Stock Status"),
                    message: Text(stockAlertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            loadStockData()
        }
    }
    
    func editShirt(name: String, small: Int, medium: Int, large: Int) {
        selectedShirt = name
        editedName = name
        editedSmall = small
        editedMedium = medium
        editedLarge = large
        showEditSheet = true
    }
    
    func saveChanges() {
        if selectedShirt == gildanName {
            gildanName = editedName
            gildanSmallQuantity = editedSmall
            gildanMediumQuantity = editedMedium
            gildanLargeQuantity = editedLarge
        } else if selectedShirt == bellaName {
            bellaName = editedName
            bellaSmallQuantity = editedSmall
            bellaMediumQuantity = editedMedium
            bellaLargeQuantity = editedLarge
        }
    }
    
    func checkStock() {
        if gildanSmallQuantity < 3 || gildanMediumQuantity < 3 || gildanLargeQuantity < 3 ||
            bellaSmallQuantity < 3 || bellaMediumQuantity < 3 || bellaLargeQuantity < 3 {
            stockAlertMessage = "Low stock! Some sizes have less than 3 items."
        } else {
            stockAlertMessage = "Enough stock! All sizes have more than 3 items."
        }
        
        showStockAlert = true
    }
    func saveStockData() {}
    func loadStockData() {}
}

struct ShirtItemView: View {
    @Binding var name: String
    @Binding var small: Int
    @Binding var medium: Int
    @Binding var large: Int
    var imageName: String
    var onEdit: () -> Void
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 200, height: 200)
            
            HStack {
                Text(name)
                    .font(.headline)
                Button(action: onEdit) {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            Text("Small: \(small)")
            Text("Medium: \(medium)")
            Text("Large: \(large)")
        }
        .border(.gray, width: 2)
        .padding()
    }
}

#Preview {
    ShirtItemView(
                name: .constant("Gildan5000"),
                small: .constant(12),
                medium: .constant(25),
                large: .constant(8),
                imageName: "Gildan5000",
                onEdit: {} 
            )
}
