//
//  ManuallyEnterView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 12/11/24.
//
import SwiftUI

struct ManuallyEnterView: View {
    @State var manuallyEnter: String = ""
    var body: some View {
        Text("Manually Enter")
            .font(.custom("Impact", size: 70))
            .foregroundColor(.darkOrange)
    }
}

#Preview {
    ManuallyEnterView()
}
