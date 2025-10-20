//
//  cameraview.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/14/25.
//

import SwiftUI

struct CaptureImageView: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var images: [UIImage]
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, images: $images)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {}
}
