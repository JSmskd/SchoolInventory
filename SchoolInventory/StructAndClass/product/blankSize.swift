//
//  blankSize.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/14/25.
//

import CloudKit

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
    var isERR:Bool { get {record.recordType == gbl.dumb.recordType} }
    init(_ ref : CKRecord.ID) {
        var tr:CKRecord = gbl.dumb
        gbl.db.fetch(withRecordID: ref) { r, e in
            if e == nil {
                tr = r!
            }
        }
            record = tr
    }
    mutating func updateSelf (_ ident:CKRecord.ID) {
        var tr:CKRecord = gbl.dumb
        gbl.db.fetch(withRecordID: ident) { r, e in
            if e == nil {
                tr = r!
            }
        }
        if tr.recordType != gbl.dumb.recordType {
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
