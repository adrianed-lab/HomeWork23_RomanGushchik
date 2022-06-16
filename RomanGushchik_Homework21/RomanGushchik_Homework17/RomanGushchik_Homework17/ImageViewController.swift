//
//  ImageViewController.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 31.05.22.
//

import UIKit
import SnapKit

class ImageViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    var imagesUrl: [URL]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesUrl.forEach { imageUrl in
            let image = UIImage(contentsOfFile: imageUrl.path)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.snp.makeConstraints { make in
                make.height.equalTo(view.snp.height).multipliedBy(1)
                make.width.equalTo(view.snp.width).multipliedBy(1)
                stackView.spacing = 10
                stackView.addArrangedSubview(imageView)
            }
        }
        view.addSubview(scrollView)
    }
}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    stackView
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale < 0 {
            scrollView.zoomScale = 1
        }
    }
}

