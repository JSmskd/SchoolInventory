//
//  StoreView.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/16/25.
//
import CloudKit
import SwiftUI

struct StoreView: View {
    ///0:unloaded,1:loading,2:loaded
    @State var status:UInt8 = 0
    @State var MAIN:storelev?
    @State var parts:[storelev] = []
    var body: some View {
        VStack {
            HStack(spacing:0){
                Text("Load\(MAIN == nil ? "ing" : "ed") ")
                Image(systemName: "circle").foregroundStyle(MAIN == nil ? Color.red : Color.green)
                
            }
            Text("Store")
            ForEach(parts) { part in
                StoreRow(name: part.Name)
            }
        }
        .onAppear{refresh()}.refreshable{refresh()}
    }
    
    func refresh(){
        if status != 1 {
            Task {
                do {
                    status = 1
                    let p = storelev(RECORD: try (await gbl.fetch(id: .init(recordName: "MAIN"))).get())
                    MAIN = p
                    parts = await getParts(p)
                    status = 2
                } catch {
                    status = 0
                }
            }
        }
    }
    func getParts(_ p:storelev) async -> [storelev] {
        var records:[CKRecord] = []
        if !p.items.isEmpty {
            for i in p.items {
                if let a = try? await gbl.fetch(id: i.recordID).get() {
                    records.append(a)
                }
            }
        }
        if !p.query.isEmpty {
            if let a = try? await gbl.fetch(queary: CKQuery(recordType: "ItemCollection", predicate: NSPredicate(format: p.query))).get() {
                for i in a {
                    if let b = try? i.get() {
                        records.append(b)
                    }
                }
            }
        }
        var levs:[storelev] = []
        for i in records {
            do {
                levs.append(try storelev(i))
            } catch {
                print("uh oh: \(error)")
            }
        }
        return levs
    }
}

#Preview {
    StoreView()
}
struct storelev:Identifiable {
    private var RECORD : CKRecord
    
    var id : CKRecord.ID { get {RECORD.recordID}}
    var Name:String { get {RECORD.object(forKey: "Name") as! String} set {RECORD.setValue(newValue, forKey: "Name")}}
    var query:String { get {RECORD.object(forKey: "query") as? String ?? ""} set {RECORD.setValue(newValue, forKey: "query")}}
    var items:[CKRecord.Reference] { get {RECORD.object(forKey: "items") as! [CKRecord.Reference]} set {RECORD.setValue(newValue, forKey: "items")}}
    
    init (RECORD rec:CKRecord) {RECORD = rec }
    init (_ rec:CKRecord) throws {RECORD = rec}
    
    func save(){Task{do{let _=try await gbl.save(record: RECORD)}catch{}}
    }
}
