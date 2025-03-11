//
//  HoodiesView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/10/25.
//

import SwiftUI

struct HoodiesView: View {
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
                            .border(.brown, width: 2)
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
                            .border(.brown, width: 2)
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
                            .border(.brown, width: 2)
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
                    
                
                }
                .padding()
                .navigationTitle("Hoodies")
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
    HoodiesView()
}


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
//}
