//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI
struct StudentItem: Identifiable {
    var id = UUID()
    var studentID: String
    var item: String
}

struct SearchBarView: View {
    @State private var listOfStudentIDs: [StudentItem] = [
        StudentItem(studentID: "12345", item: "Shirt"),
        StudentItem(studentID: "67890", item: "Hoodie"),
        StudentItem(studentID: "54321", item: "Shorts")
    ]
    @State private var searchText = ""
    @State private var isEditing = false

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
                                    .foregroundColor(.darkBrown)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .searchable(text: $searchText)
                .navigationTitle("Search IDs & Items")
                .navigationBarItems(
                    trailing: Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    
                    }
                )
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

//struct StudentItem: Identifiable {
//    var id = UUID()
//    var studentID: String
//    var item: String
//}
//
//struct SearchBarView: View {
//    @State  var listOfStudentIDs: [StudentItem] = [
//        StudentItem(studentID: "12345", item: "Shirt"),
//        StudentItem(studentID: "67890", item: "Hoodie"),
//        StudentItem(studentID: "54321", item: "Shorts")
//    ]
//    @State  var searchText = ""
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
//                                .foregroundColor(.darkBrown)
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//                .searchable(text: $searchText)
//                .navigationTitle("Search IDs & Items")
//                
//                // Commented out the add button and sheet
//                /*
//                Button(action: {
//                    showAddStudentIDSheet = true
//                }) {
//                    HStack {
//                        Text("Add Student ID And Items")
//                            .padding()
//                            .background(Color.blue)
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
//                        Text("Enter Items")
//                            .font(.title2)
//                            .padding()
//                        
//                        TextField("Items", text: $newItem)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding()
//                        
//                        Button(action: {
//                            addStudentID(newStudentID, newItem: newItem)
//                            showAddStudentIDSheet = false
//                        }) {
//                            Text("Add")
//                                .font(.title2)
//                                .padding()
//                                .background(Color.green)
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
//                                .background(Color.red)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//                .searchable(text: $searchText)
//                .navigationTitle("Search IDs & Items")
//                .navigationBarItems(
//                    trailing: Button(isEditing ? "Done" : "Edit") {
//                        isEditing.toggle()
//                    }
//                )
//            }
//        }
//    }
//
//    var studentItems: [StudentItem] {
//        let lcStudentItems = listOfStudentIDs.map { StudentItem(studentID: $0.studentID.lowercased(), item: $0.item.lowercased()) }
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
//}
//
//#Preview {
//    SearchBarView()
//}
//
