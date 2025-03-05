//
//  ShirtView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/6/25.
//

import SwiftUI
struct ShirtView: View {
    @State private var isEditing = false 
    @State private var gildanName = "Gildan5000"
    @State private var bellaName = "Bella3001CVC"

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("Gildan5000")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .border(.orange, width: 5)
                        .offset(x: -5, y: -240)
                    
                    Image("Bella3001CVC")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .border(.orange, width: 5)
                        .offset(x: 5, y: -240)
                }
                
                HStack {
                    if isEditing {
                        TextField("Enter name", text: $gildanName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 120)
                            .offset(x: -45, y: -235)
                        
                        TextField("Enter name", text: $bellaName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 120)
                            .offset(x: 45, y: -235)
                    } else {
                        Text(gildanName)
                            .offset(x: -45, y: -235)
                        
                        Text(bellaName)
                            .offset(x: 45, y: -235)
                    }
                }
            }
            .navigationTitle("Shirts")
            .navigationBarItems(
                trailing: Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            )
        }
    }
}

#Preview {
    ShirtView()

//struct ShirtView: View {
//    var body: some View {
//        VStack {
//            HStack {
//                
//                Image("Gildan5000")
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .border(.orange, width: 5)
//                    .offset(x: -5, y: -240)
//                Image("Bella3001CVC")
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .border(.orange, width: 5)
//                    .offset(x: 5, y: -240)
//            }
//            HStack {
//                Text("Gildan5000")
//                    .offset(x: -45, y: -235)
//                Text("Bella3001CVC")
//                    .offset(x: 45, y: -235)
//            }
//        }
//    }
//}
//
//#Preview {
//    ShirtView()
}
