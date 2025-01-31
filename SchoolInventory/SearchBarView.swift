//
//  SearchBarView.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 1/14/25.
//

import SwiftUI

struct SearchBarView: View {
    @State private var listOfCountry = countryList // Your original country list
    @State private var searchText = ""
    @State private var newCountry = ""  // For storing the new country being added
    @State private var showAddCountrySheet = false  // For toggling the sheet
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(countries, id: \.self) { country in
                        HStack {
                            Text(country.capitalized)
                            Spacer()
                            Image(systemName: "figure.walk")
                                .foregroundColor(Color.blue)
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteItems) // Swipe-to-delete
                }
                .searchable(text: $searchText)
                .navigationTitle("Search Bar")
                
                Button(action: {
                    showAddCountrySheet = true
                }) {
                    Text("Add Country")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showAddCountrySheet) {
                    VStack {
                        Text("Enter Country Name")
                            .font(.title2)
                            .padding()
                        
                        TextField("Country name", text: $newCountry)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            addCountry(newCountry)
                            showAddCountrySheet = false // Dismiss the sheet
                        }) {
                            Text("Add")
                                .font(.title2)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        Button(action: {
                            showAddCountrySheet = false // Dismiss the sheet without adding
                        }) {
                            Text("Cancel")
                                .font(.title2)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
    }
    
    var countries: [String] {
        let lcCountries = listOfCountry.map { $0.lowercased() }
        return searchText.isEmpty ? lcCountries : lcCountries.filter {
            $0.contains(searchText.lowercased())
        }
    }
    
    // Function to delete an item from the list
    func deleteItems(at offsets: IndexSet) {
        listOfCountry.remove(atOffsets: offsets)
    }
    
    // Function to add a new country
    func addCountry(_ country: String) {
        // Check if country is not empty and doesn't already exist in the list
        if !country.isEmpty && !listOfCountry.contains(where: { $0.lowercased() == country.lowercased() }) {
            listOfCountry.append(country)
        }
        newCountry = "" // Clear the input field
    }
}

#Preview {
    SearchBarView()
}
