//
//  ShirtView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/6/25.
//

import SwiftUI
struct ShirtView: View {
    @State private var isEditing = false
    @State private var showEditSheet = false
    @State private var selectedShirt: String = ""
    @State private var editedName: String = ""
    @State private var editedSmall: Int = 0
    @State private var editedMedium: Int = 0
    @State private var editedLarge: Int = 0
    
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
                        VStack {
                            ShirtItemView(
                                name: $gildanName,
                                small: $gildanSmallQuantity,
                                medium: $gildanMediumQuantity,
                                large: $gildanLargeQuantity,
                                imageName: "Gildan5000",
                                onEdit: {
                                    editShirt(name: gildanName, small: gildanSmallQuantity, medium: gildanMediumQuantity, large: gildanLargeQuantity)
                                }
                            )
                        }
                        VStack {
                            ShirtItemView(
                                name: $bellaName,
                                small: $bellaSmallQuantity,
                                medium: $bellaMediumQuantity,
                                large: $bellaLargeQuantity,
                                imageName: "Bella3001CVC",
                                onEdit: {
                                    editShirt(name: bellaName, small: bellaSmallQuantity, medium: bellaMediumQuantity, large: bellaLargeQuantity)
                                }
                            )
                        }
                    }
                }
                .padding()
                .navigationTitle("Shirts")
            }
            .sheet(isPresented: $showEditSheet) {
                VStack {
                    Text("Edit \(selectedShirt)")
                        .font(.title2)
                        .padding()
                    
                    TextField("Enter new name", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Stepper("Small: \(editedSmall)", value: $editedSmall, in: 0...100)
                        .padding()
                    Stepper("Medium: \(editedMedium)", value: $editedMedium, in: 0...100)
                        .padding()
                    Stepper("Large: \(editedLarge)", value: $editedLarge, in: 0...100)
                        .padding()
                    
                    Button(action: {
                        saveChanges()
                        showEditSheet = false
                    }) {
                        Text("Save")
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        showEditSheet = false
                    }) {
                        Text("Cancel")
                            .font(.title2)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
    
    func editShirt(name: String, small: Int, medium: Int, large: Int) {
        selectedShirt = name
        editedName = name
        editedSmall = small
        editedMedium = medium
        editedLarge = large
        showEditSheet = true
    }
    
    func saveChanges() {
        if selectedShirt == gildanName {
            gildanName = editedName
            gildanSmallQuantity = editedSmall
            gildanMediumQuantity = editedMedium
            gildanLargeQuantity = editedLarge
        } else if selectedShirt == bellaName {
            bellaName = editedName
            bellaSmallQuantity = editedSmall
            bellaMediumQuantity = editedMedium
            bellaLargeQuantity = editedLarge
        }
    }
}

struct ShirtItemView: View {
    @Binding var name: String
    @Binding var small: Int
    @Binding var medium: Int
    @Binding var large: Int
    var imageName: String
    var onEdit: () -> Void
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 200, height: 200)
            
            HStack {
                Text(name)
                    .font(.headline)
                Button(action: onEdit) {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            
            Text("Small: \(small)")
            Text("Medium: \(medium)")
            Text("Large: \(large)")
        }
        .border(.gray, width: 2)
        .padding()
    }
}

#Preview {
    ShirtView()

//struct ShirtView: View {
//    @State private var isEditing = false
//    @State private var gildanName = "Gildan5000"
//    @State private var bellaName = "Bella3001CVC"
//    @State private var gildanSmallQuantity = 0
//    @State private var gildanMediumQuantity = 0
//    @State private var gildanLargeQuantity = 0
//    @State private var bellaSmallQuantity = 0
//    @State private var bellaMediumQuantity = 0
//    @State private var bellaLargeQuantity = 0
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack {
//                    HStack {
//                        VStack{
//                            VStack{
//                                Image("Gildan5000")
//                                    .resizable()
//                                    .frame(width: 200, height: 200)
//                                Text(gildanName)
//                                Text("Small: \(gildanSmallQuantity)")
//                                Text("Medium: \(gildanMediumQuantity)")
//                                Text("Large: \(gildanLargeQuantity)")
//                            }
//                            .border(.orange, width: 2)
//                            VStack{
//                                Image("Gildan5000")
//                                    .resizable()
//                                    .frame(width: 200, height: 200)
//                                Text(gildanName)
//                                Text("Small: \(gildanSmallQuantity)")
//                                Text("Medium: \(gildanMediumQuantity)")
//                                Text("Large: \(gildanLargeQuantity)")
//                            }
//                            .border(.brown, width: 2)
//                            VStack{
//                                Image("Gildan5000")
//                                    .resizable()
//                                    .frame(width: 200, height: 200)
//                                Text(gildanName)
//                                Text("Small: \(gildanSmallQuantity)")
//                                Text("Medium: \(gildanMediumQuantity)")
//                                Text("Large: \(gildanLargeQuantity)")
//                            }
//                            .border(.orange, width: 2)
//                        }
//                        VStack{
//                            VStack{
//                                Image("Bella3001CVC")
//                                    .resizable()
//                                    .frame(width: 200, height: 200)
//                                Text(bellaName)
//                                Text("Small: \(bellaSmallQuantity)")
//                                Text("Medium: \(bellaMediumQuantity)")
//                                Text("Large: \(bellaLargeQuantity)")
//                            }
//                            .border(.brown, width: 2)
//                            VStack{
//                                Image("Bella3001CVC")
//                                    .resizable()
//                                    .frame(width: 200, height: 200)
//                                Text(bellaName)
//                                Text("Small: \(bellaSmallQuantity)")
//                                Text("Medium: \(bellaMediumQuantity)")
//                                Text("Large: \(bellaLargeQuantity)")
//                            }
//                            .border(.orange, width: 2)
//                            VStack{
//                                Image("Bella3001CVC")
//                                    .resizable()
//                                    .frame(width: 200, height: 200)
//                                Text(bellaName)
//                                Text("Small: \(bellaSmallQuantity)")
//                                Text("Medium: \(bellaMediumQuantity)")
//                                Text("Large: \(bellaLargeQuantity)")
//                            }
//                            .border(.brown, width: 2)
//                        }
//                        
//                    }
//                    
//                    HStack {
//                        if isEditing {
//                            TextField("Enter Gildan name", text: $gildanName)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .frame(width: 200)
//                            
//                            TextField("Enter Bella name", text: $bellaName)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .frame(width: 200)
//                        }
//                    }
//                    
//                    // Optional: Add more editing fields for quantities, if needed.
//                }
//                .padding()
//                .navigationTitle("Shirts")
//                .navigationBarItems(
//                    trailing: Button(isEditing ? "Done" : "Edit") {
//                        isEditing.toggle()
//                    }
//                )
//            }
//        }
//    }
//}
//
//#Preview {
//    ShirtView()
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
