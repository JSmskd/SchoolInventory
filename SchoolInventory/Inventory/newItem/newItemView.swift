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
        //        print("]")/
    }
    init (blank:blDe) {
        recName = blank.id
        recordType = blank.type
        catagory = blank.cats
        hbed = blank
        originals = blank.to
        name = blank.name
        NAME = blank.n ?? ""
        //        print("[")
        var t:[String] = []
        for i in blank.to {
            t.append(i.recordName)
            //            print("\t\(i.recordName)")
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
                    }
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
                            TextField("", text: $stuff[i].n).foregroundStyle(.yellow)
                            
                            TextField("", text: Binding(get: {
                                stuff[i].q.description
                            }, set: { v in
                                let b = stuff[i].q
                                stuff[i].q = Int64(v) ?? b
                                //                        if Int(v) != nil {$stuff[i].q = Int(v)!}
                                //                        Int()
                            }) )
                            TextField("", text: Binding(get: {
                                stuff[i].price.description
                            }, set: { v in
                                let b = stuff[i].price
                                stuff[i].price = Int64(v) ?? b
                                //                        if Int(v) != nil {$stuff[i].q = Int(v)!}
                                //                        Int()
                            })).foregroundStyle(.blue)
                        }.textFieldStyle(.roundedBorder)
                    }.onDelete { inde in
                        for(i)in(inde){if(stuff[i].posted){gbl.db.delete(withRecordID:stuff.remove(at: i).generateCKRecord().recordID){id,er in}}}
                    }
                }
            }
            Button("Cancel") {
                dismiss()
            }
//            Button("SET AS TEST") {
//                recName = "TEST";
//                name = "TEST"
//            }
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
//                print(rec.allKeys())
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
                    //            print(stuff)
                }
        }
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image, images:$images)
            }
        }
    }
    func getstuff() {
        stuff = []
        //        var ready:[snake] = []
        gbl.db.fetch(withRecordIDs: originals) { r in
            var recs:[snake] = []
            var ta = try? r.get()
            
            if ta != nil {
                for i in ta! {
                    var tb = try? i.value.get()
                    if tb != nil {
                        recs.append(snake(tb!))
                    }
                    
                }
            }
            stuff = recs
        }
    }
}

//sillySize => ss => ssssss => snake
struct snake : Identifiable, Hashable {
    var id:String
    var q:Int64
    var name:String
    var n:String
    var price:Int64
    
    var posted:Bool
    init() {
        id = UUID().uuidString
        q = 0
        name = "NONE"
        n = "NNE"
        price = 0
        posted = false
    }
    init (_ record:CKRecord) {
        id = record.recordID.recordName
        q = record["quantity"] as! Int64
        name = record["longName"] as! String
        n = record["shortName"] as! String
        price = record["cost"] as! Int64
        posted = true
    }
    init(id:String, cost:Int64, name:String, n:String,quantity:Int64, posted:Bool = false) {
        self.id = id
        self.price = cost
        self.name = name
        self.n = n
        self.q = quantity
        self.posted = posted
    }
    func generateCKRecord(_ parentID:blDe) -> CKRecord {
        var record = CKRecord(recordType: "blankSize", recordID: .init(recordName: id))
        record["quantity"] = q
        record["longName"] = name
        record["shortName"] = n
        record["cost"] = price
        record["blank"] = CKRecord.Reference.init(record: parentID.record, action: .none)
        return record
    }
    func generateCKRecord() -> CKRecord {
        var record = CKRecord(recordType: "blankSize", recordID: .init(recordName: id))
        record["quantity"] = q
        record["longName"] = name
        record["shortName"] = n
        record["cost"] = price
//        record["blank"] = CKRecord.Reference.init(record: parentID.record, action: .none)
        return record
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: Image?
    @Binding var images: [UIImage]
    
    init(isShown: Binding<Bool>, image: Binding<Image?>, images: Binding<[UIImage]>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
        _images = images
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        images.append(unwrapImage)
        imageInCoordinator = Image(uiImage: unwrapImage)
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
struct CaptureImageView: UIViewControllerRepresentable {
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var images: [UIImage]
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, images: $images)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
