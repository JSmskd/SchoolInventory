//
//  SweatpantsView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/6/25.
//

import SwiftUI

struct SweatpantsView: View {
    @State private var isEditing = false
    @State private var showEditSheet = false
    @State private var selectedItem: String = ""
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
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        VStack {
                            SweatpantsItemView(
                                name: $gildanName,
                                small: $gildanSmallQuantity,
                                medium: $gildanMediumQuantity,
                                large: $gildanLargeQuantity,
                                imageName: "Gildan5000",
                                onEdit: {
                                    editItem(name: gildanName, small: gildanSmallQuantity, medium: gildanMediumQuantity, large: gildanLargeQuantity)
                                }
                            )
                        }
                        VStack {
                            SweatpantsItemView(
                                name: $bellaName,
                                small: $bellaSmallQuantity,
                                medium: $bellaMediumQuantity,
                                large: $bellaLargeQuantity,
                                imageName: "Bella3001CVC",
                                onEdit: {
                                    editItem(name: bellaName, small: bellaSmallQuantity, medium: bellaMediumQuantity, large: bellaLargeQuantity)
                                }
                            )
                        }
                    }
                    Button(action: checkStock) {
                        Text("Check Stock")
                            .font(.title2)
                            .padding()
                            .background(Color.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
                .navigationTitle("Sweatpants")
                .alert(isPresented: $showStockAlert) {
                    Alert(
                        title: Text("Stock Check"),
                        message: Text(stockAlertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .sheet(isPresented: $showEditSheet) {
                VStack {
                    Text("Edit \(selectedItem)")
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
                            .background(Color.darkOrange)
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
                            .background(Color.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            }
        }
        .onAppear {
            loadStockData()
        }
    }
    
    func checkStock() {
        var alertMessage = "Stock Check Results:\n"
        var isStockLow = false
        
        
        if gildanSmallQuantity < 3 {
            alertMessage += "Gildan Small: Not enough stock.\n"
            isStockLow = true
        }
        if gildanMediumQuantity < 3 {
            alertMessage += "Gildan Medium: Not enough stock.\n"
            isStockLow = true
        }
        if gildanLargeQuantity < 3 {
            alertMessage += "Gildan Large: Not enough stock.\n"
            isStockLow = true
        }
        
        
        if bellaSmallQuantity < 3 {
            alertMessage += "Bella Small: Not enough stock.\n"
            isStockLow = true
        }
        if bellaMediumQuantity < 3 {
            alertMessage += "Bella Medium: Not enough stock.\n"
            isStockLow = true
        }
        if bellaLargeQuantity < 3 {
            alertMessage += "Bella Large: Not enough stock.\n"
            isStockLow = true
        }
        
        if !isStockLow {
            alertMessage = "All sizes have enough stock!"
        }
        
        stockAlertMessage = alertMessage
        showStockAlert = true
    }
    
    func editItem(name: String, small: Int, medium: Int, large: Int) {
        selectedItem = name
        editedName = name
        editedSmall = small
        editedMedium = medium
        editedLarge = large
        showEditSheet = true
    }
    
    func saveChanges() {
        if selectedItem == gildanName {
            gildanName = editedName
            gildanSmallQuantity = editedSmall
            gildanMediumQuantity = editedMedium
            gildanLargeQuantity = editedLarge
        } else if selectedItem == bellaName {
            bellaName = editedName
            bellaSmallQuantity = editedSmall
            bellaMediumQuantity = editedMedium
            bellaLargeQuantity = editedLarge
        }
    }
    func saveStockData() {
        UserDefaults.standard.set(gildanSmallQuantity, forKey: "gildanSmallQuantity")
        UserDefaults.standard.set(gildanMediumQuantity, forKey: "gildanMediumQuantity")
        UserDefaults.standard.set(gildanLargeQuantity, forKey: "gildanLargeQuantity")
        
        UserDefaults.standard.set(bellaSmallQuantity, forKey: "bellaSmallQuantity")
        UserDefaults.standard.set(bellaMediumQuantity, forKey: "bellaMediumQuantity")
        UserDefaults.standard.set(bellaLargeQuantity, forKey: "bellaLargeQuantity")
    }
    
    func loadStockData() {
        gildanSmallQuantity = UserDefaults.standard.integer(forKey: "gildanSmallQuantity")
        gildanMediumQuantity = UserDefaults.standard.integer(forKey: "gildanMediumQuantity")
        gildanLargeQuantity = UserDefaults.standard.integer(forKey: "gildanLargeQuantity")
        
        bellaSmallQuantity = UserDefaults.standard.integer(forKey: "bellaSmallQuantity")
        bellaMediumQuantity = UserDefaults.standard.integer(forKey: "bellaMediumQuantity")
        bellaLargeQuantity = UserDefaults.standard.integer(forKey: "bellaLargeQuantity")
    }
}

struct SweatpantsItemView: View {
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
    SweatpantsView()
}

