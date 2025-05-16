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
                                Text("ID: \(studentItem.wrappedValue.pickupIdentifier)")
                                Text("\(studentItem.wrappedValue.itemsOrdered.count) unique items")
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

//    func deleteItems(at offsets: IndexSet) {
//        listOfStudentIDs//.remove(atOffsets: offsets)
//    }


    func refreshShirts() {
        print("refsihni")
        listOfStudentIDs = []
        var orders:Array<order> {get {listOfStudentIDs} set {listOfStudentIDs = newValue}}

        let query = CKQuery(recordType: "Order", predicate: .init(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "___createTime", ascending: false)]

        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withQuery: query) { results in
            let _ = results.map {
            $0.matchResults.map({
//                print($1)
                $1.map{ record in
                //                        newItems.append(order(record))
                //                                            print("newItem")
                DispatchQueue.main.async {
                    _listOfStudentIDs.wrappedValue.append(order(record))
                }

                }
            })
            }.self

        }
        //        print(newItems)

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
                o.record.setObject("ADMIN" as __CKRecordObjCValue, forKey: "orderFilfilledBy")
                upload()
            }
            Button("MARK NOT DELIVERED"){
                o.record.setObject("" as __CKRecordObjCValue, forKey: "orderFilfilledBy")
                upload()
            }
            Text(toPrice(totalPrice))
            .clipShape(RoundedRectangle(cornerSize: .init(width: 100, height: 100)))
            List {
                ForEach($itemsOrdered, id:\.self ) { i in
                    HStack{
                        Text("\(i.wrappedValue.item.title)")
                        Spacer()
                        Text("\(toPrice(i.wrappedValue.indvPrice)) x \(i.wrappedValue.quantity.description) : \(toPrice(i.wrappedValue.price))")
                    }
                }
            }
        }.onAppear {
            ref()
        }

    }
    func upload() {
        DispatchQueue.main.schedule {
            CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.save(o.record, completionHandler: { r, e in

                if e == nil {
                    o.record = r!
                } else {
                    print(e!)
                }
            })
        }
    }
    func ref() {
        itemsOrdered = []
        let db = CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase
        for ords in o.itemsOrdered {
            //            print(ords.recordID)
            //get the orderItem
            db.fetch(withRecordID: ords.recordID) { record, error in
                if record != nil {
                    //                    print("itemOrder")
                    let r:CKRecord = record.unsafelyUnwrapped
                    //                            a.wrappedValue.name = r["brandName"] as? String ?? a.wrappedValue.name


                    //                    r["quantity"] as? Int64 ?? 0
                    if r["Item"] as? CKRecord.Reference != nil {
                        ///item
                        var i:Item?
                        print(r.recordType)
                        let r2 = r["Item"] as! CKRecord.Reference
                        //item of orderItem
                        db.fetch(withRecordID: r2.recordID) { record, error in
                            if record != nil {
                                print("item")
                                let r:CKRecord = record.unsafelyUnwrapped
                                i = Item.init(title: r["title"] as? String ?? "CAN NOT GET", description: r["description"] as? String ?? "CAN NOT GET", price: Int(r["cost"] as? Int64 ?? 0), images: nil, id: r, reference: nil)
                                //                            i = .init(record: r)

                                db.fetch(withRecordID: ords.recordID) { record, error in
                                    if record != nil {
                                        //                                    print("blank")
                                        let r:CKRecord = record.unsafelyUnwrapped
                                        ///blank
                                        let b:blank = blank.init(record: r)
                                        ///blankSize
                                        var s:blankSize?
                                        db.fetch(withRecordID: ords.recordID) { record, error in
                                            if record != nil {
                                                //                                            print("size")
                                                let r:CKRecord = record.unsafelyUnwrapped
                                                s = .init(record: r)
                                                if i != nil && s != nil {
                                                    print("all good")
                                                    itemsOrdered.append(io.init(i!, r["quantity"] as? Int64 ?? 0, b, id: nil, s!))
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                }
            }
        }
    }
}
///itemsOrdered
struct io: Hashable, Identifiable {
        var id:CKRecord.Reference?
        var item:Item//price
        var quantity:Int64
        var style:blank//
        var blnk:blankSize//price
    var indvPrice:Int {get{item.price + style.price + blnk.price}}
    var price:Int {get{indvPrice*Int(quantity)}}
    init (_ ref:Item,_ qty:Int64, _ sty:blank, id:CKRecord.Reference? = nil, _ selected:blankSize) {
        //            itm = Item(reference: ref)
        quantity = qty
        style = sty
        item = ref
        blnk = selected
    }
    static func == (lhs: io, rhs: io) -> Bool {
        lhs.id == rhs.id
    }
}
struct blankSize:Hashable, Identifiable, CustomStringConvertible {
    var description: String {get {name}}
    var id : Int { get { hashValue}}
    var name:String
    var n:String
    ///cost multiplied my 10000 {10.423  ->  10423}
    var price:Int
    var quantity:Int
    var record:CKRecord?
    init (shortName:String,longName:String,cost:Int,quantity:Int) {
        self.price = cost
        self.quantity = quantity
        self.name = longName
        self.n = shortName
    }
    mutating func updateSelf () {
        if record?.recordID == nil { print("fail"); return}
        var shortname = ""
        var longname = ""
        var p = 0
        var qty = 0
        var rec = record
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: record.unsafelyUnwrapped.recordID) { record, e in

            if record != nil {
                rec = record.unsafelyUnwrapped
                let r = record.unsafelyUnwrapped

                shortname =  r["shortName"] as? String ?? "err"
                longname = r["longName"] as? String ?? "error"
                qty = r["quantity"] as? Int ?? 0
                p = r["cost"] as? Int ?? 0
            }

        }
        //fetch(withRecordID: reference) { record, error in
        price = p
        quantity = qty
        name = longname
        n = shortname
        record = rec
    }
    init (record r : CKRecord) {
        record = r
        n =  r["shortName"] as? String ?? "err"
        name = r["longName"] as? String ?? "error"
        quantity = r["quantity"] as? Int ?? 0
        price = Int(truncatingIfNeeded:r["cost"] as? Int ?? 0)
    }
}

struct blank:CustomStringConvertible , Hashable, Identifiable{
    var id : Int { get { hashValue}}
    var name:String
    func getCol() -> Color {
        switch name {
            case "orange":
                return .orange
            case "white":
                return .white
            case "ERR":
                return .orange
            default:
                return.clear
        }
    }
    var sizes:[CKRecord.Reference]
    var record:CKRecord?
    var price:Int
    var description: String {get {name}}
    init (name:String,sizes:[CKRecord.Reference], record:CKRecord? = nil) {
        self.name = name
        self.sizes = sizes
        self.record = record
        price = 0
    }
    init(record r:CKRecord) {
        //        print("new blank")
        //["color", "sizes", "brandName"]
        record = r
        name = r["brandName"] as? String ?? "ERR"
        sizes = r["sizes"] as? [CKRecord.Reference] ?? []
        //        print(r["sizes"])
        price = Int(truncatingIfNeeded: r["cost"] as? Int64 ?? 0)
    }
}
struct Item:Identifiable, CustomStringConvertible, Hashable/*, Codable*/ {
    var description: String {
        return "\(title) : \(price)"
    }
    var id: CKRecord.ID? {get {
        record?.recordID
    }}
    var record:CKRecord?
    var title:String
    var Itemdescription:String
    var reference:CKRecord.Reference?
    var images:[CKAsset]?
    var price:Int
    //    var dollar:Int {get {price / 100}}
    //    var cent:Int {get {price - (dollar * 1000)}}
    init(title: String, description: String, price: Int, images: [CKAsset]? = [], id: CKRecord? = nil,reference: CKRecord.Reference? = nil) {
        self.record = id
        self.title = title
        self.Itemdescription = description
        self.images = images
        self.price = price
        self.reference = reference
    }
    init(_ title: String, _ description: String, _ price: Int, images: [CKAsset]? = [], id: CKRecord? = nil, reference: CKRecord.Reference? = nil) {
        self.record = id
        self.title = title
        self.Itemdescription = description
        self.images = images
        self.price = price
        self.reference = reference
    }
}
func toPrice(_ doub:Int) -> String {
    let cuttoff = 10000
    let dollars:Int = doub / cuttoff
    let cent = doub % cuttoff
    var cents = cent.description
    while cents.last == "0" {
        cents.removeLast()
    }
    while cents.count < 2 {
        cents += "0"
    }
    //    let cents:Int = doub - (dollars * 10000)
    return "$\(dollars).\(cents)"
}
