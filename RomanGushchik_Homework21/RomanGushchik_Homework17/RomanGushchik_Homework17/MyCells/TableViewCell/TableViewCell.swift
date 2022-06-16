//
//  TableViewCell.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 26.05.22.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var nameFolder: UILabel!
    static let key = "TableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        folderImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview().inset(0)
            make.width.height.equalTo(20)
        }
        nameFolder.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview().inset(0)
            make.left.equalTo(folderImage.snp.right).offset(8)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        backgroundColor = isSelected ? .yellow : .white
 
    }
    
}
