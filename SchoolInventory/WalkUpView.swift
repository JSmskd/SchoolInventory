//
//  WalkUpView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

struct Studentitem {
    var studentID: String
    var item: String
}

struct WalkUpView: View {
    @State  var listOfStudentIDs: [StudentItem] = [
        StudentItem(studentID: "54321", item: "CrewNeck"),
        StudentItem(studentID: "09876", item: "Orange Hoodie"),
        StudentItem(studentID: "12431", item: "SweatPants")
    ]
    @State  var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(studentItems, id: \.studentID) { studentItem in
                        HStack {
                            Text(studentItem.studentID.capitalized)
                            Spacer()
                            Text(studentItem.item)
                                .foregroundColor(.gray)
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .searchable(text: $searchText)
                .navigationTitle("Search IDs & Items")
                
                // Commented out the add button and sheet
                /*
                Button(action: {
                    showAddStudentIDSheet = true
                }) {
                    HStack {
                        Text("Add Student ID And Items")
                            .padding()
                            .background(Color.blue)
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
                        
                        Text("Enter Items")
                            .font(.title2)
                            .padding()
                        
                        TextField("Items", text: $newItem)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            addStudentID(newStudentID, newItem: newItem)
                            showAddStudentIDSheet = false
                        }) {
                            Text("Add")
                                .font(.title2)
                                .padding()
                                .background(Color.green)
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
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                }
                */
            }
        }
    }
    
    var studentItems: [StudentItem] {
        let lcStudentItems = listOfStudentIDs.map { StudentItem(studentID: $0.studentID.lowercased(), item: $0.item.lowercased()) }
        
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
}

#Preview {
    SearchBarView()
}


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
