//
//  StudentItem.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 3/19/25.
//


import SwiftUI
import CloudKit

struct order:Hashable,Identifiable {
    //    var id: CKRecord.Reference = .init(record: "Order", action: .none)
    var record:CKRecord
    let id: UUID = UUID()
    var itemsOrdered:[CKRecord.Reference] {get {
        record["itemsOrdered"] as? [CKRecord.Reference] ?? []
    } set {
        record["itemsOrdered"] = newValue
    }}
    var orderFulfilledBy:String {get {
        record["orderFulfilledBy"] as? String ?? "ERR"
    } set {
        record["orderFulfilledBy"] = newValue
    }}
    var pickupIdentifier: String {get {
        record["pickupIdentifier"] as? String ?? "ERR"
    } set {
        record["pickupIdentifier"] = newValue
    }}
    init(_ r:CKRecord) {
        //        id = ref
        record = r
        //        print(r)
    }
    static func == (lhs: order, rhs: order) -> Bool {
        lhs.record.recordID == rhs.record.recordID
    }
}
struct StudentItem: Identifiable {
    var id = UUID()
    var studentID: String
    var item: String
    var size: String
}
