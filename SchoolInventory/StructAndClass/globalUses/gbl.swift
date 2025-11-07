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
    static let realID = "ISREAL"
    static let DOLLAR = 10000
    
    static func toPrice(_ doub:Int) -> String {
        let cuttoff = DOLLAR
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
    enum type:String, Codable {
        //loose
        case top = "top"
        case bottom = "bottom"
        
        //more
        case shirt = "shirt"
        case sweatpant = "sweatpant"
        case hoodie = "hoodie"
        case crewnecks = "crewnecks"
        
        func JSString() -> JSString {
            return self.rawValue.JSString()
        }
    }
    private enum JSError:Error {
        case uhoh
    }
    typealias error = any Error
    typealias record = Result<CKRecord,error>
    typealias multirecord = Result<[record],error>
    typealias id = CKRecord.ID
    typealias diction = [id:record]
    typealias dict = Result<diction,error>
    
    static func fetch(ids i :[id]) async -> dict {
        do { return .success(try await db.records(for: i)) } catch { return .failure(error) }
    }
    static func fetch(id i:id) async->record{
        do { return .success(try await db.record(for: i)) } catch { return .failure(error) }
    }
    static func fetch(predicate:NSPredicate, recordType rt:CKRecord.RecordType) async -> Result<[record], error> {
        return await fetch(queary: .init(recordType: rt, predicate: predicate))
    }
    static func fetch(predicates:[NSPredicate], recordType rt:CKRecord.RecordType) async -> multirecord {
        return await fetch(predicate: NSCompoundPredicate(andPredicateWithSubpredicates: predicates), recordType: rt)
     }
    static func fetch(queary:CKQuery) async -> Result<[record], error> {
        do { var out :[record] = []
            let res = try await db.records(matching: queary)
            for i in res.matchResults { out.append(i.1) }
            return .success(out)
        } catch let Err { return .failure(Err) }
    }
    static func save(record rec: CKRecord) async throws -> CKRecord {
        try await db.save(rec)
    }
}

extension NSSortDescriptor {
    static func createTime(_ ascending:Bool = false) -> NSSortDescriptor {
        return .init(key: "___createTime", ascending: ascending)
    }
}
