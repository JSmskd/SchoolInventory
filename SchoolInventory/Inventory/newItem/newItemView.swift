//
//  newItemView.swift
//  SchoolInventory
//
//  Created by John Sencion on 9/15/25.
//

import SwiftUI
import UIKit
import CloudKit


struct newItemView: View {
    @Environment(\.dismiss) private var dismiss
    @State var images:[UIImage] = []
    @State var image: Image? = nil
    @State var showCaptureImageView = false
    @State var catagory:[String]
    @State private var recName:CKRecord.ID
    @State var NAME:String
    @State var name:String
    @State var originals:[CKRecord.ID]
    @State var things:[String]; @State var stuff:[snake] = []
    @State var whole : Int = 9
    @State var fraction : Int = 99
    @FocusState var isFocused: Int?
    
    let recordType:String
    
    var hbed : blDe? = nil
    
    init (_ c:String, _ rt:String) {
        catagory = c == "" ? [] : [c]
        recordType = rt
        recName = CKRecord.ID(recordName: UUID().uuidString)
        name = ""
        NAME = ""
        things = []
        originals = []
    }
    
    init (bed:blDe) {
        //        catagory = be
        recName = bed.id
        recordType = bed.type
        catagory = bed.cats
        hbed = bed
        name = bed.n ?? ""
        NAME = bed.name
        //        print("[")
        originals = bed.to
        var t:[String] = []
        for i in bed.to {
            t.append(i.recordName)
            print("\t\(i.recordName)")
        }
        things = t
    }
    init (blank:blDe) {
        recName = blank.id
        recordType = blank.type
        catagory = blank.cats
        hbed = blank
        originals = blank.to
        name = blank.name
        NAME = blank.n ?? ""
        var t:[String] = []
        for i in blank.to {
            t.append(i.recordName)
        }
        things = t
        stuff = []
    }
    var isItem : Bool {get{ recordType == "Item"}}
    var isBlank : Bool { get { recordType == "blank"}}
    var body: some View {
        ZStack { VStack {
            HStack {
                Text(recName.recordName)
                Text("Hello, World!")
                Button(action: {
                    self.showCaptureImageView.toggle()
                }) {
                    Image(systemName: "camera")
                }.foregroundStyle(isItem ? .blue : .gray).disabled(!isItem)
                Image(systemName: "trash.fill").foregroundStyle(.red).onTapGesture(count: 3) {
                    
                    var svec:[CKRecord.ID] = [recName]
                    if hbed != nil {
                        for i in stuff {
                            if i.posted {
                                svec.append(i.generateCKRecord(hbed!).recordID)
                            }
                        }
                    }else{print("ISNIL")}
                    for(i)in(svec){gbl.db.delete(withRecordID:i){id,er in}}
                    dismiss()
                }
                
            }
            HStack {
                ForEach(0..<images.count, id:\.self) { i in
                    Button {
                        images.remove(at: i)
                    } label: {
                        Image(systemName: "xmark.circle.fill").resizable().foregroundStyle(.gray)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    }
                    Image(uiImage: images[i]).resizable()
                        .frame(width: 250, height: 200)
                }
            }
            HStack {
                TextField("Enter The Name", text:$NAME)
                TextField("Enter the Shortened name", text: $name)
            }
            
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
                        stuff.append(.init());
                    }
                } label: {
                    Text("Add size")
                }
            }
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
            allofthem(things: $things, stuff: $stuff, recordType: recordType)
            Button("Cancel") {
                dismiss()
            }
            Button("Push") {
                let db = gbl.db; var
                
                
                rec:CKRecord = CKRecord(recordType: recordType, recordID: recName)
                rec["cost"] = Int64(whole * 10000 + fraction)
                var ider:[CKRecord.Reference] = []
                if recordType == "Item" {
                    var img:[Data] = []
                    for i in images {
                        let o = i.pngData()
                        if o != nil {img.append(o!)}
                        
                    }
                    rec["images"] = img
                    for i in things {
                        ider.append(.init(recordID: CKRecord.ID(recordName: i), action: .none))  // i.n
                    }
                } else if recordType == "blank" {
                    for i in stuff {
                        if hbed != nil {
                            ider.append(.init(record: i.generateCKRecord(hbed!), action: .none))
                        }
                    }
                }
                rec[recordType == "Item" ? "blanks" : "sizes"] = ider
                rec[recordType == "Item" ? "title" : "color"] = NAME
                rec[recordType == "Item" ? "description" : "brandName"] = name
                if catagory != [] {
                    rec[recordType == "Item" ? "tags" : "materials"] = catagory
                }
                var svec:[CKRecord] = [rec]
                if hbed != nil {
                    for (x,i) in stuff.enumerated() {
                        svec.append(i.generateCKRecord(hbed!))
                        stuff[x].posted = true
                    }
                } else { print("ISNIL") }
                
//                for i in svec {
//                    Task {
//                        do {
//                            try await gbl.db.save(i)
//                        } catch {
//                            print("ERR: \(error)")
//                        }
//                    }
//                }
//                for(i)in(rec.allKeys()){print("\(i):\(rec[i])")}
//                for i in svec {
//                    db.save(i){r,e in
//                        print("ERR:\(e!)")
//                    }
//                }
                let operation = CKModifyRecordsOperation(recordsToSave: svec, recordIDsToDelete: nil)
                operation.savePolicy = .allKeys // Or .changedKeys, .allKeys
                db.add(operation)
                
            }//.disabled(name == "")
                .navigationBarBackButtonHidden()
                .onAppear {
                    if recordType == "blank" {
                        getstuff()
                    }
                }
        }
            if (showCaptureImageView) { CaptureImageView(isShown: $showCaptureImageView, image: $image, images:$images) }
        }
    }
    func getstuff() {
        stuff = []

        gbl.db.fetch(withRecordIDs: originals) { r in
            var recs:[snake] = []
            for i in (try? r.get()) ?? [:] {
                var tb = try? i.value.get()
                if tb != nil {
                    recs.append(snake(tb!))
                }
            }
            stuff = recs
        }
    }
}

