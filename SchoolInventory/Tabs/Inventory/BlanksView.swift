//
//  BlanksView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 3/17/25.
//

import CloudKit

import SwiftUI

struct BlanksView: View {
    @State private var showEditSheet = false
    
    @State private var stockAlertMessage = ""
    @State private var showStockAlert = false
    
    private let recordType:String
    let FILTERTEXT: [String]
    var predicate : NSPredicate
    
    init(design: [JSString] = []) {
        var p:[NSPredicate] = [.init(format: "tags CONTAINS %@", gbl.realID)]
        for iter in design { p.append(.init(format: "tags CONTAINS %@", iter.description)) }
        
        predicate = NSCompoundPredicate(andPredicateWithSubpredicates: p)
        var v = design.String()
        v.append(gbl.realID)
        FILTERTEXT = v
        recordType = "Item"
    }
    init(blank: [JSString] = []) {
        var p:[NSPredicate] = [.init(format: "materials CONTAINS %@", gbl.realID)]
        for iter in blank { p.append(.init(format: "materials CONTAINS %@", iter.description)) }
        
        predicate = NSCompoundPredicate(andPredicateWithSubpredicates: p)
        var v = blank.String()
        v.append(gbl.realID)
        FILTERTEXT = v
        recordType = "blank"
    }
    @State var listems: [blDe] = []
    func fetchData () {
        let p = predicate
        print(predicate)
        Task {
            let m = try await gbl.fetch(predicate: p, recordType: recordType).get()
            
            //        }
            //        db.fetch(withQuery: .init(recordType: recordType, predicate: p)) { m in
            for res in m.self {
                    if let temp = blDe(try? res.get()) { listems.append(temp) }
            }
        }
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ScrollView {
                        
                        
                        LazyVGrid(columns: [GridItem.init(),GridItem.init(),GridItem.init()]) {
                            ForEach(0..<listems.count, id:\.self) { i in
                                VStack(spacing: 10) {
                                    let itm:blDe = listems[i]
                                    
                                    Button {
                                        UIPasteboard.general.string = "JSI" + itm.name
                                    } label : {
                                        Text(itm.name)
                                            .font(.headline)
                                    }
                                    ForEach(itm.self.to, id:\.self) { sty in
                                        
                                        Text(sty.self.self.recordName).padding() .background(Color.gray).cornerRadius(8)
                                    }
                                    NavigationLink("Edit") {
                                        newItemView(bed: itm)
                                    }
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                                .padding()
                                .background(Color(.systemGroupedBackground))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                    HStack {
                        Button {
                            print("*checks stock*")
                        } label: {
                            Text("Check Stock")
                                .font(.title2)
                                .padding()
                                .background(gbl.darkBrown)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink {
                            newItemView(FILTERTEXT, recordType)
                        } label: {
                            Text("Add blank")
                                .font(.title2)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            fetchData()
        }
    }
}

#Preview {

    BlanksView(design: ["Test"])
    
}

