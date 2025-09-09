//
//  StudentItem.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 3/19/25.
//


import SwiftUI
import CloudKit

struct order:Hashable,Identifiable {
    var id: CKRecord.ID
//    var record:CKRecord
//    let id: UUID = UUID()
    var itemsOrdered:[io]? = nil
    var orderFulfilledBy:String? = nil
    var pickupIdentifier: String? = nil
    init(_ re:CKRecord) {
        id = re.recordID
        download()
//        var itemsOrdered:[io] {get {
//            record["itemsOrdered"] as? [io] ?? []
//        } set {
//            record["itemsOrdered"] = newValue
//        }}
//        var orderFulfilledBy:String {get {
//            record["orderFulfilledBy"] as? String ?? "ERR"
//        } set {
//            record["orderFulfilledBy"] = newValue
//        }}
//        var pickupIdentifier: String {get {
//            record["pickupIdentifier"] as? String ?? "ERR"
//        } set {
//            record["pickupIdentifier"] = newValue
//        }}
        //        id = ref
        //get the orderItem
//        db.fetch(withRecordID: re.recordID) { record, error in
//            if record != nil {
//                //                    print("itemOrder")
//                let r:CKRecord = record.unsafelyUnwrapped
//                //                            a.wrappedValue.name = r["brandName"] as? String ?? a.wrappedValue.name
//
//
//                //                    r["quantity"] as? Int64 ?? 0
//                if r["Item"] as? CKRecord.Reference != nil {
//                    let db = CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase
//                    ///item
//                    var i:Item?
//                    print(r.recordType)
//                    let r2 = r["Item"] as! CKRecord.Reference
//                    //item of orderItem
//                    db.fetch(withRecordID: r2.recordID) { record, error in
//                        if record != nil {
//                            print("item")
//                            let r:CKRecord = record.unsafelyUnwrapped
//                            i = Item.init(title: r["title"] as? String ?? "CAN NOT GET", description: r["description"] as? String ?? "CAN NOT GET", price: Int(r["cost"] as? Int64 ?? 0), images: nil, id: r, reference: nil)
//                            //                            i = .init(record: r)
//
//                            db.fetch(withRecordID: ords.recordID) { record, error in
//                                if record != nil {
//                                    //                                    print("blank")
//                                    let r:CKRecord = record.unsafelyUnwrapped
//                                    ///blank
//                                    let b:blank = blank.init(record: r)
//                                    ///blankSize
//                                    var s:blankSize?
//                                    db.fetch(withRecordID: ords.recordID) { record, error in
//                                        if record != nil {
//                                            //                                            print("size")
//                                            let r:CKRecord = record.unsafelyUnwrapped
//                                            s = .init(record: r)
//                                            if i != nil && s != nil {
//                                                print("all good")
//                                                itemsOrdered.append(io.init(i!, r["quantity"] as? Int64 ?? 0, b, id: nil, s!))
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//
//            }
//        }
//        record = r
        //        print(r)
    }
    mutating func upload() {
        
    }
    mutating func download() {
        let db = CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase
        ///itemordered
        var ord:[io]? = nil
        ///fulfiled by
        var fulf:String? = nil
        ///pickup identifier
        var puid:String? = nil
        
        db.fetch(withRecordID: self.id) { r, e in
            if e == nil {
                ord = []
                fulf = (r!.value(forKey: "orderFulfilledBy") as? String)
                puid = (r!.value(forKey: "pickupIdentifier") as? String)
                var kys = (r!.value(forKey: "itemsOrdered") as? [CKRecord.Reference]) ?? []
                for oil in kys {
                    ord?.append(.init(oil.recordID))
                }
            }
        }
        self.itemsOrdered = ord
        self.orderFulfilledBy = fulf
        self.pickupIdentifier = puid
    }
    static func == (lhs: order, rhs: order) -> Bool {
        lhs.id == rhs.id
    }
}
struct StudentItem: Identifiable {
    var id = UUID()
    var studentID: String
    var item: String
    var size: String
}
