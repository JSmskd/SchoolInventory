//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI



struct SearchBarView: View {
    @State private var listOfStudentIDs = studentIDList
    @State private var searchText = ""
    @State private var newStudentID = ""
    @State private var newItem = ""
    @State private var showAddStudentIDSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(studentIDs, id: \.self) { studentID in
                        HStack {
                            Text(studentID.capitalized)
                            Spacer()
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
                        
                        TextField("Items", text: $newItem)  // Binding to newItem
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
    
    var studentIDs: [String] {
        let lcStudentIDs = listOfStudentIDs.map { $0.lowercased() }
        return searchText.isEmpty ? lcStudentIDs : lcStudentIDs.filter {
            $0.contains(searchText.lowercased())
        }
    }
 
    func deleteItems(at offsets: IndexSet) {
        listOfStudentIDs.remove(atOffsets: offsets)
    }
   
    func addStudentID(_ studentID: String, newItem: String) {
        if !studentID.isEmpty && !listOfStudentIDs.contains(where: { $0.lowercased() == studentID.lowercased() }) {
            listOfStudentIDs.append(studentID)
        }
        
        newStudentID = ""
//        newItem = ""
    }
}

#Preview {
    SearchBarView()
}
