//
//  snake.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/14/25.
//
import CloudKit
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
