//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI
import CloudKit

struct SearchBarView: View {
    @State private var listOfStudentIDs: [order/*StudentItem*/] = [
//        StudentItem(studentID: "12345", item: "Shirt", size: "M"),
//        StudentItem(studentID: "67890", item: "Hoodie", size: "L"),
//        StudentItem(studentID: "54321", item: "Shorts", size: "S")
    ]
    @State private var searchText = ""
    @State private var isEditing = false
    

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($listOfStudentIDs) { studentItem in
                        HStack {
                            if isEditing {
                                TextField("Student ID", text: studentItem.orderFulfilledBy /*$listOfStudentIDs.first(where: { $0.id == studentItem.id })!.studentID*/)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                TextField("Item", text: .constant(studentItem.wrappedValue.pickupIdentifier)/*$listOfStudentIDs.first(where: { $0.id == studentItem.id })!.item*/)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                TextField("Size", text: .constant("")/*$listOfStudentIDs.first(where: { $0.id == studentItem.id })!.size*/)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            } else {
                                Text(""/*studentItem.studentID.capitalized*/)
                                Spacer()
                                Text(""/*studentItem.item*/)
                                    .foregroundColor(.gray)
                                Text("Size: "/*\(studentItem.size)*/)
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
            .refreshable {
                refreshShirts()
            }
//            .onAppear {
//                refreshShirts()
//            }
        }
    }

    var studentItems: [order] {
        listOfStudentIDs
//        let lcStudentItems = listOfStudentIDs.map {
//            StudentItem(studentID: $0.studentID.lowercased(), item: $0.item.lowercased(), size: $0.size)
//        }
//        
//        if searchText.isEmpty {
//            return []//listOfStudentIDs
//        } else {
//            return lcStudentItems.filter {
//                $0.studentID.contains(searchText.lowercased()) ||
//                $0.item.contains(searchText.lowercased()) ||
//                $0.size.contains(searchText.lowercased())
//            }
//        }
    }

    func deleteItems(at offsets: IndexSet) {
        listOfStudentIDs.remove(atOffsets: offsets)
    }
    
    
    func refreshShirts() {
        print("refsihni")
        listOfStudentIDs = []
        var orders:Array<order> {get {listOfStudentIDs} set {listOfStudentIDs = newValue}}

            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "Order", predicate: predicate)
            //        let queryOperation = CKQueryOperation(query: query)
            var newItems:[order] = []
        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withQuery: query) { results in
                print("start of fetch")
//            print(results)
                results.map {
                    $0.matchResults.map({$0.1.map { record in
//                        newItems.append(order(record))
//                                            print("newItem")
                        DispatchQueue.main.async {
                            _listOfStudentIDs.wrappedValue.append(order(record))
                        }

                    }
                    })
                }

            }
//        print(newItems)
        
        }
}

#Preview {
    SearchBarView()
}
