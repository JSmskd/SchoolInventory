//
//  HomeView.swift
//  SchoolInventory
//
//  Created by Neha M. Darji on 1/27/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) { 
            Image("DawgPound")
                .resizable()
                .scaledToFit()
                .padding()
            Text("INVENTORY")
                .font(.custom("Impact", size: 700))
                .minimumScaleFactor(0.01)
                .foregroundColor(gbl.darkOrange)
        }
    }
}

