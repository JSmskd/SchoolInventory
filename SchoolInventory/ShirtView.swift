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
                    .border(.orange, width: 5)
                    .offset(x: -5, y: -240)
                Image("Bella3001CVC")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .border(.orange, width: 5)
                    .offset(x: 5, y: -240)
            }
            HStack {
                Text("Orange Shirt")
                    .offset(x: -45, y: -235)
                Text("White Shirt")
                    .offset(x: 45, y: -235)
            }
        }
    }
}

#Preview {
    ShirtView()
}
