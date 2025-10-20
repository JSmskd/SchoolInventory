//
//  OrderItemView.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/20/25.
//

import CloudKit
import SwiftUI

struct OrderItemV: View {
    ///order
    @Binding var o:order
    @State private var itemsOrdered:[io] = []
    private var totalPrice:Int{get{var r=0;for(i)in(itemsOrdered){r+=i.price};return(r)}}
    var body: some View {
        VStack{
            Button("MARK DELIVERED"){
                o.orderFulfilledBy = "ADMIN"
                upload()
            }
            Button("MARK NOT DELIVERED"){
                o.orderFulfilledBy = ""
                upload()
            }
            Text(gbl.toPrice(totalPrice))
                .clipShape(RoundedRectangle(cornerSize: .init(width: 100, height: 100)))
            List {
                ForEach($itemsOrdered, id:\.self ) { i in
                    HStack{
                        Text("\(i.wrappedValue.item.title)")
                        Spacer()
                        Text("\(gbl.toPrice(i.wrappedValue.indvPrice)) x \(i.wrappedValue.quantity.description) : \(gbl.toPrice(i.wrappedValue.price))")
                    }
                }
            }
        }.onAppear {
            ref()
        }
        
    }
    func upload() {
        o.upload()
    }
    func ref() {
        itemsOrdered = []
//        for ords in o.itemsOrdered! {
//            print(ords.recordID)

//        }
    }
}
