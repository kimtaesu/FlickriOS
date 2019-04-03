//
//  CategoryCell.swift
//  Flick
//
//  Created by tskim on 03/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import PinterestLayout
import UIKit

class CategoryCell: UICollectionViewCell, SwiftNameIdentifier {
    let thumbnailView = UIImageView()
    
    private var imageViewHeightLayoutConstraint: NSLayoutConstraint?
    private var imageHeight: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        thumbnailView.do {
            contentView.addSubview($0)
            print("!!!!!!!! \(imageHeight)")
            $0.snp.makeConstraints({ make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(imageHeight)
            })
        }
    }
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            imageHeight = attributes.imageHeight
            if let imageViewHeightLayoutConstraint = self.imageViewHeightLayoutConstraint {
                imageViewHeightLayoutConstraint.constant = attributes.imageHeight
            }
        }
    }
}
