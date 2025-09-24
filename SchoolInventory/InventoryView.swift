//
//  InventoryView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

extension Color {
    static let darkBrown = Color(red: 92/255, green: 64/255, blue: 51/255)
    
}


struct InventoryView: View {
    let catagories: [String] = ["Shirts", "Sweatpants", "Hoodies", "Crewnecks"]
    var body: some View {
        
        NavigationStack {
            ScrollView{
                ForEach(0..<catagories.count + 2, id: \.self) { i in
                    if i == 0 {
                        VStack(spacing: 20) {
                            NavigationLink {
                                BlanksView(blank: "")
                            } label: {
                                Text("Blanks")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(i % 2 == 0 ? Color.darkBrown : Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                        }
                    }else if i == 1 {
                        VStack(spacing: 20) {
                            NavigationLink {
                                BlanksView(design: "")
                            } label: {
                                Text("Items")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(i % 2 == 0 ? Color.darkBrown : Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                        }
                    } else {
                        VStack(spacing: 20) {
                            NavigationLink {
                                BlanksView(design: catagories[i - 2])
                            } label: {
                                Text(catagories[i - 2])
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(i % 2 == 0 ? Color.darkBrown : Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    InventoryView()
//}


//struct newItem:Identifiable, Hashable, CustomDebugStringConvertible, CustomStringConvertible{
//    var id: CKRecord.ID
//    var debugDescription: String { get {id.recordName}}
//    var description: String {debugDescription}
//    var styles:[newStyle]
//    func createRecord() /*-> CKRecord*/{
//        for i in styles {
//            CKRecord.Reference.init(recordID: i.id, action: .none)
//            
//        }
//    }
//}
//
//struct newStyle:Identifiable, Hashable, CustomDebugStringConvertible, CustomStringConvertible{
//    var id: CKRecord.ID = .init()
//    var debugDescription: String { get {id.recordName}}
//    var description: String {debugDescription}
//    var sizes:[newSize]
//    func createRecord(_ parent: CKRecord.ID) -> CKRecord{
//        CKRecord(recordType: "<#stylename#>")
//        CKRecord.Reference.init(recordID: parent, action: .none)
//    }
//}
//struct newSize:Identifiable, Hashable, CustomDebugStringConvertible, CustomStringConvertible{
//    var id: CKRecord.ID
//    var debugDescription: String { get {id.recordName}}
//    var description: String {debugDescription}
//    func createRecord(_ parent: CKRecord.ID) -> CKRecord {
//        CKRecord(recordType: "<#sizename#>")
//        CKRecord.Reference.init(recordID: parent, action: .none)
//    }
//}
