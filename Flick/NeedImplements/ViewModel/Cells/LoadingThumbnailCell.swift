//
//  LoadingThumbnailCell.swift
//  Flick
//
//  Created by tskim on 02/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class LoadingThumbnailCell: UICollectionViewCell {
    
    private let thumbnailView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        thumbnailView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
            $0.image = Asset.icHideKeyboard.image
        }
    }
}
