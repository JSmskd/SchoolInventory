//
//  BlanksView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 3/17/25.
//

import SwiftUI

struct BlanksView: View {
    @State private var showEditSheet = false
    @State private var selectedShirt: String = ""
    @State private var editedName: String = ""
    @State private var editedSmall: Int = 0
    @State private var editedMedium: Int = 0
    @State private var editedLarge: Int = 0
    @State private var editedColor: String = "White"
    
    @State private var gildanName = "Gildan5000"
    @State private var bellaName = "Bella3001CVC"
    
    @State private var gildanSmallQuantity = 0
    @State private var gildanMediumQuantity = 0
    @State private var gildanLargeQuantity = 0
    @State private var bellaSmallQuantity = 0
    @State private var bellaMediumQuantity = 0
    @State private var bellaLargeQuantity = 0
    
    @State private var gildanColor = "White"
    @State private var bellaColor = "White"
    
    @State private var stockAlertMessage = ""
    @State private var showStockAlert = false
    
    let availableColors = ["White","Orange", "Black", "Red", "Blue", "Green", "Yellow", "Pink", "Grey"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack(spacing: 16) {
                        // Gildan View
                        VStack(spacing: 10) {
                            Image("Gildan5000")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            
                            Text(gildanName)
                                .font(.headline)
                            Text("Color: \(gildanColor)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Text("Small: \(gildanSmallQuantity)")
                            Text("Medium: \(gildanMediumQuantity)")
                            Text("Large: \(gildanLargeQuantity)")
                            
                            Button("Edit") {
                                editShirt(name: gildanName, small: gildanSmallQuantity, medium: gildanMediumQuantity, large: gildanLargeQuantity, color: gildanColor)
                            }
                            .padding(6)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(12)
                        
                        // Bella View
                        VStack(spacing: 10) {
                            Image("Bella3001CVC")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            
                            Text(bellaName)
                                .font(.headline)
                            Text("Color: \(bellaColor)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Text("Small: \(bellaSmallQuantity)")
                            Text("Medium: \(bellaMediumQuantity)")
                            Text("Large: \(bellaLargeQuantity)")
                            
                            Button("Edit") {
                                editShirt(name: bellaName, small: bellaSmallQuantity, medium: bellaMediumQuantity, large: bellaLargeQuantity, color: bellaColor)
                            }
                            .padding(6)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Button(action: checkStock) {
                        Text("Check Stock")
                            .font(.title2)
                            .padding()
                            .background(Color.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
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
                    
                    Picker("Color", selection: $editedColor) {
                        ForEach(availableColors, id: \.self) { color in
                            Text(color).tag(color)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Stepper("Small: \(editedSmall)", value: $editedSmall, in: 0...100)
                        .padding()
                    Stepper("Medium: \(editedMedium)", value: $editedMedium, in: 0...100)
                        .padding()
                    Stepper("Large: \(editedLarge)", value: $editedLarge, in: 0...100)
                        .padding()
                    
                    Button("Save") {
                        saveChanges()
                        showEditSheet = false
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.darkOrange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Cancel") {
                        showEditSheet = false
                    }
                    .padding()
                    .background(Color.darkBrown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
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
    
    func editShirt(name: String, small: Int, medium: Int, large: Int, color: String) {
        selectedShirt = name
        editedName = name
        editedSmall = small
        editedMedium = medium
        editedLarge = large
        editedColor = color
        showEditSheet = true
    }
    
    func saveChanges() {
        if selectedShirt == gildanName {
            gildanName = editedName
            gildanSmallQuantity = editedSmall
            gildanMediumQuantity = editedMedium
            gildanLargeQuantity = editedLarge
            gildanColor = editedColor
        } else if selectedShirt == bellaName {
            bellaName = editedName
            bellaSmallQuantity = editedSmall
            bellaMediumQuantity = editedMedium
            bellaLargeQuantity = editedLarge
            bellaColor = editedColor
        }
        saveStockData()
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
    
    func saveStockData() {
        UserDefaults.standard.set(gildanSmallQuantity, forKey: "gildanSmallQuantity")
        UserDefaults.standard.set(gildanMediumQuantity, forKey: "gildanMediumQuantity")
        UserDefaults.standard.set(gildanLargeQuantity, forKey: "gildanLargeQuantity")
        UserDefaults.standard.set(gildanColor, forKey: "gildanColor")
        
        UserDefaults.standard.set(bellaSmallQuantity, forKey: "bellaSmallQuantity")
        UserDefaults.standard.set(bellaMediumQuantity, forKey: "bellaMediumQuantity")
        UserDefaults.standard.set(bellaLargeQuantity, forKey: "bellaLargeQuantity")
        UserDefaults.standard.set(bellaColor, forKey: "bellaColor")
    }
    
    func loadStockData() {
        gildanSmallQuantity = UserDefaults.standard.integer(forKey: "gildanSmallQuantity")
        gildanMediumQuantity = UserDefaults.standard.integer(forKey: "gildanMediumQuantity")
        gildanLargeQuantity = UserDefaults.standard.integer(forKey: "gildanLargeQuantity")
        gildanColor = UserDefaults.standard.string(forKey: "gildanColor") ?? "White"
        
        bellaSmallQuantity = UserDefaults.standard.integer(forKey: "bellaSmallQuantity")
        bellaMediumQuantity = UserDefaults.standard.integer(forKey: "bellaMediumQuantity")
        bellaLargeQuantity = UserDefaults.standard.integer(forKey: "bellaLargeQuantity")
        bellaColor = UserDefaults.standard.string(forKey: "bellaColor") ?? "White"
    }
}

#Preview {
    BlanksView()
}
