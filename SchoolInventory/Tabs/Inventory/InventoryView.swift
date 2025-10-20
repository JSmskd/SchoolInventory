//
//  InventoryView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI


struct InventoryView: View {
    let catagories: [String] = ["Shirts", "Sweatpants", "Hoodies", "Crewnecks"]
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
                            BlanksView(design: catagories[i])
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
