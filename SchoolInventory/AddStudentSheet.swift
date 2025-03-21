//
//  AddStudentSheet.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 3/19/25.
//
import SwiftUI

struct AddStudentSheet: View {
    @ObservedObject var orderData: OrderData
    @Binding var showAddSheet: Bool
    @State private var newStudentID = ""
    @State private var selectedItem = "Shirt"
    @State private var selectedSize = "M"
    @State private var isTyping = false
    
    let itemOptions = ["Shirt", "Hoodie", "Shorts", "T-Shirt", "Jacket"]
    let sizeOptions = ["XS", "S", "M", "L", "XL", "XXL"]
    
    var body: some View {
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

            Text("Select Size")
                .font(.title2)
                .padding()

            Picker("Size", selection: $selectedSize) {
                ForEach(sizeOptions, id: \.self) { size in
                    Text(size).tag(size)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button(action: {
                addStudent()
                showAddSheet = false
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
                showAddSheet = false
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

    private func addStudent() {
        guard !newStudentID.isEmpty, !selectedItem.isEmpty, !selectedSize.isEmpty else { return }
        
        let newStudent = StudentItem(studentID: newStudentID, item: selectedItem, size: selectedSize)
        orderData.listOfStudentIDs.append(newStudent)
    }
}
