//
//  ShirtView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/6/25.
//

import SwiftUI

struct ShirtView: View {
    var body: some View {
        VStack {
            HStack {
                
                Image("Gildan5000")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .border(.brown, width: 2)
                Image("Bella3001CVC")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .border(.brown, width: 2)
            }
            HStack {
                Text("Orange Shirt")
                Text("White Shirt")
            }
        }
    }
}

#Preview {
    ShirtView()
}
