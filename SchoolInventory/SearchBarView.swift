//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI

struct StudentItem {
    var studentID: String
    var item: String
}

struct SearchBarView: View {
    @State private var listOfStudentIDs: [StudentItem] = []
    @State private var searchText = ""
    @State private var newStudentID = ""
    @State private var newItem = ""
    @State private var showAddStudentIDSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(listOfStudentIDs, id: \.studentID) { studentItem in
                        HStack {
                            Text(studentItem.studentID.capitalized)
                            Spacer()
                            Text(studentItem.item)
                                .foregroundColor(.gray)
                            Image(systemName: "person.fill")
                                .foregroundColor(Color.blue)
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteItems)
                }
                .searchable(text: $searchText)
                .navigationTitle("Search Student IDs and Items")
                
                Button(action: {
                    showAddStudentIDSheet = true
                }) {
                    HStack {
                        Text("Add Student ID")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        Text("Add Items")
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
            }
        }
    }
    
    var studentItems: [StudentItem] {
        let lcStudentItems = listOfStudentIDs.map { StudentItem(studentID: $0.studentID.lowercased(), item: $0.item) }
        return searchText.isEmpty ? lcStudentItems : lcStudentItems.filter {
            $0.studentID.contains(searchText.lowercased())
        }
    }
 
    func deleteItems(at offsets: IndexSet) {
        listOfStudentIDs.remove(atOffsets: offsets)
    }
   
    func addStudentID(_ studentID: String, newItem: String) {
        if !studentID.isEmpty && !listOfStudentIDs.contains(where: { $0.studentID.lowercased() == studentID.lowercased() }) {
            let newStudentItem = StudentItem(studentID: studentID, item: newItem)
            listOfStudentIDs.append(newStudentItem)
        }

        newStudentID = ""
       // newItem = ""  // Reset the item text
    }
}

#Preview {
    SearchBarView()
}
