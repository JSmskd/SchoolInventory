//
//  StoreView.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/16/25.
//
import CloudKit
import SwiftUI

struct StoreView: View {
//    @State var
    var body: some View {
        VStack {
            Text("Store")
            StoreRow(name: "hi")
        }
    }
}

#Preview {
    
//    Text("hi")
//    StoreRow(name: "Alphabeta")
    StoreView()
}
