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
                .frame(width: 300, height: 175)
            Text("INVENTORY")
                .font(.custom("Impact", size: 70))
                .foregroundColor(.darkOrange)
        }
    }
}

extension Color {
    static let darkOrange = Color(red: 244/255, green: 108/255, blue: 44/255)
}

#Preview {
    HomeView()
}
