//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI

struct SearchBarView: View {
    private var listOfItems = ItemsList
    @State var searchText = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(ItemsList, id: \.self) { item in
                    //supposed to be items not items list
                    HStack{
                        Text(item.capitalized)
                        Spacer()
                        Image(systemName: "figure.walk")
                            .foregroundColor(Color.blue)
                    }
                    .padding()
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Items")
        }
      
    }
    var items: [String] {
        let lcItems = listOfItems.map { $0.lowercased() }
        return searchText == "" ? lcItems : lcItems.filter {
            $0.contains(searchText.lowercased())
        }
    }
}

#Preview {
    SearchBarView()
}
