//
//  CrenecksView.swift
//  SchoolInventory
//
//  Created by Haasini Kala R. Police on 2/10/25.
//

import SwiftUI

struct ShirtItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var small: Int
    var medium: Int
    var large: Int
    var imageFilename: String?
}

struct CrewnecksView: View {
    @State private var shirts: [ShirtItem] = []
    
    @State private var selectedShirt: ShirtItem? = nil
    @State private var showEditSheet = false
    @State private var showAddSheet = false

    @State private var editedName: String = ""
    @State private var editedSmall: Int = 0
    @State private var editedMedium: Int = 0
    @State private var editedLarge: Int = 0
    @State private var editedImage: UIImage? = nil
    @State private var editedImageFilename: String? = nil

    @State private var stockAlertMessage = ""
    @State private var showStockAlert = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(shirts) { shirt in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(shirt.name)
                                .font(.headline)

                            if let image = loadImage(filename: shirt.imageFilename) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 120)
                                    .cornerRadius(10)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 120)
                                    .overlay(Text("No Image"))
                            }

                            HStack {
                                Text("S: \(shirt.small)")
                                Text("M: \(shirt.medium)")
                                Text("L: \(shirt.large)")
                            }
                            .font(.subheadline)

                            Button("Edit") {
                                editShirt(shirt)
                            }
                            .font(.caption)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.bottom, 10)
                    }

                    Button(action: checkStock) {
                        Text("Check Stock")
                            .font(.title2)
                            .padding()
                            .background(Color.darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
                .navigationTitle("Crewnecks")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showAddSheet = true
                            clearEditFields()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .alert(isPresented: $showStockAlert) {
                Alert(title: Text("Stock Status"), message: Text(stockAlertMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showEditSheet) {
                editSheet(isNew: false)
            }
            .sheet(isPresented: $showAddSheet) {
                editSheet(isNew: true)
            }
            .onAppear(perform: loadStockData)
        }
    }

    func editShirt(_ shirt: ShirtItem) {
        selectedShirt = shirt
        editedName = shirt.name
        editedSmall = shirt.small
        editedMedium = shirt.medium
        editedLarge = shirt.large
        editedImageFilename = shirt.imageFilename
        editedImage = loadImage(filename: shirt.imageFilename)
        showEditSheet = true
    }

    func saveChanges(isNew: Bool) {
        var filename = editedImageFilename
        
        if let img = editedImage {
            filename = saveImageToDisk(image: img)
        }

        let newShirt = ShirtItem(
            name: editedName,
            small: editedSmall,
            medium: editedMedium,
            large: editedLarge,
            imageFilename: filename
        )
        
        if isNew {
            shirts.append(newShirt)
        } else if let selected = selectedShirt, let index = shirts.firstIndex(of: selected) {
            shirts[index] = newShirt
        }

        saveStockData()
    }

    func checkStock() {
        if shirts.contains(where: { $0.small < 3 || $0.medium < 3 || $0.large < 3 }) {
            stockAlertMessage = "Low stock! Some sizes have less than 3 items."
        } else {
            stockAlertMessage = "Enough stock! All sizes have more than 3 items."
        }
        showStockAlert = true
    }

    func clearEditFields() {
        editedName = ""
        editedSmall = 0
        editedMedium = 0
        editedLarge = 0
        editedImage = nil
        editedImageFilename = nil
    }

    func editSheet(isNew: Bool) -> some View {
        VStack(spacing: 20) {
            Text(isNew ? "Add New Shirt" : "Edit Shirt")
                .font(.title2)

            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
                .overlay(
                    Group {
                        if let img = editedImage {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("Drag an image here")
                        }
                    }
                )
                .onDrop(of: [.image], isTargeted: nil) { providers in
                    if let provider = providers.first {
                        _ = provider.loadObject(ofClass: UIImage.self) { object, _ in
                            if let image = object as? UIImage {
                                DispatchQueue.main.async {
                                    editedImage = image
                                }
                            }
                        }
                        return true
                    }
                    return false
                }

            TextField("Shirt Name", text: $editedName)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Stepper("Small: \(editedSmall)", value: $editedSmall, in: 0...100)
            Stepper("Medium: \(editedMedium)", value: $editedMedium, in: 0...100)
            Stepper("Large: \(editedLarge)", value: $editedLarge, in: 0...100)

            Button(action: {
                saveChanges(isNew: isNew)
                if isNew {
                    showAddSheet = false
                } else {
                    showEditSheet = false
                }
            }) {
                Text("Save")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.darkOrange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                if isNew {
                    showAddSheet = false
                } else {
                    showEditSheet = false
                }
            }) {
                Text("Cancel")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.darkBrown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    // MARK: - Image File Saving & Loading

    func saveImageToDisk(image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            try data.write(to: url)
            return filename
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }

    func loadImage(filename: String?) -> UIImage? {
        guard let filename = filename else { return nil }
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return UIImage(contentsOfFile: url.path)
    }

    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    // MARK: - UserDefaults Persistence

    func saveStockData() {
        let data = shirts.map { [
            "id": $0.id.uuidString,
            "name": $0.name,
            "small": $0.small,
            "medium": $0.medium,
            "large": $0.large,
            "imageFilename": $0.imageFilename ?? ""
        ]}
        UserDefaults.standard.set(data, forKey: "shirtsData")
    }

    func loadStockData() {
        if let data = UserDefaults.standard.array(forKey: "shirtsData") as? [[String: Any]] {
            shirts = data.compactMap { dict in
                guard let name = dict["name"] as? String,
                      let small = dict["small"] as? Int,
                      let medium = dict["medium"] as? Int,
                      let large = dict["large"] as? Int else { return nil }

                let filename = dict["imageFilename"] as? String
                return ShirtItem(name: name, small: small, medium: medium, large: large, imageFilename: filename)
            }
        }
    }
}

#Preview {
    CrewnecksView()
}
