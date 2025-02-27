//
//  WalkUpView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

struct Studentitem: Identifiable {
    var id = UUID()
    var studentID: String
    var item: String
}

struct WalkUpView: View {
    @State private var listOfStudentIDs: [Studentitem] = [
        Studentitem(studentID: "54321", item: "Crewneck"),
        Studentitem(studentID: "09876", item: "Orange Hoodie"),
        Studentitem(studentID: "12431", item: "Sweat Pants")
    ]
    @State private var searchText = ""
    @State private var showAddStudentIDSheet = false
    @State private var newStudentID = ""
    @State private var selectedItem = "Crewneck"
    @State private var isTyping = false
    @State private var isEditing = false   

    let itemOptions = ["Crewneck", "Orange Hoodie", "Sweat Pants", "T-Shirt", "Jacket"]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($listOfStudentIDs) { $studentItem in
                        HStack {
                            if isEditing {
                                TextField("Student ID", text: $studentItem.studentID)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TextField("Item", text: $studentItem.item)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            } else {
                                Text(studentItem.studentID.capitalized)
                                Spacer()
                                Text(studentItem.item)
                                    .foregroundColor(.gray)
                                Image(systemName: "person.fill")
                                    .foregroundColor(.darkOrange)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .searchable(text: $searchText)
                .navigationTitle("Walk Up Orders")
                .navigationBarItems(
                    trailing: Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                )

                Button(action: {
                    showAddStudentIDSheet = true
                }) {
                    HStack {
                        Text("Add Student ID And Items")
                            .padding()
                            .background(Color.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .sheet(isPresented: $showAddStudentIDSheet) {
                    VStack {
                        Text("Enter Student ID")
                            .font(.title2)
                            .padding()
                        
                        TextField("Student ID", text: $newStudentID)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Text("Select or Type an Item")
                            .font(.title2)
                            .padding()
                        
                        Toggle("Type Item", isOn: $isTyping)
                            .padding()

                        if isTyping {
                            TextField("Enter Item", text: $selectedItem)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        } else {
                            Picker("Items", selection: $selectedItem) {
                                ForEach(itemOptions, id: \.self) { item in
                                    Text(item).tag(item)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .padding()
                        }

                        Button(action: {
                            addStudentID(newStudentID, newItem: selectedItem)
                            showAddStudentIDSheet = false
                        }) {
                            Text("Add")
                                .font(.title2)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        Button(action: {
                            showAddStudentIDSheet = false
                        }) {
                            Text("Cancel")
                                .font(.title2)
                                .padding()
                                .background(Color.brown)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
    }
    
    var studentItems: [Studentitem] {
        let lcStudentItems = listOfStudentIDs.map { Studentitem(studentID: $0.studentID.lowercased(), item: $0.item.lowercased()) }
        
        if searchText.isEmpty {
            return lcStudentItems
        } else {
            return lcStudentItems.filter {
                $0.studentID.contains(searchText.lowercased()) || $0.item.contains(searchText.lowercased())
            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        listOfStudentIDs.remove(atOffsets: offsets)
    }

    func addStudentID(_ studentID: String, newItem: String) {
        let newStudent = Studentitem(studentID: studentID, item: newItem)
        listOfStudentIDs.append(newStudent)
    }
}

#Preview {
    WalkUpView()
}

//struct Studentitem {
//    var studentID: String
//    var item: String
//}
//
//struct WalkUpView: View {
//    @State var listOfStudentIDs: [Studentitem] = [
//        Studentitem(studentID: "54321", item: "Crewneck"),
//        Studentitem(studentID: "09876", item: "Orange Hoodie"),
//        Studentitem(studentID: "12431", item: "Sweat Pants")
//    ]
//    @State var searchText = ""
//    
//    @State private var showAddStudentIDSheet = false
//    @State private var newStudentID = ""
//    
//    @State private var selectedItem = "Crewneck"
//    let itemOptions = ["Crewneck", "Orange Hoodie", "Sweat Pants", "T-Shirt", "Jacket"]
//    
//   
//    @State private var isTyping = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(studentItems, id: \.studentID) { studentItem in
//                        HStack {
//                            Text(studentItem.studentID.capitalized)
//                            Spacer()
//                            Text(studentItem.item)
//                                .foregroundColor(.gray)
//                            Image(systemName: "person.fill")
//                                .foregroundColor(.darkOrange)
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//                .searchable(text: $searchText)
//                .navigationTitle("Search IDs & Items")
//                
//                Button(action: {
//                    showAddStudentIDSheet = true
//                }) {
//                    HStack {
//                        Text("Add Student ID And Items")
//                            .padding()
//                            .background(Color.darkBrown)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//                .sheet(isPresented: $showAddStudentIDSheet) {
//                    VStack {
//                        Text("Enter Student ID")
//                            .font(.title2)
//                            .padding()
//                        
//                        TextField("Student ID", text: $newStudentID)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding()
//                        
//                        Text("Select or Type an Item")
//                            .font(.title2)
//                            .padding()
//                        
//                       
//                        Toggle("Type Item", isOn: $isTyping)
//                            .padding()
//
//                        if isTyping {
//                            TextField("Enter Item", text: $selectedItem)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .padding()
//                        } else {
//                          
//                            Picker("Items", selection: $selectedItem) {
//                                ForEach(itemOptions, id: \.self) { item in
//                                    Text(item).tag(item)
//                                }
//                            }
//                            .pickerStyle(WheelPickerStyle())
//                            .padding()
//                        }
//
//                        Button(action: {
//                            addStudentID(newStudentID, newItem: selectedItem)
//                            showAddStudentIDSheet = false
//                        }) {
//                            Text("Add")
//                                .font(.title2)
//                                .padding()
//                                .background(Color.darkOrange)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                        .padding()
//                        
//                        Button(action: {
//                            showAddStudentIDSheet = false
//                        }) {
//                            Text("Cancel")
//                                .font(.title2)
//                                .padding()
//                                .background(Color.darkBrown)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                        .padding()
//                    }
//                    .padding()
//                }
//            }
//        }
//    }
//    
//    var studentItems: [Studentitem] {
//        let lcStudentItems = listOfStudentIDs.map { Studentitem(studentID: $0.studentID.lowercased(), item: $0.item.lowercased()) }
//        
//        if searchText.isEmpty {
//            return lcStudentItems
//        } else {
//            return lcStudentItems.filter {
//                $0.studentID.contains(searchText.lowercased()) || $0.item.contains(searchText.lowercased())
//            }
//        }
//    }
//
//    func deleteItems(at offsets: IndexSet) {
//        listOfStudentIDs.remove(atOffsets: offsets)
//    }
//
//    func addStudentID(_ studentID: String, newItem: String) {
//        let newStudent = Studentitem(studentID: studentID, item: newItem)
//        listOfStudentIDs.append(newStudent)
//    }
//}
//
//#Preview {
//    WalkUpView()
//}
//

//import SwiftUI
//
//struct WalkUpView: View {
//    @State var orderItems: [OrderItem] = []
//    @AppStorage("OrderCharacteristics") var orderCharacteristics: String = ""
//    var body: some View {
//        VStack {
//            HeaderOrderView(orderItems: $orderItems)
//            List {
//                ForEach(orderItems, id: \.nameOfItem) { currentOrderItem in
//                    OrderListView(currentOrderItem: currentOrderItem)
//                }
//                .onDelete(perform: delete)
//            }
//        }
//    }
//    func delete(at offsets: IndexSet) {
//        orderItems.remove(atOffsets: offsets)
//    }
//}
//
//#Preview {
//    WalkUpView()
//}
