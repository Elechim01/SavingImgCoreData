//
//  ImagePicker.swift
//  SavingImgCoreData
//
//  Created by Michele on 14/01/21.
//

import Foundation
import SwiftUI
import Combine
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var show : Bool
    @Binding var image : Data
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(image: $image,show: $show)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @Binding var image : Data
    @Binding var show : Bool
    
    init(image : Binding<Data>, show : Binding<Bool>) {
        self._image = image
        self._show = show
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.show.toggle()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        let data = image.jpegData(compressionQuality: 1.0)
        self.image = data!
        self.show.toggle()
    
        }
    }
}
