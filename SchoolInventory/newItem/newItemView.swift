//
//  newItemView.swift
//  SchoolInventory
//
//  Created by John Sencion on 9/15/25.
//

import SwiftUI

struct newItemView: View {
    @Environment(\.dismiss) private var dismiss
    let catagory:String?
    @State var iter:Int = 0
    @State var name:String = ""
    @State var things:[(addPrice:Int,name:String,n:String, s:[(addPrice:Int,name:String,n:String)])] = []
    @State var whole : Int = 9
    @State var fraction : Int = 99
    init (_ c:String) {
        catagory = c == "" ? nil : c
    }
    var body: some View {
        Text("Hello, World!")
        TextField("Enter Item Name", text: $name)
        
        HStack {
            Text(" Defualt Price : $")
            TextField("Enter the whole dollar amount", value: $whole, format: .number).frame(maxWidth: 24 * 2)
                .background(Color.yellow).grayscale(1).cornerRadius(3)
            Text(".")
            TextField("enter the decimal amount", value: $fraction, format: .number).frame(maxWidth: 24 * 2)
                .background(Color.yellow).grayscale(1).cornerRadius(3)
        }.textFieldStyle(.plain)
            .border(.gray, width: 1)
        
        
        Text("Item preview")
        VStack {
            Text("Price : $\(whole).\(fraction)  ")
        }
        HStack {
            Button {
                things.append((addPrice:0,name:"ITEM\(iter)",n:"\(iter)", s:[]))
                iter += 1
            } label: {
                Text("Add size")
            }
            Button {
                
            } label: {
                Text("Add color")
            }
        }
        List {
            ForEach($things, id: \.name) { i in
                HStack {
                    Button {
                        i.wrappedValue.s.append((addPrice:0,name:"hi",n:"h"))
                    } label: {
                        Text("Add Size")
                    }
                    
                    Text("$")
                    TextField("addPrice", value: Binding(get: {
                        i.wrappedValue.addPrice / 10000
                    }, set: { v in
                        let p = i.wrappedValue.addPrice
                        var o : Int = 0
                        o -= p
                        o /= 10000
                        o *= 10000
                        o += p
                        
                        o += v * 10000
                        
                        i.wrappedValue.addPrice = o
                    }), format: .number)
                    .frame(maxWidth: 24 * 2)
                        .background(Color.yellow).grayscale(1).cornerRadius(3)
                    Text(".")
                    TextField("addPrice", value: Binding(get: {
                        (i.wrappedValue.addPrice - (i.wrappedValue.addPrice / 10000 * 10000))
                    }, set: { v in
                        let p = i.wrappedValue.addPrice
                        i.wrappedValue.addPrice = p / 10000 * 10000 + v
                        
                    }), format: .number)
                    .frame(maxWidth: 24 * 2)
                        .background(Color.yellow).grayscale(1).cornerRadius(3)
                    Text("cost: \(i.wrappedValue.addPrice / 10000)")
                    Text("cost: \(i.wrappedValue.addPrice - (i.wrappedValue.addPrice / 10000 * 10000))")
                    Text("cost: \(i.wrappedValue.addPrice)")
                }
                
                ForEach(i.s as! Binding<[(addPrice:Int,name:String,n:String)]>, id:\.wrappedValue.name) { n in
                        HStack {
//                            Button {
                                Text("•\t" + n.name.wrappedValue)
//                                n.wrappedValue.s.append((addPrice:0,name:"hi",n:"h"))
//                            } label: {
//                                Text("Add Size")
//                            }
                            
                            Text("$")
                            TextField("addPrice", value: Binding(get: {

                                n.wrappedValue.addPrice / 10000
                            }, set: { v in
                                let p = n.wrappedValue.addPrice
                                var o : Int = 0
                                o -= p; o /= 10000; o *= 10000; o += p; o += v * 10000
                                
                                n.wrappedValue.addPrice = o
                            }), format: .number)
                            .frame(maxWidth: 24 * 2)
                                .background(Color.yellow).grayscale(1).cornerRadius(3)
                            Text(".")
                            TextField("addPrice", value: Binding(get: {
                                (n.wrappedValue.addPrice - (n.wrappedValue.addPrice / 10000 * 10000))
                            }, set: { v in
                                let p = n.wrappedValue.addPrice
                                n.wrappedValue.addPrice = p / 10000 * 10000 + v
                                
                            }), format: .number)
                            .frame(maxWidth: 24 * 2)
                                .background(Color.yellow).grayscale(1).cornerRadius(3)
                            Text("cost: \(n.wrappedValue.addPrice / 10000)")
                            Text("cost: \(n.wrappedValue.addPrice - (n.wrappedValue.addPrice / 10000 * 10000))")
                            Text("cost: \(n.wrappedValue.addPrice)")
                        }

                    }
            }
        }
        Button("Cancel") {
            dismiss()
        }
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    newItemView("hi")
}
