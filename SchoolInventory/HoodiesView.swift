//
//  HoodiesView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/10/25.
//

import SwiftUI
struct HoodiesView: View {
    @State private var isEditing = false  
    @State private var greyHoodies = "Grey Hoodies"
    @State private var orangeHoodies = "Orange Hoodies"

    var body: some View {
        NavigationView {
            VStack {
                if isEditing {
                    TextField("Grey Hoodies", text: $greyHoodies)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Orange Hoodies", text: $orangeHoodies)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                } else {
                    Text(greyHoodies)
                    Text(orangeHoodies)
                }
            }
            .navigationTitle("Hoodies")
            .navigationBarItems(
                trailing: Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            )
        }
    }
}

#Preview {
    HoodiesView()

//struct HoodiesView: View {
//    var body: some View {
//        VStack {
//            Text("Grey Hoodies")
//            Text("Orange Hoodies")
//        }
//    }
//   
//}
//#Preview {
//    HoodiesView()
}
