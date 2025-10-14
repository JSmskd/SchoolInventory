//
//  allofthem.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/14/25.
//

import CloudKit
import SwiftUI

struct allofthem: View {
    @Binding var things:[String]; @Binding var stuff:[snake]
    let recordType:String
    var body: some View {
        if recordType == "Item" { itm } else { blk }
    }
    var itm:some View {
        List($things, id: \.self, editActions: .all) { i in
            HStack {
                TextField("ID", text: i)
                Button("Paste ID") {
                    if UIPasteboard.general.string != nil {
                        if UIPasteboard.general.string!.starts(with: "JSI") {
                            var it = UIPasteboard.general.string!
                            it.removeFirst();it.removeFirst();it.removeFirst()
                            i.wrappedValue = it
                        }
                    }
                }
            }
        }
    }
    var blk:some View {
        List{
            HStack{Text("name :").foregroundStyle(.red)
                Text("n :").foregroundStyle(.yellow)
                Text("quantity :")
                Text("cost * 10000") .foregroundStyle(.blue)
            }
            ForEach(0..<stuff.count, id:\.self) { i in
                HStack {
                    Text(stuff[i].id).foregroundStyle(.gray)
                    
                    TextField("", text: $stuff[i].name).foregroundStyle(.red)
                    TextField("", text: $stuff[i].n).foregroundStyle(.yellow)
                    
                    TextField("", text: Binding(get: {
                        stuff[i].q.description
                    }, set: { v in
                        let b = stuff[i].q
                        stuff[i].q = Int64(v) ?? b
                        //                        if Int(v) != nil {$stuff[i].q = Int(v)!}
                        //                        Int()
                    }) )
                    TextField("", text: Binding(get: {
                        stuff[i].price.description
                    }, set: { v in
                        let b = stuff[i].price
                        stuff[i].price = Int64(v) ?? b
                        //                        if Int(v) != nil {$stuff[i].q = Int(v)!}
                        //                        Int()
                    })).foregroundStyle(.blue)
                }.textFieldStyle(.roundedBorder)
            }.onDelete { inde in
                for(i)in(inde){if(stuff[i].posted){gbl.db.delete(withRecordID:stuff.remove(at: i).generateCKRecord().recordID){id,er in}}}
            }
        }
    }
}
