//
//  newItemView.swift
//  SchoolInventory
//
//  Created by John Sencion on 9/15/25.
//

import SwiftUI
import UIKit // Required for UIPasteboard
import CloudKit


struct newItemView: View {
    @Environment(\.dismiss) private var dismiss
    let catagory:String?
    @State var iter:Int = 0
    @State private var recName:String = ""
    var name:Binding<String> {Binding {
        RECORDNAME ?? recName
    } set: { newValue in
        if RECORDNAME == nil {
            recName = newValue
        }
    }
        //  get {
        //        RECORDNAME ?? recName
        //    } set {
        //        if RECORDNAME == nil {
        //            recName = newValue
        //        }
        //
        //    }
    }
    @State var things:[(addPrice:Int,name:String,n:String, s:[(addPrice:Int,name:String,n:String)])] = []
    @State var whole : Int = 9
    @State var fraction : Int = 99
    let recordType:String
    let RECORDNAME:String?
    init (_ c:String, _ rt:String) {
        catagory = c == "" ? nil : c
        recordType = rt
        RECORDNAME = nil
    }
    var hbed : blDe? = nil
    init (bed:blDe) {
//        catagory = be
        RECORDNAME = bed.name
        recordType = bed.type
        catagory = nil
        hbed = bed
        getThings()
    }
    func getThings() {
        if hbed == nil {return}

        for i in hbed!.to {
            
        }
    }
    var body: some View {
        Text("Hello, World!")
        TextField("Enter Item Name", text:name)
        
        HStack {
            Text(" Defualt Price : $")
            TextField("Enter the whole dollar amount", value: $whole, format: .number).frame(maxWidth: 24 * 2)
                .background(Color.yellow).grayscale(1).cornerRadius(3)
            Text(".")
            TextField("enter the decimal amount", value: $fraction, format: .number).frame(maxWidth: 24 * 2)
                .background(Color.yellow).grayscale(1).cornerRadius(3)
        }.textFieldStyle(.plain)
            .border(.gray, width: 1)
        
        
        Text("Item preview")
        VStack {
            Text("Price : $\(whole).\(fraction)  ")
        }
        HStack {
            Button {
                things.append((addPrice:0,name:"ITEM\(iter)",n:"\(iter)", s:[]))
                iter += 1
            } label: {
                Text("Add size")
            }
//            Button {
//                
//            } label: {
//                Text("Add color")
//            }
        }
        List {
            ForEach($things, id: \.name) { i in
                HStack {
                    TextField("ID", text: i.n)
                    Button("Paste ID") {
                        if UIPasteboard.general.string != nil {
                            if UIPasteboard.general.string!.starts(with: "JSI") {
                                var it = UIPasteboard.general.string!
                                it.removeFirst();it.removeFirst();it.removeFirst()
                                i.wrappedValue.n = it
                            }
                        }
                    }
//                    Button {
//                        i.wrappedValue.s.append((addPrice:0,name:"hi",n:"h"))
//                    } label: {
//                        Text("Add Size")
//                    }
                    
//                    Text("$")
//                    TextField("addPrice", value: Binding(get: {
//                        i.wrappedValue.addPrice / 10000
//                    }, set: { v in
//                        let p = i.wrappedValue.addPrice
//                        var o : Int = 0
//                        o -= p
//                        o /= 10000
//                        o *= 10000
//                        o += p
//                        
//                        o += v * 10000
//                        
//                        i.wrappedValue.addPrice = o
//                    }), format: .number)
//                    .frame(maxWidth: 24 * 2)
//                    .background(Color.yellow).grayscale(1).cornerRadius(3)
//                    Text(".")
//                    TextField("addPrice", value: Binding(get: {
//                        (i.wrappedValue.addPrice - (i.wrappedValue.addPrice / 10000 * 10000))
//                    }, set: { v in
//                        let p = i.wrappedValue.addPrice
//                        i.wrappedValue.addPrice = p / 10000 * 10000 + v
//                        
//                    }), format: .number)
//                    .frame(maxWidth: 24 * 2)
//                    .background(Color.yellow).grayscale(1).cornerRadius(3)
//                    Text("cost: \(i.wrappedValue.addPrice / 10000)")
//                    Text("cost: \(i.wrappedValue.addPrice - (i.wrappedValue.addPrice / 10000 * 10000))")
//                    Text("cost: \(i.wrappedValue.addPrice)")
                }
                    
                    
                
                //                ForEach(i.s as! Binding<[(addPrice:Int,name:String,n:String)]>, id:\.wrappedValue.name) { n in
                //                        HStack {
                ////                            Button {
                //                                Text("•\t" + n.name.wrappedValue)
                ////                                n.wrappedValue.s.append((addPrice:0,name:"hi",n:"h"))
                ////                            } label: {
                ////                                Text("Add Size")
                ////                            }
                //
                //                            Text("$")
                //                            TextField("addPrice", value: Binding(get: {
                //
                //                                n.wrappedValue.addPrice / 10000
                //                            }, set: { v in
                //                                let p = n.wrappedValue.addPrice
                //                                var o : Int = 0
                //                                o -= p; o /= 10000; o *= 10000; o += p; o += v * 10000
                //
                //                                n.wrappedValue.addPrice = o
                //                            }), format: .number)
                //                            .frame(maxWidth: 24 * 2)
                //                                .background(Color.yellow).grayscale(1).cornerRadius(3)
                //                            Text(".")
                //                            TextField("addPrice", value: Binding(get: {
                //                                (n.wrappedValue.addPrice - (n.wrappedValue.addPrice / 10000 * 10000))
                //                            }, set: { v in
                //                                let p = n.wrappedValue.addPrice
                //                                n.wrappedValue.addPrice = p / 10000 * 10000 + v
                //
                //                            }), format: .number)
                //                            .frame(maxWidth: 24 * 2)
                //                                .background(Color.yellow).grayscale(1).cornerRadius(3)
                //                            Text("cost: \(n.wrappedValue.addPrice / 10000)")
                //                            Text("cost: \(n.wrappedValue.addPrice - (n.wrappedValue.addPrice / 10000 * 10000))")
                //                            Text("cost: \(n.wrappedValue.addPrice)")
            }
        }
        Button("Cancel") {
            dismiss()
        }
        Button("Push") {
            let db = CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase
            
            var rec:CKRecord = CKRecord(recordType: recordType, recordID: CKRecord.ID(recordName: name.wrappedValue))
            
            rec["cost"] = Int64(whole * 10000 + fraction)
            var ider:[CKRecord.Reference] = []
            for i in things {
                ider.append(.init(recordID: CKRecord.ID(recordName: i.n), action: .none))  // i.n
            }
            rec[recordType == "Item" ? "blanks" : "sizes"] = ider
            
//            rec[recordType == "Item" ? ""]
//            db.
//            db.save(rec) { r, e in
//                print(e)
//                e == CKError.
//            }
            let operation = CKModifyRecordsOperation(recordsToSave: [rec], recordIDsToDelete: nil)
            operation.savePolicy = .allKeys // Or .changedKeys, .allKeys
             db.add(operation)
            
        }.disabled(name.wrappedValue == "")
        .navigationBarBackButtonHidden()
    }
}
