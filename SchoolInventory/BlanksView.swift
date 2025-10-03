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
    let FILTERTEXT: String
    var predicate : NSPredicate
    init(blank: String = "") {
        if blank == ""{
            predicate = .init(value: true)
        } else {
            predicate = .init(format: "tags CONTAINS %@", blank)
        }
        FILTERTEXT = blank
        recordType = "blank"
    }
    init(design: String = "") {
        if design == ""{
            predicate = .init(value: true)
        } else {
            predicate = .init(format: "tags CONTAINS %@", design)
        }
        FILTERTEXT = design
        recordType = "Item"
    }
    @State var listems: [blDe] = []
    func fetchData () {
        let p = predicate// NSPredicate(value: true)
        let db = gbl.db
        db.fetch(withQuery: .init(recordType: recordType, predicate: p)) { m in
            listems = []
            var mm : (matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)], queryCursor: CKQueryOperation.Cursor?)?
            do {
                //                m.get
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
                                // Gildan View
                                VStack(spacing: 10) {
                                    let itm:blDe = listems[i]
                                    
                                    //Gildan5000
                                    //                            do {
                                    //                            Text("")
                                    //                            } catch {
                                    //                            Text("")
                                    //                            }
                                    //                            let img = items[i].images
                                    //                            if img.first != nil ? img.first!.fileURL != nil ? true : false : false {
                                    //                                Image(items[i].images.first != nil ? items[i].images.first!.fileURL ?? "Gildan5000" : "Gildan5000")
                                    //                                    .resizable()
                                    //                                    .scaledToFit()
                                    //                                    .frame(height: 100)
                                    //                            } else {
                                    //                                Image(items[i].images.first != nil ? items[i].images.first!.fileURL ?? "Gildan5000" : "Gildan5000")
                                    //                                    .resizable()
                                    //                                    .scaledToFit()
                                    //                                    .frame(height: 100)
                                    //                            }
                                    //                                Image(i)
                                    //                                    .resizable()
                                    //                                    .scaledToFit()
                                    //                                    .frame(height: 100)

                                    Button {
                                        UIPasteboard.general.string = "JSI" + itm.name
                                    } label : {
                                        Text(itm.name)
                                            .font(.headline)
                                    }
                                    //                            Text("Color: \(gildanColor)")
                                    //                                .font(.subheadline)
                                    //                                .foregroundColor(.gray)
                                    
                                    //                            Text("Small: \(gildanSmallQuantity)")
                                    //                            Text("Medium: \(gildanMediumQuantity)")
                                    //                            Text("Large: \(gildanLargeQuantity)")
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
                        Button(action: checkStock) {
                            Text("Check Stock")
                                .font(.title2)
                                .padding()
                                .background(gbl.darkBrown)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }//.disabled()
                        
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
//                .navigationTitle(FILTERTEXT)
                
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
    
    func saveChanges() {
//        saveStockData()
    }
    
    func checkStock() {
        //        if gildanSmallQuantity < 3 || gildanMediumQuantity < 3 || gildanLargeQuantity < 3 ||
        //            bellaSmallQuantity < 3 || bellaMediumQuantity < 3 || bellaLargeQuantity < 3 {
        //            stockAlertMessage = "Low stock! Some sizes have less than 3 items."
        //        } else {
        //            stockAlertMessage = "Enough stock! All sizes have more than 3 items."
        //        }
        showStockAlert = true
    }
    
    func saveStockData() {
        
    }
    
    func loadStockData() {
        
    }
}

#Preview {

    BlanksView(design: "Test")
    
}

