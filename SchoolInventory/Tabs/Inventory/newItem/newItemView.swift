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
    var realsFound:Int = 0
    let recordType:String
    
    var hbed : blDe? = nil
    
    init (_ c:[String], _ rt:String) {
//        print(c)
        recordType = rt
        recName = CKRecord.ID(recordName: UUID().uuidString)
        name = ""
        NAME = ""
        things = []
        originals = []
        var r = 0
        var cee : [String] = []
        for cat in c {
            if cat == gbl.realID {
                r+=1
            } else {
                cee.append(cat)
            }
        }
        realsFound = r
        catagory = cee

    }
    
    init (bed:blDe) {
//        print(bed.cats)
//        catagory = be
        recName = bed.id
        recordType = bed.type
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
        var r = 0
        var cee : [String] = []
        for cat in bed.cats {
            if cat == gbl.realID {
                r+=1
            } else {
                cee.append(cat)
            }
        }
        realsFound = r
        catagory = cee
    }
    init (blank:blDe) {
//        print(blank.cats)
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
        var cee : [String] = []
        var r = 0
        for cat in blank.cats {
            if cat == gbl.realID {
                r+=1
            } else {
                cee.append(cat)
            }
        }
        realsFound = r
        catagory = cee
    }
    var isItem : Bool {get{ recordType == "Item"}}
    var isBlank : Bool { get { recordType == "blank"}}
    @State var WARNING:Bool = false
    var dis:Bool {
        
//                for i in stuff {
//                    if i.name
//                }
        for i in things {
            if i.starts(with: "&TEMP") { return true}
        }
        return false
    }
    
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
                    
                    WARNING = true
                }
                .alert(isPresented: $WARNING) {
                    Alert(
                        title: Text("Stock Status"),
                        message: Text("You are going to delete this item and possible all of its child nodes, are you sure?"),
                        
                        primaryButton: .destructive(Text("DELETE"), action: {
//                                        var svec:[CKRecord.ID] = [recName]
//                                        if hbed != nil {
//                                            for i in stuff {
//                                                if i.posted {
//                                                    svec.append(i.generateCKRecord(hbed!).recordID)
//                                                }
//                                            }
//                                        }else{print("ISNIL")}
//                                        for(i)in(svec){gbl.db.delete(withRecordID:i){id,er in}}
//                                        DispatchQueue.main.async {
                            Task {
                                var r = try? await gbl.db.record(for: recName)
                                if r != nil{
                                    var ks:[String] = []
                                    for k in (r![(recordType == "Item" ? "tags" : "materials")] as? [String] ?? []) {
                                        if k != gbl.realID { ks.append(k)}
                                    }
                                    r!.setValue(ks, forKey: (recordType == "Item" ? "tags" : "materials"))
                                    gbl.db.save(r!) { r, e in
                                        if e != nil {
                                            print(e)
                                        }
                                    }
                                    
                                }
                            }
                            //                                        }
                            dismiss()
                        }),
                        secondaryButton: .cancel(Text("nevermind")))
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
            
            VStack {
                Text("Item preview")
                HStack {
                    Text(NAME.blank() ?? "NAME").foregroundStyle(NAME.isEmpty ? .gray : .black)
                    Text(name.blank() ?? "name").foregroundStyle(name.isEmpty ? .gray : .black)
                    HStack(spacing:0) {
                        Text("[")
                        ForEach(0..<catagory.count, id:\.self) { i in
                            if i != 0 { Text(", ") }; Text(catagory[i]) }
                        Text("]")
                    }
                    Text("Price : $\(whole).\(fraction)  ")
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
                
            }.frame(maxWidth: .infinity, alignment: .trailing)
            allofthem(things: $things, stuff: $stuff, recordType: recordType)
            Button("Cancel") {
                dismiss()
            }
            Button("Push") {
                let db = gbl.db; let
                
                
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
                var usec:[String] = []
                for real in 0..<realsFound {
                    usec.append(gbl.realID)
                }; for real in catagory {
                    usec.append(real)
                }
                print(realsFound)
                print(usec)
                print(catagory)
                if catagory != [] {
                    rec[recordType == "Item" ? "tags" : "materials"] = usec
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
                
            }
            .disabled(dis)
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
        gbl.db.fetch(withRecordIDs: originals) { r in
            var recs:[snake] = []
            for i in (try? r.get()) ?? [:] {
                let tb = try? i.value.get()
                if tb != nil {
                    recs.append(snake(tb!))
                }
            }
            stuff = recs
        }
    }
}

