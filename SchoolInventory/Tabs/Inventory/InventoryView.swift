//
//  InventoryView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI


struct InventoryView: View {
    let catagories: [[gbl.type]] = [[.shirt,.top], [.sweatpant,.bottom], [.hoodie,.top], [.crewnecks,.top]]
    var body: some View {
        
        NavigationStack {
            ScrollView{
                VStack(spacing: 20) {
                    HStack {
                        quearyBloc("Items", 1) {
                            BlanksView(design: "")
                                .navigationTitle("Items")
                        }
                        quearyBloc("Blanks", 1) {
                            BlanksView(blank: "")
                                .navigationTitle("Blanks")
                        }
                    }
                    ForEach(0..<catagories.count, id: \.self) { i in
                        quearyBloc(catagories[i], i) {
                            let o = catagories[i]
                            BlanksView(design: o.JSString())
                                .navigationTitle(o.String().description)
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
    init(_ label:[gbl.type], _ iteration :Int, @ViewBuilder _ destination: @escaping () -> view) {
        var t = label.first!.rawValue
        if label.count > 1 {
            for (n,x) in label.enumerated() {
                if n == 0 {
                    t += " ["
                } else {
                    t += ", "
                }
                t += x.rawValue
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
