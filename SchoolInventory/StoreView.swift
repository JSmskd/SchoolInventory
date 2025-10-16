//
//  StoreView.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/16/25.
//
import CloudKit
import SwiftUI

struct StoreView: View {
//    @State var
    var body: some View {
        VStack {
            Text("Store")
            StoreRow(name: "hi")
        }
    }
}

struct StoreRow:View {
    var name:String
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
            //                .font(.custom("Lexend-Regular", size: 25))
            //                .foregroundColor(.white)
                .padding(.horizontal)
            //                        .offset(x: 8, y: 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5, id: \.self) { i in
                        VStack {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 140, height: 140)
                                .cornerRadius(8)
                            VStack {
                                Text("Item \(i.description).name")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .padding(.top, 5)
                                
                                Text("$#.##")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }//.frame(height:20)
                        }
//                        .frame(width: 140, height: 160)
                    }
                }
                //                        itemPreview(/*model, */item: item)
                //                                        item.preview
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    
//    Text("hi")
//    StoreRow(name: "Alphabeta")
    StoreView()
}
