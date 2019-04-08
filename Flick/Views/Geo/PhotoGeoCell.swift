//
//  PhotoGeoCell.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class PhotoGeoCell: UICollectionViewCell, SwiftNameIdentifier {
    
    let photoView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView.do {
            $0.contentMode = .scaleToFill
            contentView.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }
}

extension PhotoGeoCell {
    func configCell(_ photo: Photo) {
        if let thumbnail = photo.nearHeightByWidth(width: 300) {
            photoView.kf.setImage(
                with: URL(string: thumbnail.imageUrl),
                placeholder: nil,
                options: [],
                progressBlock: { receivedSize, totalSize in
                    logger.info("progressBlock: \(photo)")
                },
                completionHandler: { result in
                    logger.info(result)
                    logger.info("completionHandler: \(thumbnail): Finished")
                }
            )
        }
    }
}
