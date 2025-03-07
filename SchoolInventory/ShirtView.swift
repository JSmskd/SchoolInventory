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
    @State private var gildanSmallQuantity = 0
    @State private var gildanMediumQuantity = 0
    @State private var gildanLargeQuantity = 0
    @State private var bellaSmallQuantity = 0
    @State private var bellaMediumQuantity = 0
    @State private var bellaLargeQuantity = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        VStack{
                            VStack{
                                Image("Gildan5000")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(gildanName)
                                Text("Small: \(gildanSmallQuantity)")
                                Text("Medium: \(gildanMediumQuantity)")
                                Text("Large: \(gildanLargeQuantity)")
                            }
                            .border(.orange, width: 2)
                            VStack{
                                Image("Gildan5000")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(gildanName)
                                Text("Small: \(gildanSmallQuantity)")
                                Text("Medium: \(gildanMediumQuantity)")
                                Text("Large: \(gildanLargeQuantity)")
                            }
                            .border(.orange, width: 2)
                            VStack{
                                Image("Gildan5000")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(gildanName)
                                Text("Small: \(gildanSmallQuantity)")
                                Text("Medium: \(gildanMediumQuantity)")
                                Text("Large: \(gildanLargeQuantity)")
                            }
                            .border(.orange, width: 2)
                        }
                        VStack{
                            VStack{
                                Image("Bella3001CVC")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(bellaName)
                                Text("Small: \(bellaSmallQuantity)")
                                Text("Medium: \(bellaMediumQuantity)")
                                Text("Large: \(bellaLargeQuantity)")
                            }
                            .border(.orange, width: 2)
                            VStack{
                                Image("Bella3001CVC")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(bellaName)
                                Text("Small: \(bellaSmallQuantity)")
                                Text("Medium: \(bellaMediumQuantity)")
                                Text("Large: \(bellaLargeQuantity)")
                            }
                            .border(.orange, width: 2)
                            VStack{
                                Image("Bella3001CVC")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text(bellaName)
                                Text("Small: \(bellaSmallQuantity)")
                                Text("Medium: \(bellaMediumQuantity)")
                                Text("Large: \(bellaLargeQuantity)")
                            }
                            .border(.orange, width: 2)
                        }
                        
                    }
                    
                    HStack {
                        if isEditing {
                            TextField("Enter Gildan name", text: $gildanName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                            
                            TextField("Enter Bella name", text: $bellaName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                        }
                    }
                    
                    // Optional: Add more editing fields for quantities, if needed.
                }
                .padding()
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
