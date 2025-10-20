//
//  blank.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/14/25.
//

import CloudKit
import SwiftUI

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
                return Color.orange
            case "white":
                return Color.white
            case "ERR":
                return Color.orange
            default:
                return Color.clear
        }
    }
    var sizes:[CKRecord.ID]? {
        get {
            let temp = record["sizes"] as? [CKRecord.Reference]
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
    static func newReccord(brandName:String = "", color:String = "", cost:Int64 = -1, materials:[String] = []) -> blank {
        let r:CKRecord = CKRecord(recordType: "blank")
        if cost >= 0 {
            r["cost"] = cost
        }
        if !color.isEmpty {
            r["color"] = color
        }
        if !brandName.isEmpty {
            r["brandName"] = brandName
        }
        if !materials.isEmpty {
            
        }
        
        return blank(record: r)
        
        
    }
    init(record r:CKRecord) {
        record = r
    }
}
