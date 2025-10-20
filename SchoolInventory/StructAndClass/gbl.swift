//
//  gbl.swift
//  SchoolInventory
//
//  Created by John Sencion on 9/25/25.
//

import SwiftUI
import CloudKit

struct gbl {
    
    static let dumb:CKRecord = CKRecord(recordType: "dumb")
    
    static let db = CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase
    
    static let darkOrange = Color(red: 244/255, green: 108/255, blue: 44/255)
    static let darkBrown = Color(red: 92/255, green: 64/255, blue: 51/255)
    
    static func toPrice(_ doub:Int) -> String {
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
}
