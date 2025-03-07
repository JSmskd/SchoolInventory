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
    @State private var gildanSmallQuanity = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        VStack {
                            // First Gildan Image
                            VStack {
                                Image("Gildan5000")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(gildanName)
                                Text("Small: \(gildanSmallQuanity)")
                                Text("Medium: 0")
                                Text("Large: 0")
                            }
                            .border(.orange, width: 2)
                            
                            // Second Gildan Image
                            VStack {
                                Image("Gildan5000")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(gildanName)
                                Text("Small: \(gildanSmallQuanity)")
                                Text("Medium: 0")
                                Text("Large: 0")
                            }
                            .border(.orange, width: 2)
                            
                            // Third Gildan Image
                            VStack {
                                Image("Gildan5000")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(gildanName)
                                Text("Small: \(gildanSmallQuanity)")
                                Text("Medium: 0")
                                Text("Large: 0")
                            }
                            .border(.orange, width: 2)
                        }
                        
                        VStack {
                            // First Bella Image
                            VStack {
                                Image("Bella3001CVC")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(bellaName)
                                Text("Small: 0")
                                Text("Medium: 0")
                                Text("Large: 0")
                            }
                            .border(.orange, width: 2)
                            
                            // Second Bella Image (new one added)
                            VStack {
                                Image("Bella3001CVC")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(bellaName)
                                Text("Small: 0")
                                Text("Medium: 0")
                                Text("Large: 0")
                            }
                            .border(.orange, width: 2)
                            VStack {
                                Image("Bella3001CVC")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(bellaName)
                                Text("Small: 0")
                                Text("Medium: 0")
                                Text("Large: 0")
                            }
                            .border(.orange, width: 2)
                        }
                    }
                    
                    HStack {
                        if isEditing {
                            TextField("Enter name", text: $gildanName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 120)
                            
                            TextField("Enter name", text: $bellaName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 120)
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
}

#Preview {
    ShirtView()
}



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
//}
