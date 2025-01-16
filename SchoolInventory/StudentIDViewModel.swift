//
//  StudentIDViewModel.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 1/14/25.
//

import SwiftUI

class StudentIDViewModel: ObservableObject {
    @Published var students: [StudentIDModel] = []
    
    
    init() {
        getData()
    
    }
    
    func getData() {
        let url = URL(string: " ")
        let session = URLSession.shared.dataTask(with: url!) { data, response, error in
            var tempArray: [StudentIDModel] = []
            if let data = data {
                if let JSONData = try? JSONSerialization.jsonObject(with: data) as? NSArray {
                    for student in JSONData {
                        guard let blankDictionary = student as? [String: Any] else {return}
                        guard let last_Name = blankDictionary["lastName"] as? String else {return}
                        let currentStudent = StudentIDModel(lastName: last_Name)
                        tempArray.append(currentStudent)
                    }
                }
                DispatchQueue.main.async{
                    self.students = tempArray
                }
            }
        }
    }
}
