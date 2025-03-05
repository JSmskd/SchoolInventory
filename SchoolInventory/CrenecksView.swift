//
//  CrenecksView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/10/25.
//

import SwiftUI
struct CrewnecksView: View {
    @State private var isEditing = false  
    @State private var greyCrewnecks = "Grey Crewnecks"
    @State private var orangeCrewnecks = "Orange Crewnecks"

    var body: some View {
        NavigationView {
            VStack {
                if isEditing {
                    TextField("Grey Crewnecks", text: $greyCrewnecks)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Orange Crewnecks", text: $orangeCrewnecks)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                } else {
                    Text(greyCrewnecks)
                    Text(orangeCrewnecks)
                }
            }
            .navigationTitle("Crewnecks")
            .navigationBarItems(
                trailing: Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            )
        }
    }
}

#Preview {
    CrewnecksView()
}

//struct CrewnecksView: View {
//    var body: some View {
//        VStack {
//            Text("Grey Crewnecks")
//            Text("Orange Crewnecks")
//        }
//    }
//   
//}
//#Preview {
//    CrewnecksView()
//}
