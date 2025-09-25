//
//  InventoryView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//

import SwiftUI

extension Color {
    
    
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
                                    .background(i % 2 == 0 ? gbl.darkBrown : Color.orange)
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
                                    .background(i % 2 == 0 ? gbl.darkBrown : Color.orange)
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
                                    .background(i % 2 == 0 ? gbl.darkBrown : Color.orange)
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
