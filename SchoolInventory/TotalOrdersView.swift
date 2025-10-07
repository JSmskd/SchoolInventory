//
//  TotalOrdersView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 3/21/25.
//

import SwiftUI

struct TotalOrdersView: View {
    @State private var searchOrdersText = ""
    @State private var isEditing = false
    
    @State private var onlineOrders: [StudentItem] = [
        StudentItem(studentID: "12345", item: "Shirt", size: "M"),
        StudentItem(studentID: "67890", item: "Hoodie", size: "L"),
        StudentItem(studentID: "54321", item: "Shorts", size: "S")
    ]
    
    @State private var walkUpOrders: [StudentItem] = [
        StudentItem(studentID: "54321", item: "Crewneck", size: "M"),
        StudentItem(studentID: "09876", item: "Orange Hoodie", size: "L"),
        StudentItem(studentID: "12431", item: "Sweat Pants", size: "S")
    ]
    
    var allOrders: [StudentItem] {
        let combinedOrders = onlineOrders + walkUpOrders
        if searchOrdersText.isEmpty {
            return combinedOrders
        } else {
            return combinedOrders.filter {
                $0.studentID.lowercased().contains(searchOrdersText.lowercased()) ||
                $0.item.lowercased().contains(searchOrdersText.lowercased()) ||
                $0.size.lowercased().contains(searchOrdersText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(allOrders) { order in
                        if let onlineIndex = onlineOrders.firstIndex(where: { $0.id == order.id }) {
                            OrderRow(order: $onlineOrders[onlineIndex], isEditing: $isEditing)
                        } else if let walkUpIndex = walkUpOrders.firstIndex(where: { $0.id == order.id }) {
                            OrderRow(order: $walkUpOrders[walkUpIndex], isEditing: $isEditing)
                        }
                    }
                    .onDelete(perform: deleteOrder)
                }
                .searchable(text: $searchOrdersText)
                .navigationTitle("Total Orders")
                .navigationBarItems(
                    trailing: Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                )
            }
        }
    }
    
    func deleteOrder(at offsets: IndexSet) {
        for index in offsets {
            let order = allOrders[index]
            
            if let onlineIndex = onlineOrders.firstIndex(where: { $0.id == order.id }) {
                onlineOrders.remove(at: onlineIndex)
            } else if let walkUpIndex = walkUpOrders.firstIndex(where: { $0.id == order.id }) {
                walkUpOrders.remove(at: walkUpIndex)
            }
        }
    }
}

struct OrderRow: View {
    @Binding var order: StudentItem
    @Binding var isEditing: Bool

    var body: some View {
        HStack {
            if isEditing {
                TextField("Student ID", text: $order.studentID)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Item", text: $order.item)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Size", text: $order.size)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(order.studentID.capitalized)
                Spacer()
                Text(order.item)
                    .foregroundColor(.gray)
                Text("Size: \(order.size)")
                    .foregroundColor(gbl.darkOrange)
                Image(systemName: "person.fill")
                    .foregroundColor(gbl.darkBrown)
            }
        }
    }
}

#Preview {
    TotalOrdersView()
}
