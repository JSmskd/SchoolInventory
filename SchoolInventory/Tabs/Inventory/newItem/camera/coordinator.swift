//
//  coordinator.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/14/25.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: Image?
    @Binding var images: [UIImage]
    
    init(isShown: Binding<Bool>, image: Binding<Image?>, images: Binding<[UIImage]>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
        _images = images
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        images.append(unwrapImage)
        imageInCoordinator = Image(uiImage: unwrapImage)
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
