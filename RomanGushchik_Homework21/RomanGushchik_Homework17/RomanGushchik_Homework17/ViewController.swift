//
//  ViewController.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 26.05.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var changeView: UISegmentedControl!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var unlockSelectItems: UIButton!
    @IBOutlet weak var addObjectButton: UIButton!
    let fileManager = FileManager.default
    var myTextField: UITextField!
    var nameTitle: String!
    var catalogURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var contentOfDirectory: [URL]!
    var filtredContentOfDirectory: [URL]!
    var contentOf = [Content]()
    var editState: EditState = .navigation {
        didSet {
            addObjectButton.isEnabled = editState == .navigation
            removeButton.isHidden = editState == .navigation
            removeButton.isEnabled = editState == .navigation
            unlockSelectItems.isSelected = editState == .selection
        }
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.allowsMultipleSelection = true
        removeButton.isHidden = true
        title = nameTitle
        myTableView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellReuseIdentifier: ImageViewCell.key)
        myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCell.key)
        myCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.key)
        myCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.key)
        changeView.addTarget(self, action: #selector(changeMyView), for: .valueChanged)
        contentOfDirectory = try? fileManager.contentsOfDirectory(at: catalogURL, includingPropertiesForKeys: .none)
        filtredContentOfDirectory = contentOfDirectory.filter { !$0.lastPathComponent.hasSuffix(".DS_Store")}
        contentOf.append(Content(type: .folder, myContent: filtredContentOfDirectory.filter({ $0.hasDirectoryPath })))
        contentOf.append(Content(type: .image, myContent: filtredContentOfDirectory.filter({ !$0.hasDirectoryPath })))
        
        print(catalogURL)
    }
    
    @objc func changeMyView(target: UISegmentedControl) {
        if changeView.selectedSegmentIndex == 0 {
            myTableView.isHidden = false
            myCollectionView.isHidden = true
        } else {
            myTableView.isHidden = true
            myCollectionView.isHidden = false
        }
    }
    
    @IBAction func unlockSelectItems(_ sender: Any) {
        if contentOf[0].myContent.count >= 1 || contentOf[1].myContent.count >= 1{
            editState = .selection
        } else {
            return
        }
    }
    
    @IBAction func removeButton(_ sender: Any) {
        if changeView.selectedSegmentIndex == 0 {
            guard myTableView.indexPathsForSelectedRows != nil, let selectedTableViewItems = myTableView.indexPathsForSelectedRows?.sorted(by: {$0 > $1})
                else {
                    return
            }
            selectedTableViewItems.forEach({ index in
            let url = contentOf[index.section].myContent[index.row]
            try? fileManager.removeItem(at: url)
                contentOf[index.section].myContent.remove(at: index.row)
                myTableView.reloadData()
                myCollectionView.reloadData()
            })
        } else {
            guard myCollectionView.indexPathsForSelectedItems != nil, let selectedCollectionViewItems = myCollectionView.indexPathsForSelectedItems?.sorted(by: {$0 > $1})
                else {
                    return
            }
            selectedCollectionViewItems.forEach { index in
            let url = contentOf[index.section].myContent[index.row]
            try? fileManager.removeItem(at: url)
                contentOf[index.section].myContent.remove(at: index.row)
                myCollectionView.reloadData()
                myTableView.reloadData()
            }
        }
        editState = .navigation
    }
        
        
    
    
    
    @IBAction func addObjectButton(_ sender: Any) {
        let chooseAction = UIAlertController(title: "Choose an action!", message: "", preferredStyle: .alert)
        let addImageButton = UIAlertAction(title: "Choose an image", style: .default) { _ in
            self.addImage()
        }
        let addDirectory = UIAlertAction(title: "Create a directory", style: .default) { _ in
            self.addDirectory()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        chooseAction.addAction(addImageButton)
        chooseAction.addAction(addDirectory)
        chooseAction.addAction(cancelButton)
        present(chooseAction, animated: true)
        }
    func addImage() {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        }
    func addDirectory() {
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
                let myCatalogUrl = self.catalogURL.appendingPathComponent(nameFolder.trimmingCharacters(in: .whitespaces))
                try self.fileManager.createDirectory(at: myCatalogUrl, withIntermediateDirectories: false)
                self.contentOf[0].myContent.append(myCatalogUrl)
                self.myTableView.reloadData()
                self.myCollectionView.reloadData()
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
    
}







