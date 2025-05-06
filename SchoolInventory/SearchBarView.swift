//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI

struct SearchBarView: View {
    @State private var listOfStudentIDs: [StudentItem] = [
        StudentItem(studentID: "12345", item: "Shirt", size: "M"),
        StudentItem(studentID: "67890", item: "Hoodie", size: "L"),
        StudentItem(studentID: "54321", item: "Shorts", size: "S")
    ]
    @State private var searchText = ""
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(studentItems) { studentItem in
                        HStack {
                            if isEditing {
                                TextField("Student ID", text: $listOfStudentIDs.first(where: { $0.id == studentItem.id })!.studentID)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                TextField("Item", text: $listOfStudentIDs.first(where: { $0.id == studentItem.id })!.item)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                TextField("Size", text: $listOfStudentIDs.first(where: { $0.id == studentItem.id })!.size)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            } else {
                                Text(studentItem.studentID.capitalized)
                                Spacer()
                                Text(studentItem.item)
                                    .foregroundColor(.gray)
                                Text("Size: \(studentItem.size)")
                                    .foregroundColor(.darkBrown)
                                Image(systemName: "person.fill")
                                    .foregroundColor(.darkOrange)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .searchable(text: $searchText)
                .navigationTitle("Online Orders")
                .navigationBarItems(
                    trailing: Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                )
            }
        }
    }

    var studentItems: [StudentItem] {
        let lcStudentItems = listOfStudentIDs.map {
            StudentItem(studentID: $0.studentID.lowercased(), item: $0.item.lowercased(), size: $0.size)
        }
        
        if searchText.isEmpty {
            return listOfStudentIDs
        } else {
            return lcStudentItems.filter {
                $0.studentID.contains(searchText.lowercased()) ||
                $0.item.contains(searchText.lowercased()) ||
                $0.size.contains(searchText.lowercased())
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
