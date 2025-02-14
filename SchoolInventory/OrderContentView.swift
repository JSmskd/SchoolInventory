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
    @State var characteristics = UserDefaults.standard.string(forKey: "OrderCharacteristics")
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter barcode Number", value: $enteredBarcodeNumber, format: .number)
                TextField("Enter size", text: $enteredSize)
                TextField("Enter item name", text: $enteredClothingItem)
                
                Button("+") {
                    let orders = Order(barcodeNumber: enteredBarcodeNumber, size: enteredSize, clothingItem: enteredClothingItem)
                    context.insert(orders)
                    
                    enteredBarcodeNumber = 0
                    enteredSize = ""
                    enteredClothingItem = ""
                    UserDefaults.standard.set(characteristics, forKey: "OrderCharacteristics")
                    
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
            
        }
        
    }
}

#Preview {
    OrderContentView()
}
