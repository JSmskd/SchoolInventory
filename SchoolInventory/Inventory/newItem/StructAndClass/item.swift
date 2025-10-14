//
//  item.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/14/25.
//
import CloudKit

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
        gbl.db.fetch(withRecordID: ref) { r, e in
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
