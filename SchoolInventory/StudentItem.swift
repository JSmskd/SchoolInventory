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
    var itemsOrdered:[io]? = nil
    var orderFulfilledBy:String? = nil
    var pickupIdentifier: String? = nil
    init(_ re:CKRecord) {
        id = re.recordID
        download()
    }
    mutating func upload() {
        
    }
    mutating func download() {
        ///itemordered
        var ord:[io]? = nil
        ///fulfiled by
        var fulf:String? = nil
        ///pickup identifier
        var puid:String? = nil
        
        gbl.db.fetch(withRecordID: self.id) { r, e in
            if e == nil {
                ord = []
                fulf = (r!.value(forKey: "orderFulfilledBy") as? String)
                puid = (r!.value(forKey: "pickupIdentifier") as? String)
                for oil in (r!.value(forKey: "itemsOrdered") as? [CKRecord.Reference]) ?? [] {
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
