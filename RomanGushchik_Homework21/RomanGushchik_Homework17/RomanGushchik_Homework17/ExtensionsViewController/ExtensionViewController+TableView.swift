//
//  ExtensionViewController+TableView.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 4.06.22.
//

import Foundation
import UIKit


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        contentOf.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contentOf[section].myContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if contentOf[indexPath.section].type == .image  {
            if let newCell = tableView.dequeueReusableCell(withIdentifier: ImageViewCell.key) as? ImageViewCell {
                newCell.contentImage.image = UIImage(contentsOfFile: contentOf[indexPath.section].myContent[indexPath.row].path)
            return newCell
            }
            return UITableViewCell()
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.key) as? TableViewCell {
                cell.nameFolder.text = contentOf[indexPath.section].myContent[indexPath.row].lastPathComponent
            return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch editState {
        case .navigation:
            myTableView.deselectRow(at: indexPath, animated: true)
            openObject(indexPath)
        case .selection:
            removeButton.isEnabled = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        removeButton.isEnabled = false
       
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if contentOf[section].myContent.isEmpty {
            return ""
        }
        return contentOf[section].type.rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         60
        
    }
    func openObject(_ indexPath: IndexPath) {
        if contentOf[indexPath.section].type == .folder {
            if let viewContrloller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                viewContrloller.catalogURL = contentOf[indexPath.section].myContent[indexPath.row]
                viewContrloller.nameTitle = contentOf[indexPath.section].myContent[indexPath.row].lastPathComponent
                navigationController?.pushViewController(viewContrloller, animated: true)
            }
        } else {
        if let viewController = UIStoryboard(name: "ImageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController {
            viewController.imagesUrl = contentOf[indexPath.section].myContent
            present(viewController, animated: true)
            }
        }
    }
}

