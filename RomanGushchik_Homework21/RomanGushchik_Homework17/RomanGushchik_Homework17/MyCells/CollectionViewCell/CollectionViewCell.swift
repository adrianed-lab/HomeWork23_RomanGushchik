//
//  CollectionViewCell.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 4.06.22.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    static let key = "CollectionViewCell"
    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var collectionNameFolder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        folderImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(0)
            make.width.height.equalTo(25)
        }
        collectionNameFolder.snp.makeConstraints { make in
            make.center.equalToSuperview().inset(0)
            make.top.equalTo(folderImage.snp.bottom).offset(8)
        }
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


