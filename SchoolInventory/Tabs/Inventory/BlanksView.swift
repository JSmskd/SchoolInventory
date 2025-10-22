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
    init(blank: JSString = "") {
        if blank == ""{
            predicate = .init(value: true)
            FILTERTEXT = []
        } else {
            predicate = .init(format: "tags CONTAINS %@", blank.text)
            FILTERTEXT = [blank.text]
        }
        recordType = "blank"
    }
    init(design: JSString = "") {
        if design == ""{
            predicate = .init(value: true)
            FILTERTEXT = []
        } else {
            predicate = .init(format: "tags CONTAINS %@", design.text)
            FILTERTEXT = [design.text]
        }
        recordType = "Item"
    }
    init(design: [JSString] = []) {
        if design.isEmpty {
            predicate = .init(value: true)
        } else if design.count == 1 {
            predicate = .init(format: "tags CONTAINS %@", design.first!.description)
        } else {
            var p:[NSPredicate] = []
            for iter in design { p.append(.init(format: "tags CONTAINS %@", iter.description)) }
            predicate = NSCompoundPredicate(andPredicateWithSubpredicates: p)
        }
        FILTERTEXT = design.String()
        recordType = "Item"
    }
    init(blank: [JSString] = []) {
        if blank.isEmpty {
            predicate = .init(value: true)
        } else if blank.count == 1 {
            predicate = .init(format: "tags CONTAINS %@", blank.first!.description)
        } else {
            var p:[NSPredicate] = []
            for iter in blank { p.append(.init(format: "tags CONTAINS %@", iter.description)) }
            predicate = NSCompoundPredicate(andPredicateWithSubpredicates: p)
        }
        FILTERTEXT = blank.String()
        recordType = "blank"
    }
    @State var listems: [blDe] = []
    func fetchData () {
        let p = predicate// NSPredicate(value: true)
        let db = gbl.db
        db.fetch(withQuery: .init(recordType: recordType, predicate: p)) { m in
            listems = []
            var mm : (matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)], queryCursor: CKQueryOperation.Cursor?)?
            do {
                mm = try m.get()
                
            } catch {
                print(error)
            }
            if mm != nil {
                for res in mm!.matchResults {
                    
                    let b = try? res.1.get()
                    if b != nil {
                        let a = blDe(b!)
                        
                        if a != nil {
                            listems.append(a!)
                        }
                    }
                }
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
                                    ForEach(itm.self.to/*do not rememove the slef*/ , id:\.self) { sty in
                                        
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
                            print("checks stock")
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
//            .alert(isPresented: $showStockAlert) {
//                Alert(
//                    title: Text("Stock Status"),
//                    message: Text(stockAlertMessage),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
        }
        .onAppear {
            fetchData()
        }
    }
}

#Preview {

    BlanksView(design: "Test")
    
}

