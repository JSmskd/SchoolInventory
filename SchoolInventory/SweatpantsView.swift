//
//  SweatpantsView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/6/25.
//

import SwiftUI
struct SweatpantsView: View {
    @State private var isEditing = false
    @State private var showEditSheet = false
    @State private var selectedItem: String = ""
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
                            SweatpantsItemView(
                                name: $gildanName,
                                small: $gildanSmallQuantity,
                                medium: $gildanMediumQuantity,
                                large: $gildanLargeQuantity,
                                imageName: "Gildan5000",
                                onEdit: {
                                    editItem(name: gildanName, small: gildanSmallQuantity, medium: gildanMediumQuantity, large: gildanLargeQuantity)
                                }
                            )
                        }
                        VStack {
                            SweatpantsItemView(
                                name: $bellaName,
                                small: $bellaSmallQuantity,
                                medium: $bellaMediumQuantity,
                                large: $bellaLargeQuantity,
                                imageName: "Bella3001CVC",
                                onEdit: {
                                    editItem(name: bellaName, small: bellaSmallQuantity, medium: bellaMediumQuantity, large: bellaLargeQuantity)
                                }
                            )
                        }
                    }
                }
                .padding()
                .navigationTitle("Sweatpants")
            }
            .sheet(isPresented: $showEditSheet) {
                VStack {
                    Text("Edit \(selectedItem)")
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
    
    func editItem(name: String, small: Int, medium: Int, large: Int) {
        selectedItem = name
        editedName = name
        editedSmall = small
        editedMedium = medium
        editedLarge = large
        showEditSheet = true
    }
    
    func saveChanges() {
        if selectedItem == gildanName {
            gildanName = editedName
            gildanSmallQuantity = editedSmall
            gildanMediumQuantity = editedMedium
            gildanLargeQuantity = editedLarge
        } else if selectedItem == bellaName {
            bellaName = editedName
            bellaSmallQuantity = editedSmall
            bellaMediumQuantity = editedMedium
            bellaLargeQuantity = editedLarge
        }
    }
}

struct SweatpantsItemView: View {
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
    SweatpantsView()
}

//struct SweatpantsView: View {
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
//                .navigationTitle("Sweatpants")
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
//    SweatpantsView()
//}


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
//}
