//
//  SecondViewController.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 29.05.22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let fileManager = FileManager.default
    var myTextField: UITextField!
    var myNameTitle: String!
    var myCatalogURL: URL!
    var myContentOfDirectory: [URL]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = myNameTitle
        tableView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellReuseIdentifier: ImageViewCell.key)
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCell.key)
        myContentOfDirectory = try? fileManager.contentsOfDirectory(at: myCatalogURL, includingPropertiesForKeys: .none)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewObjectButton(_ sender: Any) {
        let chooseAction = UIAlertController(title: "Choose an action!", message: "", preferredStyle: .alert)
        let addImageButton = UIAlertAction(title: "Choose an image", style: .default) { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
            
        }
        let addDirectory = UIAlertAction(title: "Create a directory", style: .default) { _ in
            
            let alertMessage = UIAlertController(title: "Create a new catalog", message: "Print a name", preferredStyle: .alert)
                alertMessage.addTextField { (textField) in
                textField.placeholder = "Enter a name folder"
                self.myTextField = textField
                    }
                    
            let okButton = UIAlertAction(title: "Ok", style: .cancel) { _ in
                do {
                    guard let nameFolder = self.myTextField.text
                    else {
                        return
                    }
                    let myCatalogUrl = self.myCatalogURL.appendingPathComponent(nameFolder.trimmingCharacters(in: .whitespaces))
                try self.fileManager.createDirectory(at: myCatalogUrl, withIntermediateDirectories: false)
                    self.myContentOfDirectory.append(myCatalogUrl)
                    self.tableView.reloadData()
                    } catch {
                    let wrongMessage = UIAlertController(title: "The name already exists.", message: "Enter another name.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Ok", style: .cancel)
                        wrongMessage.addAction(okButton)
                        self.present(wrongMessage, animated: true)
                        }
                    }
            let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
            alertMessage.addAction(okButton)
            alertMessage.addAction(cancelButton)
            self.present(alertMessage, animated: true)
    }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        
        chooseAction.addAction(addImageButton)
        chooseAction.addAction(addDirectory)
        chooseAction.addAction(cancelButton)
        present(chooseAction, animated: true)
        
        
    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myContentOfDirectory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if myContentOfDirectory[indexPath.row].path.hasSuffix(".jpeg") || myContentOfDirectory[indexPath.row].path.hasSuffix(".heic") {
            if let newCell = tableView.dequeueReusableCell(withIdentifier: ImageViewCell.key) as? ImageViewCell {
            newCell.contentImage.image = UIImage(contentsOfFile: myContentOfDirectory[indexPath.row].path)
            return newCell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.key) as? TableViewCell {
            cell.nameFolder.text = myContentOfDirectory[indexPath.row].lastPathComponent
            return cell
        
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
        
    }

    }
    
    


extension SecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageURL = info[.imageURL] as? URL, let editedImage = info[.editedImage] as? UIImage {
            let newImageUrl = myCatalogURL.appendingPathComponent(imageURL.lastPathComponent)
            let imageJpegData = editedImage.jpegData(compressionQuality: 1)
            do {
               try imageJpegData?.write(to: newImageUrl)
                myContentOfDirectory.append(newImageUrl)
                tableView.reloadData()
            } catch {
                print("error")

            }
            dismiss(animated: true)
        }
    }
}


