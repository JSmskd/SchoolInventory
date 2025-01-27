//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI

struct SearchBarView: View {
    private var listOfCountry = countryList
    @State var searchText = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(countries, id: \.self) { counry in
                    HStack{
                        Text(counry.capitalized)
                        Spacer()
                        Image(systemName: "figure.walk")
                            .foregroundColor(Color.blue)
                    }
                    .padding()
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Search Bar")
        }
      
    }
    var countries: [String] {
        let lcCountries = listOfCountry.map { $0.lowercased() }
        return searchText == "" ? lcCountries : lcCountries.filter {
            $0.contains(searchText.lowercased())
        }
    }
}

#Preview {
    ContentView()
}

