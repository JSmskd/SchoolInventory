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
                                
                                
                                
                                Text("ID: "/*\(studentItem.wrappedValue.pickupIdentifier)"*/)
                                Text(/*"\(studentItem.wrappedValue.itemsOrdered.count)*/" unique items")
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
        print("refreshing")
        listOfStudentIDs = []
        var orders:Array<order> {get {listOfStudentIDs} set {listOfStudentIDs = newValue}}

        let query = CKQuery(recordType: "Order", predicate: .init(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "___createTime", ascending: false)]

        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withQuery: query) { results in
            let _ = results.map {
            $0.matchResults.map({
//                print($1)
                var i = 0
                let _ = $1.map({ record in
                //                        newItems.append(order(record))
                //                                            print("newItem")
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
                while (i < listOfStudentIDs.count) {
                    _ = listOfStudentIDs.popLast()
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
                o.orderFulfilledBy = "ADMIN" //record.setObject("ADMIN" as __CKRecordObjCValue, forKey: "orderFilfilledBy")
                upload()
            }
            Button("MARK NOT DELIVERED"){
                o.orderFulfilledBy = "" //record.setObject("" as __CKRecordObjCValue, forKey: "orderFilfilledBy")
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
        o.upload()
    }
    func ref() {
        itemsOrdered = []
        let db = CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase
//        for ords in o.itemsOrdered! {
            //            print(ords.recordID)
            
//        }
    }
}
///itemsOrdered
struct io: Hashable, Identifiable {
        var id:CKRecord.ID
        var item:Item//price
        var quantity:Int64
        var style:blank//
        var blnk:blankSize//price
    var indvPrice:Int {get{item.price + Int(style.price ?? -99) + Int(blnk.price ?? -99)}}
    var price:Int {get{indvPrice*Int(quantity)}}
    init (_ ref:Item,_ qty:Int64, _ sty:blank, id:CKRecord.ID? = nil, _ selected:blankSize) {
        //            itm = Item(reference: ref)
        self.id = id ?? .init(recordName: "434A2534-3591-4163-8E84-327582A1DE11")
        quantity = qty
        style = sty
        item = ref
        blnk = selected
    }
    init (_ ref: CKRecord.ID) {
        var tid:CKRecord.ID = ref
        var titm:CKRecord.ID?
        var tqnt:Int64?
        var tblnID: CKRecord.ID?
        
        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withRecordID: ref) { r, e in
            if e == nil {
                //r is the record of the ordered item
                var recer = r!
                titm = (recer.value(forKey: "Item") as? CKRecord.Reference)?.recordID
tqnt = recer.value(forKey: "quantity") as? Int64
tblnID = (recer.value(forKey: "blankSize") as? CKRecord.Reference)?.recordID
//                tblnID (final)blank id
                
            }
        }
        id = tid
        item = Item(titm ?? CKRecord.ID.init(recordName: "F527E4A8-2B46-4930-8535-D51E6CCDC31B"))
        quantity = tqnt ?? -1
        blnk = blankSize(tblnID ?? CKRecord.ID.init(recordName: "478BD526-5E40-4ACD-89AC-EAB617929B61"))
        var nexID = (blnk.record.value(forKey: "blank") as? CKRecord.Reference)
        style = blank(nexID == nil ? CKRecord.ID.init(recordName: "FA9FAB4D-F49F-4B26-B365-7F3210C8D9EE") : nexID!.recordID )
    }//FA9FAB4D-F49F-4B26-B365-7F3210C8D9EE
    static func == (lhs: io, rhs: io) -> Bool {
        lhs.id == rhs.id
    }
}
struct blankSize:Hashable, Identifiable, CustomStringConvertible {
    var description: String {get {name?.description ?? "Nil"}}
    var id : Int { get { hashValue}}
    var name:String? {
        get {
            record.value(forKey: "") as? String
        } set {
            if newValue == nil {return}
            record.setObject(newValue! as __CKRecordObjCValue, forKey: "")
        }
    }
    var n:String? {
        get {
            record.value(forKey: "shortName") as? String
        } set {
            if newValue == nil {return}
            record.setObject(newValue! as __CKRecordObjCValue, forKey: "shortName")
        }
    }
    ///cost multiplied my 10000 {10.423  ->  10423}
    var price:Int64? {
        get {
            record.value(forKey: "cost") as? Int64
        } set {
            if newValue == nil {return}
            self.record.setObject(newValue! as __CKRecordObjCValue, forKey: "cost")
        }
    }
    var quantity:Int64? {
        get {
            record.value(forKey: "quantity") as? Int64
        } set {
            if newValue == nil {return}
            record.setObject(newValue! as __CKRecordObjCValue, forKey: "quantity")
        }
    }
    var record:CKRecord
//    init (shortName:String,longName:String,cost:Int,quantity:Int) {
//        CKR
//        self.price = cost
//        self.quantity = quantity
//        self.name = longName
//        self.n = shortName
//    }
    var isERR:Bool { get {record.recordType == "dumb"} }
    init(_ ref : CKRecord.ID) {
        var tr:CKRecord = CKRecord(recordType: "dumb")
        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withRecordID: ref) { r, e in
            if e == nil {
                tr = r!
            }
        }
            record = tr
    }
    mutating func updateSelf (_ ident:CKRecord.ID) {
        var tr:CKRecord = CKRecord(recordType: "")
        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withRecordID: ident) { r, e in
            if e == nil {
                tr = r!
            }
        }
        if tr.recordType != "" {
            record = tr
        }
    }
    mutating func updateSelf() {
        updateSelf(record.recordID)
    }
    init (record r : CKRecord) {
        record = r
    }
}

struct blank:CustomStringConvertible , Hashable, Identifiable{
    var id : CKRecord.ID {record.recordID}
    var name:String? {
        get {
            record["brandName"] as? String
        } set {
            if(newValue != nil){return}
            record["brandName"] = newValue
        }
    }
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
    var sizes:[CKRecord.ID]? {
        get {
            var temp = record["sizes"] as? [CKRecord.Reference]
            if temp == nil {return nil}
            var tea :[CKRecord.ID] = []
            for i in temp! {
                tea.append(i.recordID)
            }
            return tea
        } set {
            if(newValue != nil){return}
            var t:[CKRecord.Reference] = []
            for i in newValue! {
                t.append(CKRecord.Reference(record: .init(recordType: "blankSIZE", recordID: i), action: .none))
            }
            record["sizes"] = t
        }
    }
    var record:CKRecord
    var price:Int? {
        get {
            Int(truncatingIfNeeded: record["cost"] as? Int64 ?? 0)
        } set {
            if(newValue != nil){return}
            record["cost"] = newValue
        }
    }
    var description: String {get {name?.description ?? "Nill"}}
    init(_ ref : CKRecord.ID) {
        var tr:CKRecord = CKRecord(recordType: "dumb")
        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withRecordID: ref) { r, e in
            if e == nil {
                tr = r!
            }
        }
            record = tr
    }
//    init (name:String,sizes:[CKRecord.Reference], record:CKRecord? = nil) {
//        self.name = name
//        self.sizes = sizes
//        self.record = record
//        price = 0
//    }
    init(record r:CKRecord) {
        //        print("new blank")
        //["color", "sizes", "brandName"]
        record = r
//        name = r["brandName"] as? String ?? "ERR"
//        sizes = r["sizes"] as? [CKRecord.Reference] ?? []
        //        print(r["sizes"])
//        price = Int(truncatingIfNeeded: r["cost"] as? Int64 ?? 0)
    }
}
struct Item:Identifiable, CustomStringConvertible, Hashable/*, Codable*/ {
    var description: String {
        return "\(title) : \(price)"
    }
    var id: CKRecord.ID {get {
        record.recordID
    }}
    var record:CKRecord
    var title:String
    var Itemdescription:String
//    var reference:CKRecord.Reference?
    var images:[CKAsset]
    private var PRICE:Int64
    var price:Int {get {Int(PRICE)} set {PRICE = Int64(newValue)}}
    //    var dollar:Int {get {price / 100}}
    //    var cent:Int {get {price - (dollar * 1000)}}
    init(_ ref : CKRecord.ID) {
        var tr:CKRecord = CKRecord(recordType: "dumb")
        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withRecordID: ref) { r, e in
            if e == nil {
                tr = r!
            }
        }
            record = tr
        title = tr["title"] as? String ?? ""
        Itemdescription = tr["description"] as? String ?? ""
        images = tr["images"] as? [CKAsset] ?? []
        PRICE = tr["price"] as? Int64 ?? -1
        
        
        
    }
    init (_ tr:CKRecord) {
        record = tr
    title = tr["title"] as? String ?? ""
    Itemdescription = tr["description"] as? String ?? ""
    images = tr["images"] as? [CKAsset] ?? []
    PRICE = tr["price"] as? Int64 ?? -1
    }
    init(title: String, description: String, price: Int, images: [CKAsset]? = [], id: CKRecord? = nil,reference: CKRecord.Reference? = nil) {
        self.record = id!
        self.title = title
        self.Itemdescription = description
        self.images = images ?? []
        self.PRICE = Int64(price)
//        self.reference = reference
    }
    init(_ title: String, _ description: String, _ price: Int, images: [CKAsset]? = [], id: CKRecord? = nil, reference: CKRecord.Reference? = nil) {
        self.record = id!
        self.title = title
        self.Itemdescription = description
        self.images = images ?? []
        self.PRICE = Int64(price)
//        self.reference = reference
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
