//
//  SweatpantsView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/6/25.
//

import SwiftUI
struct SweatpantsView: View {
    @State private var isEditing = false
    @State private var greySweats = "Grey Sweats"
    @State private var orangeSweats = "Orange Sweats"

    var body: some View {
        NavigationView {
            VStack {
                if isEditing {
                    TextField("Grey Sweats", text: $greySweats)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Orange Sweats", text: $orangeSweats)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                } else {
                    Text(greySweats)
                    Text(orangeSweats)
                }
            }
            .navigationTitle("Sweatpants")
            .navigationBarItems(
                trailing: Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            )
        }
    }
}

#Preview {
    SweatpantsView()

//struct SweatpantsView: View {
//    var body: some View {
//        VStack {
//            Text("Grey Sweats")
//            Text("Orange Sweats")
//        }
//    }
//   
//}
//#Preview {
//    SweatpantsView()
}
