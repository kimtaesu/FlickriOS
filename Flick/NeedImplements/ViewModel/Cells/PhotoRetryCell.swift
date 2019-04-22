//
//  LoadingThumbnailCell.swift
//  Flick
//
//  Created by tskim on 02/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class PhotoRetryCell: UICollectionViewCell {
    
    private let retryButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        retryButton.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
            $0.setTitle("Retry", for: .normal)
            
        }
    }
}
