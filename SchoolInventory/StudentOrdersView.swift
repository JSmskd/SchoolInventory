//
//  OnlineView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

struct StudentOrdersView: View {
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
