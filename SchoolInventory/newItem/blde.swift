//
//  blde.swift
//  SchoolInventory
//
//  Created by John Sencion on 9/26/25.
//
import CloudKit


struct blDe : Identifiable, CustomStringConvertible, Hashable {
    var description: String { get { "\(name) \(price)"}}
    var id: String {get {name}}
    var name:String = ""
    var price : Int64
    var n:String?
    
    var type:String
    var cats:[String]
    var record:CKRecord
    
    var to:[CKRecord.ID]
    init? (_ res: CKRecord?) {
        if res == nil {return nil}
            let a = res!
            self.record = a
//        if a.recordID.recordName == "65D2492E-1C25-4668-A294-A6975C2DDF7E" {print(a)}
            type = a.recordType
        name = a.recordID.recordName
//        name = a["title"] ?? (a["longName"] ?? (a["color"] ?? a.recordID.recordName))
        n = a["shortName"]
//        name = a.recordType == "Item" ? a["title"] as? String ?? a.recordID.recordName : a.recordType == "blank" ? a["longName"]  : a["color"] a.recordID.recordName
        cats = (a.recordType == "Item" ? a["tags"] : a["materials"]) as? [String] ?? []
            price = a[a.recordType == "Item" ? "price" : "cost"] as? Int64 ?? -1
        let refs = a[a.recordType == "Item" ? "blanks" : "sizes"] as? [CKRecord.Reference] ?? []
        var out:[CKRecord.ID] = []
        for i in refs {
            out.append(i.recordID)
        }
        to = out
        
    }
    
}
