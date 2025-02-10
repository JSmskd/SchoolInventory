//
//  OrderContentView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 1/16/25.
//

import SwiftUI
import SwiftData

struct OrderContentView: View {
    @Environment(\.modelContext) var context
    @Query var barcodeNumbers: [Order]
    @State var enteredBarcodeNumber = 0
    @State var enteredSize = ""
    @State var enteredClothingItem = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter barcode Number", value: $enteredBarcodeNumber, format: .number)
                TextField("Enter size", text: $enteredSize)
                TextField("Enter item name", text: $enteredClothingItem)
                
                Button("+") {
                    let orders = Order(barcodeNumber: enteredBarcodeNumber, size: enteredSize, clothingItem: enteredClothingItem)
                    context.insert(orders)
                    
                    // Reset the form fields
                    enteredBarcodeNumber = 0
                    enteredSize = ""
                    enteredClothingItem = ""
                    
                    // Save the context
                    saveContext()
                }
            }
            List {
                ForEach(barcodeNumbers) { currentBarcodeNumber in
                    VStack {
                        Text(currentBarcodeNumber.size)
                        Text(currentBarcodeNumber.clothingItem)
                    }
                }
            }
            .onChange(of: barcodeNumbers) { _ in
                saveContext() // Save every time the list changes
            }
        }
        .onDisappear {
            saveContext() // Save when the view disappears (i.e., when the app exits)
        }
    }
    
    // Save the context
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}

#Preview {
    OrderContentView()
}
