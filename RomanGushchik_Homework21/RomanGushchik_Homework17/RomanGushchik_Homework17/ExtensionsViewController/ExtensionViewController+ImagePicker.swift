//
//  ExtensionViewController+ImagePicker.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 4.06.22.
//

import Foundation
import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageURL = info[.imageURL] as? URL, let image = info[.originalImage] as? UIImage {
            let newImageUrl = catalogURL.appendingPathComponent(imageURL.lastPathComponent)
            let imageJpegData = image.jpegData(compressionQuality: 1)
            do {
               try imageJpegData?.write(to: newImageUrl)
                contentOf[1].myContent.append(newImageUrl)
                myTableView.reloadData()
                myCollectionView.reloadData()
            } catch {
                print("error")

            }
            dismiss(animated: true)
        }
    }
}
