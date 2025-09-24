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
    @State var catagory:[String]
//    @State var iter:Int = 0
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
    @State var originals:[CKRecord.ID]
    @State var things:[String]; @State var stuff:[snake] = []
    @State var whole : Int = 9
    @State var fraction : Int = 99
    @FocusState var isFocused: Int?
    let recordType:String
    let RECORDNAME:String?
    init (_ c:String, _ rt:String) {
        catagory = c == "" ? [] : [c]
        recordType = rt
        RECORDNAME = nil
        things = []
        originals = []
    }
    var hbed : blDe? = nil
    init (bed:blDe) {
//        catagory = be
        RECORDNAME = bed.name
        recordType = bed.type
        catagory = bed.cats
        hbed = bed
//        print("[")
        originals = bed.to
        var t:[String] = []
        for i in bed.to {
            t.append(i.recordName)
            print("\t\(i.recordName)")
        }
        things = t
//        print("]")/
    }
    init (blank:blDe) {
        RECORDNAME = blank.name
        recordType = blank.type
        catagory = blank.cats
        hbed = blank
        originals = blank.to
//        print("[")
        var t:[String] = []
        for i in blank.to {
            t.append(i.recordName)
//            print("\t\(i.recordName)")
        }
        things = t
        stuff = []
    }
    func getstuff() {
        stuff = []
//        var ready:[snake] = []
        gbl.db.fetch(withRecordIDs: originals) { r in
            var recs:[snake] = []
            do {
                var ta = try? r.get()
                if ta != nil {
                    for i in ta! {
                        var tb = try? i.value.get()
                        if tb != nil {
                            recs.append(snake(tb!))
                        }
                        
                    }
                }
            }
            stuff = recs
//            snake()
//            stuff
            //            if recs.isEmpty {return}
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
                if recordType == "Item" {
                    things.append("\(Int.random(in: 0..<10000))")
                } else {
                    stuff
                }
//                iter += 1
            } label: {
                Text("Add size")
            }
//            Button {
//                
//            } label: {
//                Text("Add color")
//            }
        }
//        Button("hi"){isFocused=nil;print(isFocused)}
        VStack{
            HStack {
                ForEach(0..<catagory.count, id: \.self) { i in
                    HStack {
                        Button {
                            catagory.remove(at: i)
                        } label: {
                            Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                        }
                        .disabled((isFocused ?? -1) == i)
                        TextField("Name", text: $catagory[i])
                    }
                    .padding().focused($isFocused,equals: i)
                }
                Button {
                    catagory.append("")
                } label: {
                    Image(systemName: "plus.circle.fill")
                    
                }
            }
                .padding()
                
                HStack {
                    ForEach(0..<catagory.count, id:\.self) { i in
                        if i != 0 {
                            Text(", ")
                        }
                        Text(catagory[i])
                    }
                }
            }
        if recordType == "Item" {
            List($things, id: \.self, editActions: .all) { i in
                HStack {
                    TextField("ID", text: i)
                    Button("Paste ID") {
                        if UIPasteboard.general.string != nil {
                            if UIPasteboard.general.string!.starts(with: "JSI") {
                                var it = UIPasteboard.general.string!
                                it.removeFirst();it.removeFirst();it.removeFirst()
                                i.wrappedValue = it
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
        } else {
            List{
                HStack{Text("name :").foregroundStyle(.red)
                    Text("n :").foregroundStyle(.yellow)
                    Text("quantity :")
                    Text("cost * 10000") .foregroundStyle(.blue)
                }
                ForEach(0..<stuff.count, id:\.self) { i in
                    HStack {
                        Text(stuff[i].id).foregroundStyle(.gray)
                        
                        TextField("", text: $stuff[i].name).foregroundStyle(.red)
                        //                    Text(stuff[i].name)
                        
                        TextField("", text: $stuff[i].n).foregroundStyle(.yellow)
                        
                        TextField("", text: Binding(get: {
                            stuff[i].q.description
                        }, set: { v in
                            var b = stuff[i].q
                            stuff[i].q = Int64(v) ?? b
                            //                        if Int(v) != nil {$stuff[i].q = Int(v)!}
                            //                        Int()
                        }) )
                        TextField("", text: Binding(get: {
                            stuff[i].price.description
                        }, set: { v in
                                                    var b = stuff[i].price
                            stuff[i].price = Int64(v) ?? b
                            //                        if Int(v) != nil {$stuff[i].q = Int(v)!}
                            //                        Int()
                        })).foregroundStyle(.blue)
                    }
                }
            }
        }
        Button("Cancel") {
            dismiss()
        }
        Button("Push") {
            let db = gbl.db
            
            var rec:CKRecord = CKRecord(recordType: recordType, recordID: CKRecord.ID(recordName: name.wrappedValue))
            
            rec["cost"] = Int64(whole * 10000 + fraction)
            var ider:[CKRecord.Reference] = []
            for i in things {
                ider.append(.init(recordID: CKRecord.ID(recordName: i), action: .none))  // i.n
            }
            rec[recordType == "Item" ? "blanks" : "sizes"] = ider
//            if recordType == "Item" {
                if catagory != [] {
                    rec[recordType == "Item" ? "tags" : "materials"] = catagory
                }
//            }
            
//            rec[recordType == "Item" ? ""]
//            db.
//            db.save(rec) { r, e in
//                print(e)
//                e == CKError.
//            }
            var svec:[CKRecord] = [rec]
            for i in stuff {
                svec.append(i.generateCKRecord())
            }
            let operation = CKModifyRecordsOperation(recordsToSave: svec, recordIDsToDelete: nil)
            operation.savePolicy = .allKeys // Or .changedKeys, .allKeys
             db.add(operation)
            
        }.disabled(name.wrappedValue == "")
        .navigationBarBackButtonHidden()
        .onAppear {
            if recordType == "blank" {
                getstuff()
            }
//            print(stuff)
        }
    }
}

struct gbl {
    static var db = CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase
}
//#Preview {
//    newItemView("abc", "def")
//}
//sillySize => ss => ssssss => snake
struct snake : Identifiable, Hashable {
    var id:String
    var q:Int64
    var name:String
    var n:String
    var price:Int64
    init() {
        id = UUID().uuidString
        q = 0
        name = "NONE"
        n = "NNE"
        price = 0
    }
    init (_ record:CKRecord) {
        id = record.recordID.recordName
        q = record["quantity"] as! Int64
        name = record["longName"] as! String
        n = record["shortName"] as! String
        price = record["cost"] as! Int64
    }
    init(id:String, cost:Int64, name:String, n:String,quantity:Int64) {
        self.id = id
        self.price = cost
        self.name = name
        self.n = n
        self.q = quantity
    }
    func generateCKRecord() -> CKRecord {
        var record = CKRecord(recordType: "blankSize", recordID: .init(recordName: id))
        record["quantity"] = q
        record["longName"] = name
        record["shortName"] = n
        record["cost"] = price
        return record
    }
}
