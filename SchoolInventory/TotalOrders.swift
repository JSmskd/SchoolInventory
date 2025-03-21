//
//  TotalOrders.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 3/17/25
//
//
import SwiftUI

class OrderData: ObservableObject {
    @Published var listOfStudentIDs: [StudentItem] = [
        StudentItem(studentID: "12345", item: "Shirt", size: "M"),
        StudentItem(studentID: "67890", item: "Hoodie", size: "L"),
        StudentItem(studentID: "54321", item: "Shorts", size: "S")
    ]
}

struct TotalOrdersView: View {
    @ObservedObject var orderData: OrderData
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var showAddStudentIDSheet = false

    var body: some View {
        NavigationView {
            VStack {
               
                List {
                    ForEach(filteredStudentItems) { studentItem in
                        HStack {
                            if isEditing {
                                TextField("Student ID", text: Binding(
                                    get: { studentItem.studentID },
                                    set: { updateStudentItem(studentItem, studentID: $0) }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 100)

                                TextField("Item", text: Binding(
                                    get: { studentItem.item },
                                    set: { updateStudentItem(studentItem, item: $0) }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 100)

                                TextField("Size", text: Binding(
                                    get: { studentItem.size },
                                    set: { updateStudentItem(studentItem, size: $0) }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 50)
                            } else {
                                Text(studentItem.studentID.capitalized)
                                Spacer()
                                Text(studentItem.item)
                                    .foregroundColor(.gray)
                                Text("Size: \(studentItem.size)")
                                    .foregroundColor(.blue)
                                Image(systemName: "person.fill")
                                    .foregroundColor(.brown)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .searchable(text: $searchText)
                .navigationTitle("Total Orders")
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
                            .background(Color.brown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .sheet(isPresented: $showAddStudentIDSheet) {
                    AddStudentSheet(orderData: orderData, showAddSheet: $showAddStudentIDSheet)
                }
            }
        }
    }

    
    var filteredStudentItems: [StudentItem] {
        if searchText.isEmpty {
            return orderData.listOfStudentIDs
        } else {
            return orderData.listOfStudentIDs.filter {
                $0.studentID.lowercased().contains(searchText.lowercased()) ||
                $0.item.lowercased().contains(searchText.lowercased()) ||
                $0.size.lowercased().contains(searchText.lowercased())
            }
        }
    }

    
    func deleteItems(at offsets: IndexSet) {
        orderData.listOfStudentIDs.remove(atOffsets: offsets)
    }

    
    private func updateStudentItem(_ studentItem: StudentItem, studentID: String? = nil, item: String? = nil, size: String? = nil) {
        if let studentID = studentID {
            if let index = orderData.listOfStudentIDs.firstIndex(where: { $0.id == studentItem.id }) {
                orderData.listOfStudentIDs[index].studentID = studentID
            }
        }
        if let item = item {
            if let index = orderData.listOfStudentIDs.firstIndex(where: { $0.id == studentItem.id }) {
                orderData.listOfStudentIDs[index].item = item
            }
        }
        if let size = size {
            if let index = orderData.listOfStudentIDs.firstIndex(where: { $0.id == studentItem.id }) {
                orderData.listOfStudentIDs[index].size = size
            }
        }
    }
}

#Preview {
    TotalOrdersView(orderData: OrderData())
}
