//
//  ImageCollectionViewCell.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 4.06.22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let key = "ImageCollectionViewCell"
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        myImage.layer.cornerRadius = 20
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            setSelectedAttribute(isSelected: isSelected)
        }
    }
    func setSelectedAttribute(isSelected: Bool) {
        

        /*
         Проблема была вот тут. Alpha очень криво отрабатывала заменил ее на смену фона и все работает хорошо.
         */
        
       backgroundColor = isSelected ? .gray : .white
    }

}
