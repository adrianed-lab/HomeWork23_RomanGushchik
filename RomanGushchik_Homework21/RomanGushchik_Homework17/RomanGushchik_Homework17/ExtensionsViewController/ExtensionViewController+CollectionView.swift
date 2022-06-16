//
//  ExtensionViewController+CollectionView.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 4.06.22.
//

import Foundation
import UIKit



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        contentOf.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentOf[section].myContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if contentOf[indexPath.section].type == .image  {
            if let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.key, for: indexPath) as? ImageCollectionViewCell {
            newCell.myImage.image = UIImage(contentsOfFile: contentOf[indexPath.section].myContent[indexPath.row].path)
            return newCell
            }
        return UICollectionViewCell()
        }
        else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.key, for: indexPath) as? CollectionViewCell {
            cell.setSelectedAttribute(isSelected: myCollectionView.indexPathsForSelectedItems!.contains { $0 == indexPath })
            cell.collectionNameFolder.text = contentOf[indexPath.section].myContent[indexPath.row].lastPathComponent
            cell.layer.cornerRadius = 20
            return cell
            }
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch editState {
        case .navigation:
            myCollectionView.deselectItem(at: indexPath, animated: true)
            openObject(indexPath)
        case .selection:
            removeButton.isEnabled.toggle()
        }
        }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        removeButton.isEnabled = false
    }
}
