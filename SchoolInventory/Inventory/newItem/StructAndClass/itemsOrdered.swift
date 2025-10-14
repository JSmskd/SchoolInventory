//
//  itemsOrdered.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/14/25.
//
import CloudKit
///itemsOrdered
struct io: Hashable, Identifiable {
        var id:CKRecord.ID
        var item:Item//price
        var quantity:Int64
        var style:blank//
        var blnk:blankSize//price
    var indvPrice:Int {get{item.price + Int(style.price ?? -99) + Int(blnk.price ?? -99)}}
    var price:Int {get{indvPrice*Int(quantity)}}
    init (_ ref:Item,_ qty:Int64, _ sty:blank, id:CKRecord.ID? = nil, _ selected:blankSize) {
        //            itm = Item(reference: ref)
        self.id = id ?? .init(recordName: "434A2534-3591-4163-8E84-327582A1DE11")
        quantity = qty
        style = sty
        item = ref
        blnk = selected
    }
    init (_ ref: CKRecord.ID) {
        var tid:CKRecord.ID = ref
        var titm:CKRecord.ID?
        var tqnt:Int64?
        var tblnID: CKRecord.ID?
        
        CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase.fetch(withRecordID: ref) { r, e in
            if e == nil {
                //r is the record of the ordered item
                var recer = r!
                titm = (recer.value(forKey: "Item") as? CKRecord.Reference)?.recordID
tqnt = recer.value(forKey: "quantity") as? Int64
tblnID = (recer.value(forKey: "blankSize") as? CKRecord.Reference)?.recordID
//                tblnID (final)blank id
                
            }
        }
        id = tid
        item = Item(titm ?? CKRecord.ID.init(recordName: "F527E4A8-2B46-4930-8535-D51E6CCDC31B"))
        quantity = tqnt ?? -1
        blnk = blankSize(tblnID ?? CKRecord.ID.init(recordName: "478BD526-5E40-4ACD-89AC-EAB617929B61"))
        var nexID = (blnk.record.value(forKey: "blank") as? CKRecord.Reference)
        style = blank(nexID == nil ? CKRecord.ID.init(recordName: "FA9FAB4D-F49F-4B26-B365-7F3210C8D9EE") : nexID!.recordID )
    }//FA9FAB4D-F49F-4B26-B365-7F3210C8D9EE
    static func == (lhs: io, rhs: io) -> Bool {
        lhs.id == rhs.id
    }
}
