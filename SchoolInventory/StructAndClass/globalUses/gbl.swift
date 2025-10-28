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
    
    static func fetch(ids:[id]) -> dict {
        var res:dict = Result.failure(JSError.uhoh)
        db.fetch(withRecordIDs: ids) { r in res = r }
        do {
            var ret:diction=[:]
            for(id,r)in(try(res.get())){ret[id]=r}
            return.success(ret)
        }catch(let Err){return.failure(Err)
        }
    }
    static func fetch(id:id)->record{
        do{return.success(try(try(fetch(ids:[id]).get()).first!.1).get())
        } catch let Err { return .failure(Err) }
    }
    static func fetch(predicate:NSPredicate, recordType rt:CKRecord.RecordType) -> Result<[record], error> {
        return fetch(queary: .init(recordType: rt, predicate: predicate))
    }
    static func fetch(predicates:[NSPredicate], recordType rt:CKRecord.RecordType) -> multirecord {
        return fetch(predicate: NSCompoundPredicate(andPredicateWithSubpredicates: predicates), recordType: rt)
    }
    static func fetch(queary:CKQuery) -> Result<[record], error> {
        var res:Result<(matchResults: [(id, record)], queryCursor: CKQueryOperation.Cursor?), error> = .failure(JSError.uhoh)
        db.fetch(withQuery: queary) { m in res=m}
        do { var out:[record] = []
            for i in (try res.get()).matchResults { out.append(i.1) }
            return .success(out)
        } catch let Err { return .failure(Err) }
    }
}

