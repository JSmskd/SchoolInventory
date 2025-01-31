//
//  WalkUpView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

struct WalkUpView: View {
    @State var orderItems: [OrderItem] = []
    var body: some View {
        VStack {
            HeaderOrderView(orderItems: $orderItems)
            List {
                ForEach(orderItems, id: \.nameOfItem) { currentOrderItem in
                    OrderListView(currentOrderItem: currentOrderItem)
                }
                .onDelete(perform: delete)
            }
        }
    }
    func delete(at offsets: IndexSet) {
        orderItems.remove(atOffsets: offsets)
    }
}

#Preview {
    WalkUpView()
}
