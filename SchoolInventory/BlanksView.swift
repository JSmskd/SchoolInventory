//
//  BlanksView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 3/17/25.
//

import SwiftUI

import SwiftUI

struct BlanksView: View {
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
                            .background(Color.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
                .navigationTitle("Blanks")
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
        
        saveStockData()
    }
    
    func checkStock() {
        if gildanSmallQuantity < 3 || gildanMediumQuantity < 3 || gildanLargeQuantity < 3 || bellaSmallQuantity < 3 || bellaMediumQuantity < 3 || bellaLargeQuantity < 3 {
            stockAlertMessage = "Low stock! Some sizes have less than 3 items."
        } else {
            stockAlertMessage = "Enough stock! All sizes have more than 3 items."
        }
        
        showStockAlert = true
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

#Preview {
    BlanksView()
}
