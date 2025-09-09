//
//  WalkUpView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

struct Studentitem: Identifiable, Codable {
    var id = UUID()
    var studentID: String
    var item: String
    var size: String
}

struct WalkUpView: View {
    @State private var listOfStudentIDs: [Studentitem] = []
    @State private var searchText = ""
    @State private var showAddStudentIDSheet = false
    @State private var newStudentID = ""
    @State private var selectedItem = "Crewneck"
    @State private var selectedSize = "M"
    @State private var isTyping = false
    @State private var isEditing = false

    @State var items:[Item] = []
    @State var styles:[blank] = []
    @State var sizes:[blankSize] = []

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredStudentItems) { studentItem in
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
//                        
//                        Text("Select or Type an Item")
//                            .font(.title2)
//                            .padding()
//                        
//                        Toggle("Type Item", isOn: $isTyping)
//                            .padding()

//                        if isTyping {
                        HStack {
                            TextField("Enter Item", text: $selectedItem)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            Image(systemName: "magnifyingglass").foregroundStyle(.background).bold().padding().background(.blue).clipShape(RoundedRectangle(cornerSize: .init(width: 5, height: 5)))
                        }
                        
                        //list of items go here
                        
//                        } else {
//                            Picker("Items", selection: $selectedItem) {
//                                ForEach(itemOptions, id: \.self) { item in
//                                    Text(item).tag(item)
//                                }
//                            }
//                            .pickerStyle(WheelPickerStyle())
//                            .padding()
//                        }

                        Text("Select Size")
                            .font(.title2)
                            .padding()

                        Picker("Size", selection: $selectedSize) {
//                            ForEach(sizeOptions, id: \.self) { size in
                                Text("a").tag("a")
//                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        HStack{
                            Button(action: {
                                addStudentID(newStudentID, newItem: selectedItem, newSize: selectedSize)
                                showAddStudentIDSheet = false
                            }) {
                                Text("Add")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.darkOrange)
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
                                    .background(Color.darkBrown)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: loadStudentItems) // Load data when view appears
    }

    var filteredStudentItems: [Studentitem] {
        if searchText.isEmpty {
            return listOfStudentIDs
        } else {
            return listOfStudentIDs.filter {
                $0.studentID.lowercased().contains(searchText.lowercased()) ||
                $0.item.lowercased().contains(searchText.lowercased()) ||
                $0.size.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        listOfStudentIDs.remove(atOffsets: offsets)
        saveStudentItems() // Save data after deletion
    }

    func addStudentID(_ studentID: String, newItem: String, newSize: String) {
        guard !studentID.isEmpty, !newItem.isEmpty, !newSize.isEmpty else { return }
        
        let newStudent = Studentitem(studentID: studentID, item: newItem, size: newSize)
        listOfStudentIDs.append(newStudent)
        saveStudentItems() // Save data after adding
    }

    // Save the data to UserDefaults
    func saveStudentItems() {
        if let encoded = try? JSONEncoder().encode(listOfStudentIDs) {
            UserDefaults.standard.set(encoded, forKey: "studentItems")
        }
    }

    // Load the data from UserDefaults
    func loadStudentItems() {
        if let savedData = UserDefaults.standard.data(forKey: "studentItems"),
           let decodedItems = try? JSONDecoder().decode([Studentitem].self, from: savedData) {
            listOfStudentIDs = decodedItems
        }
    }
}

#Preview {
    WalkUpView()
}
