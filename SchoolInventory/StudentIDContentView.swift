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
            ForEach(studentViewModel.students, id: \.lastName) {student in
                Text(student.lastName)
        }
        }
        
    }
}

#Preview {
    StudentIDContentView()
}
