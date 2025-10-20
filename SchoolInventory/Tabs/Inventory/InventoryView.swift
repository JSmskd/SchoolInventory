//
//  InventoryView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI


struct InventoryView: View {
    let catagories: [[String]] = [["shirt",gbl.type.top.rawValue], ["sweatpant",gbl.type.bottom.rawValue], ["hoodie",gbl.type.top.rawValue], ["crewnecks",gbl.type.top.rawValue]]
    var body: some View {
        
        NavigationStack {
            ScrollView{
                VStack(spacing: 20) {
                    HStack {
                        quearyBloc("Items", 1) {
                            BlanksView(design: "")
                        }
                        quearyBloc("Blanks", 1) {
                            BlanksView(blank: "")
                        }
                    }
                    ForEach(0..<catagories.count, id: \.self) { i in
                        quearyBloc(catagories[i], i) {
                            let o = catagories[i]
                            BlanksView(design: o)
                        }
                    }
                }
            }
        }
    }
}

struct quearyBloc<view: View>: View {
    let f: () -> view
var text:String
    var i:Int
    
    init(_ label:String, _ iteration :Int, @ViewBuilder _ destination: @escaping () -> view) {
        text = label
        i = iteration
            self.f = destination
        }
    init(_ label:[String], _ iteration :Int, @ViewBuilder _ destination: @escaping () -> view) {
        var t = label.first!
        if label.count > 1 {
            for (n,x) in label.enumerated() {
                if n == 0 {
                    t += " ["
                } else {
                    t += ", "
                }
                t += x
                if n == label.count - 1 {
                    t += "]"
                }
            }
        }
        text = t
        i = iteration
            self.f = destination
        }
    var body: some View {
        NavigationLink {
            f()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .padding()
                .background(i % 2 == 0 ? gbl.darkBrown : Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    InventoryView()
}
