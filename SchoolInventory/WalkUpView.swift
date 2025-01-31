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
            List(orderItems, id: \.self) { currentOrderItem in
                OrderListView(currentOrderItem: currentOrderItem)
            }
        }
    }
}

#Preview {
    WalkUpView()
}
