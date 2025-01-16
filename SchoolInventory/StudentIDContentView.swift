//
//  StudentIDContentView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 1/14/25.
//

import SwiftUI

struct StudentIDContentView: View {
    @StateObject var studentViewModel: StudentIDViewModel = StudentIDViewModel()
    var body: some View {
        List{
            ForEach(studentViewModel.students, id: \.student_name) {station in
                Text(station.student_name)
        }
        }
        
    }
}

#Preview {
    StudentIDContentView()
}
