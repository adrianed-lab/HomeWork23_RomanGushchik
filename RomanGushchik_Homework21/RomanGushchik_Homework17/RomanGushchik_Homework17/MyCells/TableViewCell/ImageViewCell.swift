//
//  ImageViewCell.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 29.05.22.
//

import UIKit

class ImageViewCell: UITableViewCell {
    static let key = "ImageViewCell"
    @IBOutlet weak var contentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
