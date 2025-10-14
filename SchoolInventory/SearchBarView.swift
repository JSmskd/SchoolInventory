//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI
import CloudKit

struct SearchBarView: View {
    @State private var listOfStudentIDs: [order/*StudentItem*/] = []
    @State private var searchText = ""
    @State private var isEditing = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($listOfStudentIDs, id: \.self) { studentItem in
                        NavigationLink {
                            //OrderItemView
                            OrderItemV(o: studentItem)
                        } label: {
                            HStack {
//                            if isEditing {
//                                TextField("Student ID", text: studentItem.orderFulfilledBy /*$listOfStudentIDs.first(where: { $0.id == studentItem.id })!.studentID*/)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                                TextField("Item", text: .constant(studentItem.wrappedValue.pickupIdentifier)/*$listOfStudentIDs.first(where: { $0.id == studentItem.id })!.item*/)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                                TextField("Size", text: .constant("")/*$listOfStudentIDs.first(where: { $0.id == studentItem.id })!.size*/)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                            } else {
//                                Text(""/*studentItem.studentID.capitalized*/)
//                                Spacer()
//                                Text(""/*studentItem.item*/)
//                                    .foregroundColor(.gray)
//                                Text("Size: "/*\(studentItem.size)*/)
//                                    .foregroundColor(.darkBrown)
//                                Image(systemName: "person.fill")
//                                    .foregroundColor(.darkOrange)
//                            }
                                
                                
                                Text("ID: \(studentItem.wrappedValue.pickupIdentifier ?? "ERR")")
                                Text("\((studentItem.wrappedValue.itemsOrdered ?? []).count) unique items")
                            }
                            
                            .tint(studentItem.wrappedValue.orderFulfilledBy == "" ? .white : .gray)
                        }
                    }
//                    .onDelete(perform: deleteItems)
                }
                .searchable(text: $searchText)
                .navigationTitle("Online Orders")
                .navigationBarItems(
                    trailing: Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                )
            }
            .onAppear {
                refreshShirts()
            }
            .refreshable {
                refreshShirts()
            }
        }
    }
    
    var studentItems: [order] {
        listOfStudentIDs
    }
    
    
    func refreshShirts() {
        print("refreshing")
        listOfStudentIDs = []
        var orders:Array<order> {get {listOfStudentIDs} set {listOfStudentIDs = newValue}}
        
        let query = CKQuery(recordType: "Order", predicate: .init(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "___createTime", ascending: false)]
        
        gbl.db.fetch(withQuery: query) { results in
            let _ = results.map {
                $0.matchResults.map({
                    var i = 0
                    let _ = $1.map({ record in
                        DispatchQueue.main.async {
                            let t = order(record)
                            if i < listOfStudentIDs.count {
                                listOfStudentIDs[i] = t
                            } else {
                                listOfStudentIDs.append(t)
                            }
                            i += 1
                        }
                        
                    })
                    while (i < listOfStudentIDs.count) {listOfStudentIDs.popLast()}
                })
            }.self
        }
    }
}

struct OrderItemV: View {
    ///order
    @Binding var o:order
    @State private var itemsOrdered:[io] = []
    private var totalPrice:Int{get{var r=0;for(i)in(itemsOrdered){r+=i.price};return(r)}}
    var body: some View {
        VStack{
            Button("MARK DELIVERED"){
                o.orderFulfilledBy = "ADMIN"
                upload()
            }
            Button("MARK NOT DELIVERED"){
                o.orderFulfilledBy = ""
                upload()
            }
            Text(gbl.toPrice(totalPrice))
                .clipShape(RoundedRectangle(cornerSize: .init(width: 100, height: 100)))
            List {
                ForEach($itemsOrdered, id:\.self ) { i in
                    HStack{
                        Text("\(i.wrappedValue.item.title)")
                        Spacer()
                        Text("\(gbl.toPrice(i.wrappedValue.indvPrice)) x \(i.wrappedValue.quantity.description) : \(gbl.toPrice(i.wrappedValue.price))")
                    }
                }
            }
        }.onAppear {
            ref()
        }
        
    }
    func upload() {
        o.upload()
    }
    func ref() {
        itemsOrdered = []
//        for ords in o.itemsOrdered! {
//            print(ords.recordID)

//        }
    }
}
