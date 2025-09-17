//
//  BlanksView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 3/17/25.
//

import CloudKit

import SwiftUI

struct BlanksView: View {
    @State private var showEditSheet = false
    @State private var selectedShirt: String = ""
    @State private var editedName: String = ""
    @State private var editedSmall: Int = 0
    @State private var editedMedium: Int = 0
    @State private var editedLarge: Int = 0
    @State private var editedColor: String = "White"
    
    //    @State private var gildanName = "Gildan5000"
    //    @State private var bellaName = "Bella3001CVC"
    //
    //    @State private var gildanSmallQuantity = 0
    //    @State private var gildanMediumQuantity = 0
    //    @State private var gildanLargeQuantity = 0
    //    @State private var bellaSmallQuantity = 0
    //    @State private var bellaMediumQuantity = 0
    //    @State private var bellaLargeQuantity = 0
    //
    //    @State private var gildanColor = "White"
    //    @State private var bellaColor = "White"
    
    @State private var stockAlertMessage = ""
    @State private var showStockAlert = false
    
    //    let availableColors = ["White","Orange", "Black", "Red", "Blue", "Green", "Yellow", "Pink", "Grey"]
    private let recordType:String
    let FILTERTEXT: String
    var predicate : NSPredicate
    init(blank: String = "") {
        if blank == ""{
            predicate = .init(value: true)
        } else {
            predicate = .init(format: "tags CONTAINS %@", blank)
        }
        FILTERTEXT = blank
        recordType = "blank"
    }
    init(design: String = "") {
        if design == ""{
            predicate = .init(value: true)
        } else {
            predicate = .init(format: "tags CONTAINS %@", design)
        }
        FILTERTEXT = design
        recordType = "Item"
    }
    //    init (filter:String, filterText: String = "") {
    //        predicate = .init(format: filter)
    //        if filterText == ""{
    //            FILTERTEXT = ""
    //        } else {
    //            FILTERTEXT = filterText
    //        }
    //
    //    }
    //    init (filter:String, filterText: String = "") {
    //        predicate = .init(format: filter)
    //        if filterText == ""{
    //            FILTERTEXT = ""
    //        } else {
    //            FILTERTEXT = filterText
    //        }
    //
    //    }
    @State var listems: [blDe] = []
    func fetchData () {
        let p = NSPredicate(value: true)
        let db = CloudKit.CKContainer(identifier: "iCloud.org.jhhs.627366.DawgPoundStore").publicCloudDatabase
        db.fetch(withQuery: .init(recordType: recordType, predicate: p)) { m in
            listems = []
            var mm : (matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)], queryCursor: CKQueryOperation.Cursor?)?
            do {
                //                m.get
                mm = try m.get()
                
            } catch {
                print(error)
            }
            if mm != nil {
                for res in mm!.matchResults {
                    //                    itms
                    //                        do {
                    let b = try? res.1.get()
                    if b != nil {
                        let a = blDe(b!)
                        //
                        //                            Item()
                        //                            DispatchQueue.main.async {
                        //                            print(b)
                        if a != nil {
                            listems.append(a!)
                        }
                        //                            items
                    }
                    //                        } catch {
                    //                            print(error)
                    //                        }
                    
                }
            }
            
        }
        //        db.fetch(withQuery: .init(recordType: "Item", predicate: predicate))
        //        print(itms)
        //        return itms
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ScrollView {
                        

                        LazyVGrid(columns: [GridItem.init(),GridItem.init(),GridItem.init()]) {
                            //                            <#code#>
                            //                        }
                            //                        LazyHStack {
                            //                        <#code#>
                            //                    }
                            //                    LazyHGrid(rows: [], content: <#T##() -> View#>)
                            //                    HStack(spacing: 16) {
                            ForEach(0..<listems.count, id:\.self) { i in
                                // Gildan View
                                VStack(spacing: 10) {
                                    let itm:blDe = listems[i]
                                    
                                    //Gildan5000
                                    //                            do {
                                    //                            Text("")
                                    //                            } catch {
                                    //                            Text("")
                                    //                            }
                                    //                            let img = items[i].images
                                    //                            if img.first != nil ? img.first!.fileURL != nil ? true : false : false {
                                    //                                Image(items[i].images.first != nil ? items[i].images.first!.fileURL ?? "Gildan5000" : "Gildan5000")
                                    //                                    .resizable()
                                    //                                    .scaledToFit()
                                    //                                    .frame(height: 100)
                                    //                            } else {
                                    //                                Image(items[i].images.first != nil ? items[i].images.first!.fileURL ?? "Gildan5000" : "Gildan5000")
                                    //                                    .resizable()
                                    //                                    .scaledToFit()
                                    //                                    .frame(height: 100)
                                    //                            }
                                    //                                Image(i)
                                    //                                    .resizable()
                                    //                                    .scaledToFit()
                                    //                                    .frame(height: 100)

                                    Button {
                                        UIPasteboard.general.string = "JSI" + itm.name
                                    } label : {
                                        Text(itm.name)
                                            .font(.headline)
                                    }
                                    //                            Text("Color: \(gildanColor)")
                                    //                                .font(.subheadline)
                                    //                                .foregroundColor(.gray)
                                    
                                    //                            Text("Small: \(gildanSmallQuantity)")
                                    //                            Text("Medium: \(gildanMediumQuantity)")
                                    //                            Text("Large: \(gildanLargeQuantity)")
                                    ForEach(itm.self.to/*do not rememove the slef*/ , id:\.self) { sty in
                                        
                                        Text(sty.self.self.recordName).padding() .background(Color.gray).cornerRadius(8)
                                    }
                                    Button("Edit") {
                                        //                                editShirt(name: gildanName, small: gildanSmallQuantity, medium: gildanMediumQuantity, large: gildanLargeQuantity, color: gildanColor)
                                    }
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                                .padding()
                                .background(Color(.systemGroupedBackground))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                    HStack {
                        Button(action: checkStock) {
                            Text("Check Stock")
                                .font(.title2)
                                .padding()
                                .background(Color.darkBrown)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink {
                            newItemView(FILTERTEXT, recordType)
                        } label: {
                            Text("Add blank")
                                .font(.title2)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .navigationTitle("Blanks")
            }
            .sheet(isPresented: $showEditSheet) {
                VStack {
                    Text("Edit \(selectedShirt)")
                        .font(.title2)
                        .padding()
                    
                    TextField("Enter new name", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Picker("Color", selection: $editedColor) {
                        //                        ForEach(availableColors, id: \.self) { color in
                        //                            Text(color).tag(color)
                        //                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Stepper("Small: \(editedSmall)", value: $editedSmall, in: 0...100)
                        .padding()
                    Stepper("Medium: \(editedMedium)", value: $editedMedium, in: 0...100)
                        .padding()
                    Stepper("Large: \(editedLarge)", value: $editedLarge, in: 0...100)
                        .padding()
                    
                    Button("Save") {
                        saveChanges()
                        showEditSheet = false
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.darkOrange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Cancel") {
                        showEditSheet = false
                    }
                    .padding()
                    .background(Color.darkBrown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
            .alert(isPresented: $showStockAlert) {
                Alert(
                    title: Text("Stock Status"),
                    message: Text(stockAlertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            //            loadStockData()
            //            DispatchQueue.main.async {
            fetchData()
            //            }
        }
    }
    
    func editShirt(name: String, small: Int, medium: Int, large: Int, color: String) {
        selectedShirt = name
        editedName = name
        editedSmall = small
        editedMedium = medium
        editedLarge = large
        editedColor = color
        showEditSheet = true
    }
    
    func saveChanges() {
        //        if selectedShirt == gildanName {
        //            gildanName = editedName
        //            gildanSmallQuantity = editedSmall
        //            gildanMediumQuantity = editedMedium
        //            gildanLargeQuantity = editedLarge
        //            gildanColor = editedColor
        //        } else if selectedShirt == bellaName {
        //            bellaName = editedName
        //            bellaSmallQuantity = editedSmall
        //            bellaMediumQuantity = editedMedium
        //            bellaLargeQuantity = editedLarge
        //            bellaColor = editedColor
        //        }
        saveStockData()
    }
    
    func checkStock() {
        //        if gildanSmallQuantity < 3 || gildanMediumQuantity < 3 || gildanLargeQuantity < 3 ||
        //            bellaSmallQuantity < 3 || bellaMediumQuantity < 3 || bellaLargeQuantity < 3 {
        //            stockAlertMessage = "Low stock! Some sizes have less than 3 items."
        //        } else {
        //            stockAlertMessage = "Enough stock! All sizes have more than 3 items."
        //        }
        showStockAlert = true
    }
    
    func saveStockData() {
        //        UserDefaults.standard.set(gildanSmallQuantity, forKey: "gildanSmallQuantity")
        //        UserDefaults.standard.set(gildanMediumQuantity, forKey: "gildanMediumQuantity")
        //        UserDefaults.standard.set(gildanLargeQuantity, forKey: "gildanLargeQuantity")
        //        UserDefaults.standard.set(gildanColor, forKey: "gildanColor")
        //
        //        UserDefaults.standard.set(bellaSmallQuantity, forKey: "bellaSmallQuantity")
        //        UserDefaults.standard.set(bellaMediumQuantity, forKey: "bellaMediumQuantity")
        //        UserDefaults.standard.set(bellaLargeQuantity, forKey: "bellaLargeQuantity")
        //        UserDefaults.standard.set(bellaColor, forKey: "bellaColor")
    }
    
    func loadStockData() {
        //        gildanSmallQuantity = UserDefaults.standard.integer(forKey: "gildanSmallQuantity")
        //        gildanMediumQuantity = UserDefaults.standard.integer(forKey: "gildanMediumQuantity")
        //        gildanLargeQuantity = UserDefaults.standard.integer(forKey: "gildanLargeQuantity")
        //        gildanColor = UserDefaults.standard.string(forKey: "gildanColor") ?? "White"
        //
        //        bellaSmallQuantity = UserDefaults.standard.integer(forKey: "bellaSmallQuantity")
        //        bellaMediumQuantity = UserDefaults.standard.integer(forKey: "bellaMediumQuantity")
        //        bellaLargeQuantity = UserDefaults.standard.integer(forKey: "bellaLargeQuantity")
        //        bellaColor = UserDefaults.standard.string(forKey: "bellaColor") ?? "White"
    }
}
struct blDe : Identifiable, CustomStringConvertible, Hashable {
    var description: String { get { "\(name) \(price)"}}
    var id: String {get {name}}
    var name:String = ""
    var price : Int64
    
    var type:String
    
    var record:CKRecord
    
    var to:[CKRecord.ID]
    init? (_ res: CKRecord?) {
        if res == nil {return nil}
        var trecord:CKRecord? = nil
        do {
            let a = res
            print(res)
            trecord = a
        } catch {
return nil
        }
        if trecord == nil {return nil}
            var a = trecord!
            self.record = a
            type = a.recordType
        name = a.recordType == "Item" ? a["title"] as? String ?? "ERR" : a.recordID.recordName
            price = a[a.recordType == "Item" ? "price" : "cost"] as? Int64 ?? -1
        let refs = a[a.recordType == "Item" ? "blanks" : "sizes"] as? [CKRecord.Reference] ?? []
        var out:[CKRecord.ID] = []
        for i in refs {
            out.append(i.recordID)
        }
        to = out

        
    }
    
}
