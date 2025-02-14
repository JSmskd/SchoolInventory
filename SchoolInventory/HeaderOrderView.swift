//
//  HeaderOrderView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 1/14/25.
//

import SwiftUI

struct HeaderOrderView: View {
    @State var newOrderItemName: String = ""
    @State var newStudentID: Int?
    @Binding var orderItems: [OrderItem]
    @AppStorage("OrderCharacteristics") var orderCharacteristics: String = ""
    var body: some View {
        HStack{
            TextField("ID", value: $newStudentID, format: .number)
                .textFieldStyle(.roundedBorder)
            TextField("Item name", text: $newOrderItemName)
                .textFieldStyle(.roundedBorder)
            Button("+") {
                guard let number = newStudentID else {return}
                let newOrderItem = OrderItem(nameOfItem: newOrderItemName, studentID: number)
                orderItems.append(newOrderItem)
                
                newOrderItemName = ""
                newStudentID = nil
            }
            .bold()
            .font(.largeTitle)
        }
        .padding()
    }
}
