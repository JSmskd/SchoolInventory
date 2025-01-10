//
//  OrderListView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 1/10/25.
//

import SwiftUI

struct OrderListView: View {
    let currentOrderItem: OrderItem
    var body: some View {
        VStack(alignment: .leading) {
            Text(currentOrderItem.nameOfItem)
                .font(.title)
                .foregroundColor(.teal)
                .bold()
            //Text(currentOrderItem.studentID)
        }
    }
}

#Preview {
    OrderListView(currentOrderItem: OrderItem(nameOfItem: "Fake", studentID: 0))
}
